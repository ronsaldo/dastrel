Class {
	#name : #DASLPharoCodeReferenceType,
	#superclass : #DASLPharoCodeConversionType,
	#instVars : [
		'baseType'
	],
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #converting }
DASLPharoCodeReferenceType >> asDastrelTypeNode [
	^ DASLMakeReferenceType new baseType: (baseType asDastrelTypeNode); yourself
]

{ #category : #accessing }
DASLPharoCodeReferenceType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLPharoCodeReferenceType >> baseType: anObject [
	baseType := anObject
]

{ #category : #testing }
DASLPharoCodeReferenceType >> isReferenceType [
	^ true
]
