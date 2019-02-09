Class {
	#name : #DASLPharoBlockConverterTemporaryVariable,
	#superclass : #DASLPharoBlockConverterVariable,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverterTemporaryVariable >> hasValidInferredType [
	^ type isNotNil
]

{ #category : #testing }
DASLPharoBlockConverterTemporaryVariable >> isTemporaryVariable [
	^ true
]

{ #category : #accessing }
DASLPharoBlockConverterTemporaryVariable >> type [
	^ type
]

{ #category : #accessing }
DASLPharoBlockConverterTemporaryVariable >> type: anObject [
	type := anObject
]
