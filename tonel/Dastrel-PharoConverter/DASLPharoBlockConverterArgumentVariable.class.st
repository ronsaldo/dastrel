Class {
	#name : #DASLPharoBlockConverterArgumentVariable,
	#superclass : #DASLPharoBlockConverterVariable,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverterArgumentVariable >> hasValidInferredType [
	^ type isNotNil
]

{ #category : #accessing }
DASLPharoBlockConverterArgumentVariable >> type [
	^ type
]

{ #category : #accessing }
DASLPharoBlockConverterArgumentVariable >> type: anObject [
	type := anObject
]
