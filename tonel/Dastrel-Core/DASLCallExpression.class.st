Class {
	#name : #DASLCallExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'arguments'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLCallExpression >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLCallExpression >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
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
