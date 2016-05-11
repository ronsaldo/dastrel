Class {
	#name : #DASLModule,
	#superclass : #DASLAstNode,
	#instVars : [
		'name',
		'inputs',
		'outputs',
		'scope'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLModule >> inputs [
	^ inputs
]

{ #category : #accessing }
DASLModule >> inputs: anObject [
	inputs := anObject
]

{ #category : #testing }
DASLModule >> isBuiltInFunction [
	^ false
]

{ #category : #testing }
DASLModule >> isCodeBlock [
	^ false
]

{ #category : #testing }
DASLModule >> isFunction [
	^ false
]

{ #category : #testing }
DASLModule >> isGlobalConnectionBlock [
	^ false
]

{ #category : #testing }
DASLModule >> isGraphBlock [
	^ false
]

{ #category : #testing }
DASLModule >> isInterface [
	^ false
]

{ #category : #testing }
DASLModule >> isSemanticBlock [
	^ false
]

{ #category : #testing }
DASLModule >> isUniformBlock [
	^ false
]

{ #category : #accessing }
DASLModule >> name [
	^ name
]

{ #category : #accessing }
DASLModule >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLModule >> outputs [
	^ outputs
]

{ #category : #accessing }
DASLModule >> outputs: anObject [
	outputs := anObject
]

{ #category : #accessing }
DASLModule >> scope [
	^ scope
]

{ #category : #accessing }
DASLModule >> scope: anObject [
	scope := anObject
]
