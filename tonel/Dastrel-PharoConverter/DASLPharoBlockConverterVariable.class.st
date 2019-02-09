Class {
	#name : #DASLPharoBlockConverterVariable,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #converting }
DASLPharoBlockConverterVariable >> asIdentifierReferenceAt: aPosition [
	^ DASLIdentifier new
		position: aPosition;
		value: name;
		yourself
]

{ #category : #testing }
DASLPharoBlockConverterVariable >> isTemporaryVariable [
	^ false
]

{ #category : #accessing }
DASLPharoBlockConverterVariable >> name [
	^ name
]

{ #category : #accessing }
DASLPharoBlockConverterVariable >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLPharoBlockConverterVariable >> position [
	^ position
]

{ #category : #accessing }
DASLPharoBlockConverterVariable >> position: anObject [
	position := anObject
]
