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
DASLModule >> isGlobalConnectionBlock [
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
