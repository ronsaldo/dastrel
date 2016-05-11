Class {
	#name : #DASLUniformBlock,
	#superclass : #DASLStructureBlock,
	#instVars : [
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUniformBlock >> accept: aVisitor [
	^ aVisitor visitUniformBlock: self
]

{ #category : #accessing }
DASLUniformBlock >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLUniformBlock >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #testing }
DASLUniformBlock >> isGlobalConnectionBlock [
	^ true
]

{ #category : #testing }
DASLUniformBlock >> isUniformBlock [
	^ true
]
