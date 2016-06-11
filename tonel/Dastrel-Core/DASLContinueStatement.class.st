Class {
	#name : #DASLContinueStatement,
	#superclass : #DASLStatement,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLContinueStatement >> accept: aVisitor [
	^ aVisitor visitContinueStatement: self
]
