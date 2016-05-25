Class {
	#name : #DAIRShuffleVectors,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type',
		'components'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRShuffleVectors class >> firstVector: firstVector secondVector: secondVector components: components [
	^ self new firstVector: firstVector secondVector: secondVector components: components
]

{ #category : #visitor }
DAIRShuffleVectors >> accept: visitor [
	^ visitor visitShuffleVectors: self
]

{ #category : #accessing }
DAIRShuffleVectors >> components [
	^ components
]

{ #category : #accessing }
DAIRShuffleVectors >> firstVector [
	^ parameters first
]

{ #category : #construction }
DAIRShuffleVectors >> firstVector: firstVector secondVector: secondVector components: arrayOfComponents [
	self parameters: { firstVector . secondVector }.
	self assert: firstVector type isVectorType.
	self assert: secondVector type isVectorType.
	self assert: firstVector type baseType = secondVector type baseType.
	components := arrayOfComponents.
	type := DASLVectorType baseType: firstVector type baseType elements: components size.
]

{ #category : #printing }
DAIRShuffleVectors >> mnemonic [
	^ #shuffleVectors
]

{ #category : #accessing }
DAIRShuffleVectors >> secondVector [
	^ parameters second
]

{ #category : #accessing }
DAIRShuffleVectors >> type [
	^ type
]
