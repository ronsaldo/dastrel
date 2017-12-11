Class {
	#name : #DASLUsingStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'expression',
		'identifier',
		'type',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUsingStatement >> accept: aVisitor [
	^ aVisitor visitUsingStatement: self
]

{ #category : #accessing }
DASLUsingStatement >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLUsingStatement >> codegenValue: anObject [
	codegenValue := anObject
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

{ #category : #accessing }
DASLUsingStatement >> referenceType [
	^ type
]

{ #category : #accessing }
DASLUsingStatement >> type [
	^ type
]

{ #category : #accessing }
DASLUsingStatement >> type: anObject [
	type := anObject
]
