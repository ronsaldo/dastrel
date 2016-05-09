Class {
	#name : #DAIRInstruction,
	#superclass : #DAIRValue,
	#instVars : [
		'name',
		'block',
		'parameters',
		'instructionReferences'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #adding }
DAIRInstruction >> addInstructionReference: anInstruction [
	instructionReferences add: anInstruction
]

{ #category : #accessing }
DAIRInstruction >> block [
	^ block
]

{ #category : #accessing }
DAIRInstruction >> block: anObject [
	block := anObject
]

{ #category : #initialization }
DAIRInstruction >> initialize [
	instructionReferences := Set new.
]

{ #category : #accessing }
DAIRInstruction >> instructionReferences [
	^ instructionReferences
]

{ #category : #testing }
DAIRInstruction >> isBranch [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isInstruction [
	^ true
]

{ #category : #testing }
DAIRInstruction >> isJump [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isTerminator [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isUnreachable [
	^ false
]

{ #category : #accessing }
DAIRInstruction >> name [
	^ name
]

{ #category : #accessing }
DAIRInstruction >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DAIRInstruction >> parameters [
	^ parameters
]

{ #category : #accessing }
DAIRInstruction >> parameters: anArrayOfParameter [
	parameters := anArrayOfParameter.
	parameters do: [ :param | param addInstructionReference: self ]
]

{ #category : #accessing }
DAIRInstruction >> successors [
	^ #()
]
