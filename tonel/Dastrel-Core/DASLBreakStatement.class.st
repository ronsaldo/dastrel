Class {
	#name : #DASLBreakStatement,
	#superclass : #DASLStatement,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBreakStatement >> accept: aVisitor [
	^ aVisitor visitBreakStatement: self
]
