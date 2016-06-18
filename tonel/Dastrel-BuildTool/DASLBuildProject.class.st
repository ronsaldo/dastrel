Class {
	#name : #DASLBuildProject,
	#superclass : #DASLBuildItem,
	#instVars : [
		'targetLanguages',
		'shaders',
		'shaderStages',
		'subprojects'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #'as yet unclassified' }
DASLBuildProject class >> fromFileNamed: fileName [
	^ self new loadFromFileNamed: fileName
]

{ #category : #'as yet unclassified' }
DASLBuildProject class >> loadFromFileNamed: fileName [
	^ self new loadFromFileNamed: fileName
]

{ #category : #'as yet unclassified' }
DASLBuildProject class >> loadFromFileNamed: fileName toDestination: destinationFolderName [
	^ self new loadFromFileNamed: fileName toDestination: destinationFolderName
]

{ #category : #adding }
DASLBuildProject >> addShader: shaderItem [
	shaders add: shaderItem.
	self addDependency: shaderItem.
]

{ #category : #adding }
DASLBuildProject >> addShader: shaderName stages: stages sourceDirectory: sourceFolder destinationDirectory: destinationFolder [
	| shader |
	shader := DASLBuildShader new name: shaderName.
	shader addStages: (self createShaderStages: stages sourceDirectory: sourceFolder destinationDirectory: destinationFolder).
	self addShader: shader.
]

{ #category : #adding }
DASLBuildProject >> addSubProject: subProject [
	self addDependency: subProject.
	subprojects add: subProject
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> build [
	| builtMetaData projectsMetaData shadersMetaData |
	builtMetaData := OrderedDictionary new.
	projectsMetaData := self createSubProjectsMetaData.
	projectsMetaData ifNotEmpty: [ 
		builtMetaData at: 'groups' put: projectsMetaData.
	].

	shadersMetaData := self createShadersMetaData.
	shadersMetaData ifNotEmpty: [ 
		builtMetaData at: 'shaders' put: shadersMetaData.
	].

	targets first writeStreamDo: [ :out |
		out truncate.
		(NeoJSONWriter on: out) prettyPrint: true; newLine: String lf; nextPut: builtMetaData
	]

]

{ #category : #'as yet unclassified' }
DASLBuildProject >> createShaderStage: stage sourceDirectory: sourceFolder destinationDirectory: destinationFolder [
	| fullShaderSourceReference stageItem |
	^ shaderStages at: stage ifAbsentPut: [
		fullShaderSourceReference := sourceFolder / stage value.
		stageItem := DASLBuildShaderStage new
			name: stage key;
			sources: { fullShaderSourceReference };
			sourceFolder: sourceFolder;
			destinationFolder: destinationFolder;
			yourself.
		
		self currentTargetLanguages do: [ :target |
			stageItem addTargetLanguage: target
		].
	
		stageItem
	] 
	
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> createShaderStages: stages sourceDirectory: sourceFolder destinationDirectory: destinationFolder [
	^ stages associations collect: [ :stage | self createShaderStage: stage sourceDirectory: sourceFolder destinationDirectory: destinationFolder
 ]
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> createShadersMetaData [
	| result |
	result := OrderedDictionary new.
	shaders do: [ :shader |
		result at: shader name put: shader createStagesMetaData
	].

	^ result
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> createSubProjectsMetaData [
	| result myFolder |
	result := OrderedDictionary new.
	myFolder := targets first parent.
	subprojects do: [ :sp |
		result at: sp name put: (self relativePathToString: (sp targets first relativeTo: myFolder))
	].
	^ result
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> currentTargetLanguages [
	^ targetLanguages
]

{ #category : #initialization }
DASLBuildProject >> initialize [
	super initialize.
	shaders := OrderedCollection new.
	subprojects := OrderedCollection new.
	shaderStages := Dictionary new.
	name := ''.
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> loadFromFileNamed: fileName [
	self loadFromFileNamed: fileName toDestination: FileSystem workingDirectory
]

{ #category : #'as yet unclassified' }
DASLBuildProject >> loadFromFileNamed: fileName toDestination: destinationFolderName [
	| projectJsonReference destinationFolder sourceFolder projectJson subprojectFile subDestinationFile destinationJsonFile |
	projectJsonReference := fileName asFileReference asAbsolute.
	destinationFolder := destinationFolderName asFileReference asAbsolute.
	self assert: projectJsonReference isFile.
	self assert: destinationFolder isDirectory.
	
	sourceFolder := projectJsonReference parent.
	projectJson := (NeoJSONReader on: projectJsonReference contents readStream) mapClass: OrderedDictionary; next.
	
	projectJson at: 'destination' ifPresent: [ :destination |
		destinationFolder := (sourceFolder resolve: destination asFileReference) asAbsolute.
	].
	projectJson at: 'target-languages' ifPresent: [ :newTargets |
		targetLanguages := newTargets
	].

	destinationJsonFile := destinationFolder / projectJsonReference basename.
	self sources: { projectJsonReference }.
	self targets: { destinationJsonFile }.

	projectJson at: 'groups' ifPresent: [ :groups |
		groups keysAndValuesDo: [ :groupName :rawProjectFileName |
			subprojectFile := sourceFolder resolve: rawProjectFileName asFileReference.
			subDestinationFile := destinationFolder resolve: (subprojectFile relativeTo: sourceFolder).
			
			self addSubProject: (self class new
				name: groupName;
				targetLanguages: targetLanguages;
				loadFromFileNamed: subprojectFile toDestination: subDestinationFile parent;
				yourself)
		]
	].

	projectJson at: 'shaders' ifPresent: [ :newShaders |
		newShaders keysAndValuesDo: [ :shaderName :stages |
			self addShader: shaderName stages: stages sourceDirectory: sourceFolder destinationDirectory: destinationFolder
		]
	].

]

{ #category : #accessing }
DASLBuildProject >> targetLanguages [
	^ targetLanguages
]

{ #category : #accessing }
DASLBuildProject >> targetLanguages: anObject [
	^ targetLanguages := anObject
]
