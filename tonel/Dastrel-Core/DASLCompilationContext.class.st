Class {
	#name : #DASLCompilationContext,
	#superclass : #Object,
	#instVars : [
		'translationUnits',
		'lineInfoCache',
		'shaderSignatures',
		'includeDirectories',
		'compilationTarget'
	],
	#category : #'Dastrel-Core-Compiler'
}

{ #category : #adding }
DASLCompilationContext >> addIncludeDirectories: aCollectionOfDirectories [
	aCollectionOfDirectories do: [ :dir | self addIncludeDirectory: dir ]
]

{ #category : #adding }
DASLCompilationContext >> addIncludeDirectory: directory [
	includeDirectories add: directory asFileReference
]

{ #category : #adding }
DASLCompilationContext >> addTranslationUnit: aTranslationUnit [
	translationUnits at: aTranslationUnit fullPath put: aTranslationUnit
]

{ #category : #accessing }
DASLCompilationContext >> compilationTarget [
	^ compilationTarget
]

{ #category : #accessing }
DASLCompilationContext >> compilationTarget: anObject [
	compilationTarget := anObject
]

{ #category : #initialization }
DASLCompilationContext >> createLineColumnInfoFor: aFileName [
	| lineInfo currentLine c |
	lineInfo := OrderedCollection new.
	currentLine := 1.
	lineInfo add: { 1 . 1 }.
	aFileName asFileReference readStreamDo: [:in |
		[ in atEnd ] whileFalse: [
			c := in next.
			c = Character cr ifTrue: [
				currentLine := currentLine + 1.
				in peek = Character lf ifTrue: [ in next ].
				lineInfo add: { in position . currentLine }.
			] ifFalse: [
				c = Character lf ifTrue: [
					currentLine := currentLine + 1.
					lineInfo add: { in position . currentLine }.
				]
			].		
		]
	].

	^ lineInfo asArray
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> importTranslationUnit: fileReference [
	| fullPath |
	fullPath := fileReference asFileReference asAbsolute fullName.
	^ translationUnits at: fullPath ifAbsent: [
		^ DASLCompiler new
			compilationContext: self;
  	 		sourceFromFileNamed: fileReference;
   		 	importCompilation
	] 
	
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> importTranslationUnit: fileReference fromDirectory: currentDirectory [
	^ self importTranslationUnit: (self solveImportPath: fileReference fromDirectory: currentDirectory)
]

{ #category : #accessing }
DASLCompilationContext >> includeDirectories [
	^ includeDirectories
]

{ #category : #initialization }
DASLCompilationContext >> initialize [
	super initialize.
	translationUnits := Dictionary new.
	lineInfoCache := Dictionary new.
	shaderSignatures := Dictionary new.
	includeDirectories := OrderedCollection new.
	compilationTarget := SLVMCompilationTarget spirv_logical32
]

{ #category : #initialization }
DASLCompilationContext >> lineColumnInfoFor: aFileName [
	^ lineInfoCache at: aFileName ifAbsentPut: [ self createLineColumnInfoFor: aFileName ]
]

{ #category : #initialization }
DASLCompilationContext >> parseError: ppFailure sourceCode: sourceCode [
	| position |
	position := DASLCodePosition new
		start: ppFailure position;
		stop: ppFailure position;
		collection: sourceCode;
		yourself.
	DASLParsingError new
		position: position;
		messageText: ppFailure message;
		signal
]

{ #category : #initialization }
DASLCompilationContext >> positionFromOffset: fileOffset fileName: fileName [
	| lineColumnInfo lowerBound line column |
	lineColumnInfo := self lineColumnInfoFor: fileName.
	lowerBound := lineColumnInfo findBinary: [:el | fileOffset - el first] do: [ :i | i ] ifNone: [ :lower :upper | lower ].
	
	line := lowerBound second.
	column := fileOffset - lowerBound first + 1.
	^ DASLCodePosition new
		start: fileOffset;
		stop: fileOffset;
		line: line;
		column: column;
		fileName: fileName;
		yourself
]

{ #category : #accessing }
DASLCompilationContext >> processedDependencies [
	^ translationUnits keys
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> shaderSignatures [
	^ shaderSignatures
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> solveImportPath: fileReference fromDirectory: currentDirectory [
	| solvedPath |
	fileReference isAbsolute ifTrue: [ ^ fileReference ].
	
	solvedPath := currentDirectory resolve: fileReference.
	solvedPath exists ifTrue: [ ^ solvedPath ].
	
	includeDirectories do: [ :includeDir |
		solvedPath := includeDir resolve: fileReference.
		solvedPath exists ifTrue: [ ^ solvedPath ].
	].
	
	^ fileReference
]
