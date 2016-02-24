Class {
	#name : #DASLExpressionStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'expression'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLExpressionStatement >> expression [
	^ expression
]

{ #category : #accessing }
DASLExpressionStatement >> expression: anObject [
	expression := anObject
]

{ #category : #printing }
DASLExpressionStatement >> printOn: aStream [
	expression printOn: aStream.
]
