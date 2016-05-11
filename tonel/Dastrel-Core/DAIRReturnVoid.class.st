Class {
	#name : #DAIRReturnVoid,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRReturnVoid >> accept: aVisitor [
	^ aVisitor visitReturnVoid: self
]

{ #category : #testing }
DAIRReturnVoid >> isTerminator [
	^ true
]

{ #category : #printing }
DAIRReturnVoid >> mnemonic [
	^ 'returnVoid'
]

{ #category : #accessing }
DAIRReturnVoid >> type [
	^ DASLType voidType
]
