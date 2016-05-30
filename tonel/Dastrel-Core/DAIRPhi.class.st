Class {
	#name : #DAIRPhi,
	#superclass : #DAIRInstruction,
	#instVars : [
		'incomingBlocks'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRPhi >> accept: aVisitor [
	^ aVisitor visitPhi: self
]

{ #category : #adding }
DAIRPhi >> addValue: value from: incomingBlock [
	parameters add: value.
	incomingBlocks add: incomingBlock.
]

{ #category : #initialization }
DAIRPhi >> initialize [
	parameters := OrderedCollection new.
	incomingBlocks := OrderedCollection new.
]

{ #category : #printing }
DAIRPhi >> mnemonic [
	^ 'phi'
]
