Class {
	#name : #DASLFieldDefinition,
	#superclass : #DASLAstNode,
	#instVars : [
		'flow',
		'type',
		'name',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFieldDefinition >> accept: aVisitor [
	^ aVisitor visitFieldDefinition: self
]

{ #category : #accessing }
DASLFieldDefinition >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLFieldDefinition >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> flow [
	^ flow
]

{ #category : #accessing }
DASLFieldDefinition >> flow: anObject [
	flow := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> name [
	^ name
]

{ #category : #accessing }
DASLFieldDefinition >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> referenceType [
	^ DASLReferenceType baseType: self type
]

{ #category : #accessing }
DASLFieldDefinition >> type [
	^ type
]

{ #category : #accessing }
DASLFieldDefinition >> type: anObject [
	type := anObject
]
