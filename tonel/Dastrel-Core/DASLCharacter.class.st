Class {
	#name : #DASLCharacter,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLCharacter >> accept: aVisitor [
	^ aVisitor visitCharacter: self
]
