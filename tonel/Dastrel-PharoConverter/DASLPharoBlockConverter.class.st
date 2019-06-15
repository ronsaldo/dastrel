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
		'argumentTypeNodes'
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
	| closureNode closurePosition copiedVariables |
	closureNode := closure sourceNode.
	sourceCollection := closureNode source asDastrelCollectionWithContext.
	closurePosition := closureNode asDASLCodePositionWithCollection: sourceCollection.
	
	copiedVariables := closureNode scope copiedVars asArray.
	capturedVariables := copiedVariables collectWithIndex: [ :variable :index|
		DASLPharoBlockConverterCapturedVariable new
			position: closurePosition;
			context: self;
			name: variable name;
			value: (closure at: index);
			yourself
	].
	
	argumentTypes := argumentTypeNames collect: [ :argumentTypeDesc |
		codeConverter evaluateTypeSpecification: argumentTypeDesc
	] as: Array.
	argumentTypeNodes := argumentTypes collect: [:argType | (argType asDastrelTypeNode) position: closurePosition].
	
	returnType := DASLIdentifier new value: returnTypeName; position: closurePosition; yourself.
	
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
