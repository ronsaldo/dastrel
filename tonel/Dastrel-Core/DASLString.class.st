Class {
	#name : #DASLString,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLString >> accept: aVisitor [
	^ aVisitor visitString: self
]
