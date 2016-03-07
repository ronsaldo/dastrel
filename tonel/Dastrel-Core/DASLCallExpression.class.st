Class {
	#name : #DASLCallExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'arguments',
		'solvedFunction',
		'type'
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

{ #category : #accessing }
DASLCallExpression >> solvedFunction [
	^ solvedFunction
]

{ #category : #accessing }
DASLCallExpression >> solvedFunction: anObject [
	solvedFunction := anObject
]

{ #category : #accessing }
DASLCallExpression >> type [
	^ type
]

{ #category : #accessing }
DASLCallExpression >> type: anObject [
	type := anObject
]
