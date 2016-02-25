Class {
	#name : #DASLFunctionArgument,
	#superclass : #DASLAstNode,
	#instVars : [
		'name',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunctionArgument >> accept: aVisitor [
	^ aVisitor visitFunctionArgument: self
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
DASLFunctionArgument >> type [
	^ type
]

{ #category : #accessing }
DASLFunctionArgument >> type: anObject [
	type := anObject
]
