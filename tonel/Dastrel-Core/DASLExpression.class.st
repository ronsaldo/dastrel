Class {
	#name : #DASLExpression,
	#superclass : #DASLAstNode,
	#category : #'Dastrel-Core-AST'
}

{ #category : #testing }
DASLExpression >> evaluateConstant [
	self subclassResponsibility
]

{ #category : #testing }
DASLExpression >> isConstantExpression [
	^ false
]

{ #category : #accessing }
DASLExpression >> type [
	self subclassResponsibility
]
