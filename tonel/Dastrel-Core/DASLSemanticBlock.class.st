Class {
	#name : #DASLSemanticBlock,
	#superclass : #DASLStructureLikeBlock,
	#instVars : [
		'direction'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLSemanticBlock >> accept: aVisitor [
	^ aVisitor visitSemanticBlock: self
]

{ #category : #accessing }
DASLSemanticBlock >> direction [
	^ direction
]

{ #category : #accessing }
DASLSemanticBlock >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
DASLSemanticBlock >> isGlobalConnectionBlock [
	^ true
]

{ #category : #testing }
DASLSemanticBlock >> isSemanticBlock [
	^ true
]
