Class {
	#name : #DASLMakeTupleType,
	#superclass : #DASLExpression,
	#instVars : [
		'elements',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLMakeTupleType >> accept: aVisitor [
	^ aVisitor visitMakeTupleType: self
]

{ #category : #accessing }
DASLMakeTupleType >> elements [
	^ elements
]

{ #category : #accessing }
DASLMakeTupleType >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
DASLMakeTupleType >> type [
	^ type
]

{ #category : #accessing }
DASLMakeTupleType >> type: anObject [
	type := anObject
]
