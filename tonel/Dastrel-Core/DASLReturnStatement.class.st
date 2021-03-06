Class {
	#name : #DASLReturnStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'value'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLReturnStatement >> accept: aVisitor [
	^ aVisitor visitReturnStatement: self
]

{ #category : #printing }
DASLReturnStatement >> printOn: aStream [
	aStream nextPutAll: '(return '.
	self printList: value on: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLReturnStatement >> value [
	^ value
]

{ #category : #accessing }
DASLReturnStatement >> value: anObject [
	value := anObject
]
