Class {
	#name : #DASLPragma,
	#superclass : #DASLAstNode,
	#instVars : [
		'selector'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLPragma >> accept: aVisitor [
	^ aVisitor visitPragmaNode: self
]

{ #category : #accessing }
DASLPragma >> selector [
	^ selector
]

{ #category : #accessing }
DASLPragma >> selector: anObject [
	selector := anObject
]
