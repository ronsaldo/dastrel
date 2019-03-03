Class {
	#name : #DASLBlockListLiteral,
	#superclass : #DASLExpression,
	#instVars : [
		'elements'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBlockListLiteral >> accept: aVisitor [
	^ aVisitor visitBlockListLiteral: self
]

{ #category : #accessing }
DASLBlockListLiteral >> elements [
	^ elements
]

{ #category : #accessing }
DASLBlockListLiteral >> elements: anObject [
	elements := anObject
]

{ #category : #testing }
DASLBlockListLiteral >> isBlockListLiteral [
	^ true
]
