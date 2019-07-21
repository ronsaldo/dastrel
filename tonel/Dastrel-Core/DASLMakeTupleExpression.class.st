Class {
	#name : #DASLMakeTupleExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'elements',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLMakeTupleExpression >> accept: aVisitor [
	^ aVisitor visitMakeTupleExpression: self
]

{ #category : #accessing }
DASLMakeTupleExpression >> elements [
	^ elements
]

{ #category : #accessing }
DASLMakeTupleExpression >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
DASLMakeTupleExpression >> type [
	^ type
]

{ #category : #accessing }
DASLMakeTupleExpression >> type: anObject [
	type := anObject
]
