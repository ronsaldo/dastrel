Class {
	#name : #DASLUniformBlock,
	#superclass : #DASLStructureBlock,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUniformBlock >> accept: aVisitor [
	^ aVisitor visitUniformBlock: self
]

{ #category : #testing }
DASLUniformBlock >> isGlobalConnectionBlock [
	^ true
]
