Class {
	#name : #DASLReturnStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'value'
	],
	#category : #'Dastrel-Core'
}

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
