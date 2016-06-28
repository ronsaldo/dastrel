Class {
	#name : #DASLSubscriptExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'index',
		'type',
		'coercionType'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLSubscriptExpression >> accept: aVisitor [
	^ aVisitor visitSubscriptExpression: self
]

{ #category : #accessing }
DASLSubscriptExpression >> coercionType [
	^ coercionType
]

{ #category : #accessing }
DASLSubscriptExpression >> coercionType: anObject [
	coercionType := anObject
]

{ #category : #accessing }
DASLSubscriptExpression >> index [
	^ index
]

{ #category : #accessing }
DASLSubscriptExpression >> index: anObject [
	index := anObject
]

{ #category : #printing }
DASLSubscriptExpression >> printOn: aStream [
	aStream nextPutAll: '(at '.
	reference printOn: aStream.
	aStream space.
	index printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLSubscriptExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLSubscriptExpression >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
DASLSubscriptExpression >> type [
	^ type
]

{ #category : #accessing }
DASLSubscriptExpression >> type: aType [
	type := aType
]
