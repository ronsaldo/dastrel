Class {
	#name : #DASLGraphBlock,
	#superclass : #DASLModule,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLGraphBlock >> accept: aVisitor [
	^ aVisitor visitGraphBlock: self
]
