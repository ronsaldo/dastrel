Class {
	#name : #DASLAssignmentExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'operation',
		'reference',
		'value'
	],
	#category : #'Dastrel-Core'
}

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
DASLAssignmentExpression >> value [
	^ value
]

{ #category : #accessing }
DASLAssignmentExpression >> value: anObject [
	value := anObject
]
