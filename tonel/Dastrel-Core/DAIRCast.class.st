Class {
	#name : #DAIRCast,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRCast >> accept: aVisitor [
	^ aVisitor visitCast: self
]
