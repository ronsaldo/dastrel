Class {
	#name : #DASLFieldDefinition,
	#superclass : #DASLAstNode,
	#instVars : [
		'flow',
		'type',
		'name',
		'codegenValue',
		'fieldIndex',
		'storage'
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
DASLFieldDefinition >> fieldIndex [
	^ fieldIndex
]

{ #category : #accessing }
DASLFieldDefinition >> fieldIndex: anObject [
	fieldIndex := anObject
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
	^ DASLReferenceType baseType: self type storage: self storage
]

{ #category : #accessing }
DASLFieldDefinition >> storage [
	^ storage
]

{ #category : #accessing }
DASLFieldDefinition >> storage: anObject [
	storage := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> type [
	^ type
]

{ #category : #accessing }
DASLFieldDefinition >> type: anObject [
	type := anObject
]
