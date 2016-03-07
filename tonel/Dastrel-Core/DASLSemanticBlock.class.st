Class {
	#name : #DASLSemanticBlock,
	#superclass : #DASLStructureBlock,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLSemanticBlock >> accept: aVisitor [
	^ aVisitor visitSemanticBlock: self
]

{ #category : #testing }
DASLSemanticBlock >> isGlobalConnectionBlock [
	^ true
]

{ #category : #testing }
DASLSemanticBlock >> isSemanticBlock [
	^ true
]
