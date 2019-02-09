Class {
	#name : #DASLPharoBlockConverterCapturedVariable,
	#superclass : #DASLPharoBlockConverterVariable,
	#instVars : [
		'value',
		'type',
		'context'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> asIdentifierReferenceAt: aPosition [
	^ value asDastrelLiteralAt: aPosition inContext: context for: self
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> context [
	^ context
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> context: anObject [
	context := anObject
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> hasValidInferredType [
	^ self type isNotNil
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> type [
	type ifNil: [ type := value inferDastrelTypeIn: context for: self].
	^ type
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> value [
	^ value
]

{ #category : #accessing }
DASLPharoBlockConverterCapturedVariable >> value: anObject [
	value := anObject
]
