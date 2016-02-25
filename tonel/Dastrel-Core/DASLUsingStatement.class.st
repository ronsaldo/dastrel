Class {
	#name : #DASLUsingStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'identifier'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUsingStatement >> accept: aVisitor [
	^ aVisitor visitUsingStatement: self
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
	identifier printOn: aStream.
	aStream nextPut: $).
]
