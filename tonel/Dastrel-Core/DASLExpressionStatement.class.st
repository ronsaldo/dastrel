Class {
	#name : #DASLExpressionStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'expression'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLExpressionStatement >> accept: aVisitor [
	^ aVisitor visitExpressionStatement: self
]

{ #category : #accessing }
DASLExpressionStatement >> expression [
	^ expression
]

{ #category : #accessing }
DASLExpressionStatement >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
DASLExpressionStatement >> isExpressionStatement [
	^ true
]

{ #category : #printing }
DASLExpressionStatement >> printOn: aStream [
	expression printOn: aStream.
]
