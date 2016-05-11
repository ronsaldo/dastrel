Class {
	#name : #DAIRCall,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRCall class >> function: functionValue arguments: arguments [
	^ self new function: functionValue arguments: arguments
]

{ #category : #visitor }
DAIRCall >> accept: aVisitor [
	^ aVisitor visitCall: self
]

{ #category : #accessing }
DAIRCall >> arguments [
	^ parameters allButFirst
]

{ #category : #construction }
DAIRCall >> function: functionValue arguments: arguments [
	self parameters: { functionValue } , arguments.
	self assert: functionValue type isReferenceType.
	self assert: functionValue type baseType isFunctionType.
	type := functionValue type baseType returnType
]

{ #category : #accessing }
DAIRCall >> functionValue [
	^ parameters first
]

{ #category : #printing }
DAIRCall >> mnemonic [
	^ 'call'
]

{ #category : #accessing }
DAIRCall >> type [
	^ type
]
