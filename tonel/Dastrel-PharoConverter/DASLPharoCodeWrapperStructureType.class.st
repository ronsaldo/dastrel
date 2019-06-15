Class {
	#name : #DASLPharoCodeWrapperStructureType,
	#superclass : #DASLPharoCodeConversionType,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #converting }
DASLPharoCodeWrapperStructureType >> asDastrelTypeNode [
	^ DASLIdentifier new value: name
]

{ #category : #accessing }
DASLPharoCodeWrapperStructureType >> name [
	^ name
]

{ #category : #accessing }
DASLPharoCodeWrapperStructureType >> name: anObject [
	name := anObject
]
