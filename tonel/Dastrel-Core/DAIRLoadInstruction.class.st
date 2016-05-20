Class {
	#name : #DAIRLoadInstruction,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #accessing }
DAIRLoadInstruction class >> variable: variableReference [
	^ self new variable: variableReference
]

{ #category : #visitor }
DAIRLoadInstruction >> accept: aVisitor [
	^ aVisitor visitLoad: self
]

{ #category : #printing }
DAIRLoadInstruction >> mnemonic [
	^ 'load'
]

{ #category : #accessing }
DAIRLoadInstruction >> type [
	^ type
]

{ #category : #accessing }
DAIRLoadInstruction >> variable [
	^ parameters first
]

{ #category : #accessing }
DAIRLoadInstruction >> variable: variableReference [
	| refType |
	self parameters: { variableReference }.
	refType := variableReference type.
	self assert: refType isReferenceType.
	type := refType baseType.
]
