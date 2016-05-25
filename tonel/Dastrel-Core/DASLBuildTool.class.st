Class {
	#name : #DASLBuildTool,
	#superclass : #Object,
	#instVars : [
		'compiler'
	],
	#classVars : [
		'StageSuffixMap',
		'TargetList'
	],
	#category : #'Dastrel-Core-Compiler'
}

{ #category : #'as yet unclassified' }
DASLBuildTool class >> compileShaders: shaderJson toDestination: destinationFolder [
	^ self new compileShaders: shaderJson toDestination: destinationFolder

]

{ #category : #'class initialization' }
DASLBuildTool class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	TargetList := #(
		(spirVTarget 'spir-v' spv false)
		(glslTarget glsl glsl true)
	).
	
	StageSuffixMap := Dictionary newFromPairs: #(
		'vertex' 'vert'
 	   'tessellation-control' 'tesc'
		'tessellation-evaluation' 'tese'
    	'geometry' 'geom'
    	'fragment' 'frag'
    	'compute' 'comp'
	)
]

{ #category : #'as yet unclassified' }
DASLBuildTool >> buildShaderStages: stages sourceDirectory: sourceDirectory destinationDirectory: destinationDirectory [
	| fullShaderSource targetSelector targetName targetExtension destinationName result stageImplementations destinationFullName addStageSuffix |
	stages keysAndValuesDo: [ :stage :shaderSourceName |
		fullShaderSource := sourceDirectory / shaderSourceName.
		stageImplementations := Dictionary new.
		TargetList do: [ :target |
			targetSelector := target first.
			targetName := target second asString.
			targetExtension := target third asString.
			addStageSuffix := target fourth.
			
			destinationName := shaderSourceName asFileReference withExtension: targetExtension.
			destinationFullName := destinationDirectory resolve: destinationName.
			addStageSuffix ifTrue: [ 
				destinationFullName := destinationFullName , (StageSuffixMap at: stage)
			].
			stageImplementations at: targetName put: destinationFullName basename.

			compiler := DASLCompiler new.
			compiler sourceFromFileNamed: fullShaderSource.
			compiler perform: targetSelector.
			compiler compile.
			result := compiler generatedCode.
			result isString ifTrue: [
				destinationFullName writeStreamDo: [ :out |
					out truncate.
					out nextPutAll: result.
				]
			] ifFalse: [
				result saveTo: destinationFullName
			].
		].
		stages at: stage put: stageImplementations.
	]
]

{ #category : #'as yet unclassified' }
DASLBuildTool >> compileShaders: shaderJsonFileName toDestination: destinationFolderName [
	| shaderJsonReference sourceFolder destinationFolder shaderJson shadersName sourceFile destinationFile destinationJsonFile |
	shaderJsonReference := shaderJsonFileName asFileReference asAbsolute.
	destinationFolder := destinationFolderName asFileReference asAbsolute.
	self assert: shaderJsonReference isFile.
	self assert: destinationFolder isDirectory.
	sourceFolder := shaderJsonReference parent.
	self assert: sourceFolder isDirectory.
	
	shaderJson := NeoJSONReader fromString: shaderJsonReference contents.
	shaderJson at: 'groups' ifPresent: [ :groups |
		groups keysAndValuesDo: [ :groupName :rawShaderName |
			shadersName := rawShaderName asFileReference.
			sourceFile := sourceFolder resolve: shadersName.
			destinationFile := destinationFolder resolve: shadersName.
			
			self class compileShaders: sourceFile toDestination: destinationFile parent.
		]
	].

	shaderJson at: 'shaders' ifPresent: [ :shaders |
		shaders keysAndValuesDo: [ :shaderName :stages |
			self buildShaderStages: stages sourceDirectory: sourceFolder destinationDirectory: destinationFolder.
		]
	].

	destinationJsonFile := destinationFolder / shaderJsonReference basename.
	destinationJsonFile writeStreamDo: [ :out |
		out truncate.
		(NeoJSONWriter on: out) prettyPrint: true; nextPut: shaderJson
	]

]
