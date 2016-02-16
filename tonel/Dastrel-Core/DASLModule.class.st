Class {
	#name : #DASLModule,
	#superclass : #DASLAstNode,
	#instVars : [
		'inputs',
		'outputs'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLModule >> inputs [
	^ inputs
]

{ #category : #accessing }
DASLModule >> inputs: anObject [
	inputs := anObject
]

{ #category : #accessing }
DASLModule >> outputs [
	^ outputs
]

{ #category : #accessing }
DASLModule >> outputs: anObject [
	outputs := anObject
]
