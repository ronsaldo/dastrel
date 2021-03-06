Class {
	#name : #DASLGraphBlock,
	#superclass : #DASLModule,
	#instVars : [
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLGraphBlock >> accept: aVisitor [
	^ aVisitor visitGraphBlock: self
]

{ #category : #accessing }
DASLGraphBlock >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLGraphBlock >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #testing }
DASLGraphBlock >> isCallableBlock [
	^ true
]

{ #category : #testing }
DASLGraphBlock >> isGraphBlock [
	^ true
]

{ #category : #accessing }
DASLGraphBlock >> referenceType [
	^ DASLBlockType new block: self.
]

{ #category : #accessing }
DASLGraphBlock >> type [
	^ DASLBlockType new block: self.
]
