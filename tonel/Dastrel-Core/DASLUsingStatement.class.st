Class {
	#name : #DASLUsingStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'expression',
		'identifier'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUsingStatement >> accept: aVisitor [
	^ aVisitor visitUsingStatement: self
]

{ #category : #accessing }
DASLUsingStatement >> expression [
	^ expression
]

{ #category : #accessing }
DASLUsingStatement >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
DASLUsingStatement >> identifier [
	^ identifier
]

{ #category : #accessing }
DASLUsingStatement >> identifier: anObject [
	identifier := anObject
]

{ #category : #printing }
DASLUsingStatement >> printOn: aStream [
	aStream nextPutAll: '(using '.
	expression printOn: aStream.
	aStream nextPut: $).
]
