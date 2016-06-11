Class {
	#name : #DASLTypeSubscriptExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'type',
		'reference',
		'bounds'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'as yet unclassified' }
DASLTypeSubscriptExpression >> accept: aVisitor [
	^ aVisitor visitTypeSubscriptExpression: self
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> bounds [
	^ bounds
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> bounds: anObject [
	bounds := anObject
]

{ #category : #'as yet unclassified' }
DASLTypeSubscriptExpression >> printOn: aStream [
	aStream nextPutAll: '(array '.
	reference printOn: aStream.
	aStream space.
	bounds printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> type [
	^ type
]

{ #category : #accessing }
DASLTypeSubscriptExpression >> type: aType [
	type := aType
]
