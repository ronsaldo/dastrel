Class {
	#name : #DASLPharoBlockConverter,
	#superclass : #Object,
	#instVars : [
		'codeConverter',
		'argumentTypes',
		'functionName',
		'returnType',
		'sourceCollection',
		'capturedVariables',
		'argumentTypeNodes',
		'astBuilder'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverter >> argumentTypeNodes [
	^ argumentTypeNodes
]

{ #category : #accessing }
DASLPharoBlockConverter >> argumentTypeNodes: anObject [
	argumentTypeNodes := anObject
]

{ #category : #accessing }
DASLPharoBlockConverter >> argumentTypes [
	^ argumentTypes
]

{ #category : #accessing }
DASLPharoBlockConverter >> argumentTypes: anObject [
	argumentTypes := anObject
]

{ #category : #accessing }
DASLPharoBlockConverter >> astBuilder [
	^ astBuilder ifNil: [ astBuilder := DASLAstBuilder new ]
]

{ #category : #accessing }
DASLPharoBlockConverter >> capturedVariables [
	^ capturedVariables
]

{ #category : #accessing }
DASLPharoBlockConverter >> capturedVariables: anObject [
	capturedVariables := anObject
]

{ #category : #accessing }
DASLPharoBlockConverter >> codeConverter [
	^ codeConverter
]

{ #category : #accessing }
DASLPharoBlockConverter >> codeConverter: anObject [
	codeConverter := anObject
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverter >> convertClosure: closure argumentTypes: argumentTypeNames returnType: returnTypeName [
	| closureNode closurePosition copiedVariables returnTypeConversionBlock |
	closureNode := closure sourceNode.
	sourceCollection := closureNode source asDastrelCollectionWithContext.
	closurePosition := closureNode asDASLCodePositionWithCollection: sourceCollection.
	
	copiedVariables := ((closureNode scope respondsTo: #inComingCopiedVarNames)
		ifTrue: [ closureNode scope inComingCopiedVarNames asArray ]
		ifFalse: [ closureNode scope inComingCopiedVars asArray collect: [:each | each name]]) .

	capturedVariables := copiedVariables collectWithIndex: [ :variable :index|
		DASLPharoBlockConverterCapturedVariable new
			position: closurePosition;
			context: self;
			name: variable;
			value: (closure at: index);
			yourself
	].
	
	argumentTypes := argumentTypeNames collect: [ :argumentTypeDesc |
		codeConverter evaluateTypeSpecification: argumentTypeDesc
	] as: Array.
	argumentTypeNodes := argumentTypes collect: [:argType | (argType asDastrelTypeNode) position: closurePosition].
	
	returnTypeConversionBlock := [:typeName | (codeConverter evaluateTypeSpecification: typeName)
			asDastrelTypeNode position: closurePosition ].
	returnType := returnTypeName isArray
		ifTrue: [ returnTypeName collect: returnTypeConversionBlock ]
		ifFalse: [ {returnTypeConversionBlock value: returnTypeName} ].
	
	
	^ DASLPharoBlockConverterVisitor new
		codeConverter: codeConverter;
		context: self;
		convertBlock: closureNode
]

{ #category : #accessing }
DASLPharoBlockConverter >> functionName [
	^ functionName
]

{ #category : #accessing }
DASLPharoBlockConverter >> functionName: anObject [
	functionName := anObject
]

{ #category : #accessing }
DASLPharoBlockConverter >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLPharoBlockConverter >> returnType: anObject [
	returnType := anObject
]

{ #category : #accessing }
DASLPharoBlockConverter >> sourceCollection [
	^ sourceCollection
]

{ #category : #accessing }
DASLPharoBlockConverter >> sourceCollection: anObject [
	sourceCollection := anObject
]
