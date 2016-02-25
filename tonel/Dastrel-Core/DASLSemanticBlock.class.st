Class {
	#name : #DASLSemanticBlock,
	#superclass : #DASLStructureBlock,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLSemanticBlock >> accept: aVisitor [
	^ aVisitor visitSemanticBlock: self
]
