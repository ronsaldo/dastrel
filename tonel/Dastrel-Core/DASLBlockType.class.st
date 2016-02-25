Class {
	#name : #DASLBlockType,
	#superclass : #DASLType,
	#instVars : [
		'block'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLBlockType >> block [
	^ block
]

{ #category : #accessing }
DASLBlockType >> block: anObject [
	block := anObject
]

{ #category : #accessing }
DASLBlockType >> isBlockType [
	^ true
]

{ #category : #accessing }
DASLBlockType >> useScope [
	^ DASLUsedBlockScope new block: block
]
