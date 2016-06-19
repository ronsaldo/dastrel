Class {
	#name : #DASLBufferBlock,
	#superclass : #DASLStructureLikeBlock,
	#instVars : [
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBufferBlock >> accept: aVisitor [
	^ aVisitor visitBufferBlock: self
]

{ #category : #accessing }
DASLBufferBlock >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLBufferBlock >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #testing }
DASLBufferBlock >> isBufferBlock [
	^ true
]

{ #category : #testing }
DASLBufferBlock >> isGlobalConnectionBlock [
	^ true
]
