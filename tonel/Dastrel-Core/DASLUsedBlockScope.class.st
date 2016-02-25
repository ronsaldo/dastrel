Class {
	#name : #DASLUsedBlockScope,
	#superclass : #DASLScope,
	#instVars : [
		'block'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #accessing }
DASLUsedBlockScope >> block [
	^ block
]

{ #category : #accessing }
DASLUsedBlockScope >> block: anObject [
	block := anObject
]

{ #category : #'symbol lookup' }
DASLUsedBlockScope >> lookSymbol: symbol [
	^ block scope lookSymbol: symbol
]
