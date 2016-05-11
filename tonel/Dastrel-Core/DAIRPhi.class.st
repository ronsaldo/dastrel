Class {
	#name : #DAIRPhi,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRPhi >> accept: aVisitor [
	^ aVisitor visitPhi: self
]

{ #category : #printing }
DAIRPhi >> mnemonic [
	^ 'phi'
]
