Class {
	#name : #DASLStatement,
	#superclass : #DASLAstNode,
	#category : #'Dastrel-Core-AST'
}

{ #category : #converting }
DASLStatement >> asStatement [
	^ self
]

{ #category : #testing }
DASLStatement >> isExpressionStatement [
	^ false
]
