Class {
	#name : #DASLCallExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'arguments'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLCallExpression >> accept: aVisitor [
	^ aVisitor visitCallExpression: self
]

{ #category : #accessing }
DASLCallExpression >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLCallExpression >> arguments: anObject [
	arguments := anObject
]

{ #category : #printing }
DASLCallExpression >> printOn: aStream [
	aStream nextPutAll: '(apply '.
	reference printOn: aStream.
	aStream space.
	self printList: arguments on: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLCallExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLCallExpression >> reference: anObject [
	reference := anObject
]
