Class {
	#name : #DASLStructureBlock,
	#superclass : #DASLStructureLikeBlock,
	#instVars : [
		'codegenValue',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLStructureBlock >> accept: aVisitor [
	^ aVisitor visitStructureBlock: self
]

{ #category : #accessing }
DASLStructureBlock >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLStructureBlock >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #'as yet unclassified' }
DASLStructureBlock >> isStructureBlock [
	^ true
]

{ #category : #'as yet unclassified' }
DASLStructureBlock >> referenceType [
	^ DASLTypeWrapper new wrapped: (DASLBlockType new block: self).
]

{ #category : #accessing }
DASLStructureBlock >> type [
	^ type
]

{ #category : #accessing }
DASLStructureBlock >> type: anObject [
	type := anObject
]
