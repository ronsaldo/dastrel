Class {
	#name : #DAIRUnaryOperation,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRUnaryOperation >> accept: aVisitor [
	^ aVisitor visitUnaryOperation: self
]
