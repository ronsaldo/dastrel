Class {
	#name : #DASLBuildShaderStage,
	#superclass : #DASLBuildItem,
	#instVars : [
		'targetLanguages',
		'destinationFolder',
		'sourceFolder'
	],
	#classVars : [
		'LanguageDictionary',
		'StageSuffixMap'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #initialization }
DASLBuildShaderStage class >> initialize [
	"
	self initialize
	"
	
	LanguageDictionary := Dictionary newFromPairs: #(
		'spir-v' (spirVTarget spv false)
		glsl (glslTarget glsl true)
		metal (metalTarget metal false)
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
DASLBuildShaderStage >> addTargetLanguage: targetLanguage [
	| languageInfo targetSelector targetExtension addStageSuffix destinationName destinationFullName |
	
	languageInfo := LanguageDictionary at: targetLanguage.
	targetSelector := languageInfo first.
	targetExtension := languageInfo second asString.
	addStageSuffix := languageInfo third.
	
	destinationName := sources first fileReference withExtension: targetExtension.
	destinationFullName := destinationFolder resolve: (destinationName relativeTo: sourceFolder).
	addStageSuffix ifTrue: [ 
		destinationFullName := destinationFullName , (StageSuffixMap at: name)
	].
		
	targetLanguages add: { targetLanguage .targetSelector . destinationFullName }.
	self targets: self targets , { destinationFullName }
]

{ #category : #'as yet unclassified' }
DASLBuildShaderStage >> build [
	| targetSelector destinationFullName compiler result |
	targetLanguages do: [ :target |
		targetSelector := target second.
		destinationFullName := target third.
		
		compiler := DASLCompiler new.
		compiler sourceFromFileNamed: sources first fileReference.
		compiler perform: targetSelector.
		[
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

		] on: DASLCompilationError do: [ :error |
			error printCompilationError.
			^ self
		]
	].
]

{ #category : #'as yet unclassified' }
DASLBuildShaderStage >> createStageMetaData [
	| result targetName targetFileReference |
	result := OrderedDictionary new.
	targetLanguages do: [ :target |
		targetName := target first.
		targetFileReference := target third relativeTo: destinationFolder.
		result at: targetName put: (self relativePathToString: targetFileReference)
	].
	^ result
]

{ #category : #accessing }
DASLBuildShaderStage >> destinationFolder [
	^ destinationFolder
]

{ #category : #accessing }
DASLBuildShaderStage >> destinationFolder: anObject [
	destinationFolder := anObject
]

{ #category : #initialization }
DASLBuildShaderStage >> initialize [
	super initialize.
	targetLanguages := OrderedCollection new.
]

{ #category : #accessing }
DASLBuildShaderStage >> sourceFolder [
	^ sourceFolder
]

{ #category : #accessing }
DASLBuildShaderStage >> sourceFolder: anObject [
	sourceFolder := anObject
]

{ #category : #accessing }
DASLBuildShaderStage >> targetLanguages [
	^ targetLanguages
]
