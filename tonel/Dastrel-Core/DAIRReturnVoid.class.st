Class {
	#name : #DAIRReturnVoid,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #testing }
DAIRReturnVoid >> isTerminator [
	^ true
]

{ #category : #accessing }
DAIRReturnVoid >> type [
	^ DASLType voidType
]
