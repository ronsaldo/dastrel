Class {
	#name : #DASLMakeReferenceType,
	#superclass : #DASLExpression,
	#instVars : [
		'baseType',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLMakeReferenceType >> accept: aVisitor [
	^ aVisitor visitMakeReferenceType: self
]

{ #category : #accessing }
DASLMakeReferenceType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLMakeReferenceType >> baseType: anObject [
	baseType := anObject
]

{ #category : #accessing }
DASLMakeReferenceType >> type [
	^ type
]

{ #category : #accessing }
DASLMakeReferenceType >> type: anObject [
	type := anObject
]
