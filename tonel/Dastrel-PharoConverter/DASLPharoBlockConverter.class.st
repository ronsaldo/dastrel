Class {
	#name : #DASLPharoBlockConverter,
	#superclass : #Object,
	#instVars : [
		'argumentTypes',
		'functionName',
		'returnType',
		'sourceCollection',
		'capturedVariables'
	],
	#category : #'Dastrel-PharoConverter'
}

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
	
	argumentTypes := argumentTypeNames collect: [ :name | DASLIdentifier new value: name; position: closurePosition; yourself ] as: Array.
	returnType := DASLIdentifier new value: returnTypeName; position: closurePosition; yourself.
	
	^ DASLPharoBlockConverterVisitor new context: self;
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
