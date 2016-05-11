Class {
	#name : #DASLFunctionArgument,
	#superclass : #DASLAstNode,
	#instVars : [
		'name',
		'type',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunctionArgument >> accept: aVisitor [
	^ aVisitor visitFunctionArgument: self
]

{ #category : #accessing }
DASLFunctionArgument >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLFunctionArgument >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLFunctionArgument >> name [
	^ name
]

{ #category : #accessing }
DASLFunctionArgument >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLFunctionArgument >> referenceType [
	type isReferenceType ifTrue: [ ^ type ].
	^ DASLReferenceType baseType: type.
]

{ #category : #accessing }
DASLFunctionArgument >> type [
	^ type
]

{ #category : #accessing }
DASLFunctionArgument >> type: anObject [
	type := anObject
]
