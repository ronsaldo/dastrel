Class {
	#name : #DASLExpression,
	#superclass : #DASLAstNode,
	#category : #'Dastrel-Core-AST'
}

{ #category : #converting }
DASLExpression >> asStatement [
	^ DASLExpressionStatement new
		position: position;
		expression: self;
		yourself
]

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
