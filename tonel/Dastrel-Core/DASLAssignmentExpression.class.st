Class {
	#name : #DASLAssignmentExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'operation',
		'reference',
		'value',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLAssignmentExpression >> accept: aVisitor [
	^ aVisitor visitAssignment: self
]

{ #category : #accessing }
DASLAssignmentExpression >> operation [
	^ operation
]

{ #category : #accessing }
DASLAssignmentExpression >> operation: anObject [
	operation := anObject
]

{ #category : #printing }
DASLAssignmentExpression >> printOn: aStream [
	aStream nextPut: $(.
	aStream nextPutAll: operation.
	aStream space.
	reference printOn: aStream.
	aStream space.
	value printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLAssignmentExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLAssignmentExpression >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
DASLAssignmentExpression >> type [
	^ type
]

{ #category : #accessing }
DASLAssignmentExpression >> type: anObject [
	type := anObject
]

{ #category : #accessing }
DASLAssignmentExpression >> value [
	^ value
]

{ #category : #accessing }
DASLAssignmentExpression >> value: anObject [
	value := anObject
]
