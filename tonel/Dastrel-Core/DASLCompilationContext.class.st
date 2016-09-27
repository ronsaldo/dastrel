Class {
	#name : #DASLCompilationContext,
	#superclass : #Object,
	#instVars : [
		'translationUnits',
		'lineInfoCache',
		'shaderSignatures'
	],
	#category : #'Dastrel-Core-Compiler'
}

{ #category : #adding }
DASLCompilationContext >> addTranslationUnit: aTranslationUnit [
	translationUnits at: aTranslationUnit fullPath put: aTranslationUnit
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

{ #category : #initialization }
DASLCompilationContext >> initialize [
	super initialize.
	translationUnits := Dictionary new.
	lineInfoCache := Dictionary new.
	shaderSignatures := Dictionary new.
]

{ #category : #initialization }
DASLCompilationContext >> lineColumnInfoFor: aFileName [
	^ lineInfoCache at: aFileName ifAbsentPut: [ self createLineColumnInfoFor: aFileName ]
]

{ #category : #initialization }
DASLCompilationContext >> parseError: ppFailure fileName: fileName [
	| position |
	position := self positionFromOffset: ppFailure position fileName: fileName.
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
		offset: fileOffset;
		line: line;
		column: column;
		fileName: fileName;
		yourself
]

{ #category : #initialization }
DASLCompilationContext >> positionFromToken: token fileName: fileName [
	^ self positionFromOffset: token start fileName: fileName
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> shaderSignatures [
	^ shaderSignatures
]
