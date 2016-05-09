Class {
	#name : #DAIRReturn,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #'as yet unclassified' }
DAIRReturn class >> value: aReturnValue [
	^ DAIRReturn new value: aReturnValue
]

{ #category : #testing }
DAIRReturn >> isTerminator [
	^ true
]

{ #category : #accessing }
DAIRReturn >> type [
	^ DASLType voidType
]

{ #category : #evaluating }
DAIRReturn >> value [
	^ parameters first
]

{ #category : #accessing }
DAIRReturn >> value: aValue [
	self parameters: { aValue }
]