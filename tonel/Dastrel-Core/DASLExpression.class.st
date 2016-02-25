Class {
	#name : #DASLExpression,
	#superclass : #DASLAstNode,
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLExpression >> type [
	self subclassResponsibility
]
