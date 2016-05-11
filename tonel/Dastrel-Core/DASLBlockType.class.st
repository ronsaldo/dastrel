Class {
	#name : #DASLBlockType,
	#superclass : #DASLType,
	#instVars : [
		'block'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLBlockType >> = other [
	^ self class = other class and: [ block == other block]
]

{ #category : #visitor }
DASLBlockType >> accept: aVisitor [
	^ aVisitor visitBlockType: self
]

{ #category : #accessing }
DASLBlockType >> block [
	^ block
]

{ #category : #accessing }
DASLBlockType >> block: anObject [
	block := anObject
]

{ #category : #comparing }
DASLBlockType >> hash [
	^ self class hash bitXor: block hash
]

{ #category : #accessing }
DASLBlockType >> isBlockType [
	^ true
]

{ #category : #accessing }
DASLBlockType >> useScope [
	^ DASLUsedBlockScope new block: block
]
