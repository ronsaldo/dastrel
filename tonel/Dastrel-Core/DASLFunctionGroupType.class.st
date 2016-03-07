Class {
	#name : #DASLFunctionGroupType,
	#superclass : #DASLType,
	#instVars : [
		'functionGroup'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #accessing }
DASLFunctionGroupType >> functionGroup [
	^ functionGroup
]

{ #category : #accessing }
DASLFunctionGroupType >> functionGroup: anObject [
	functionGroup := anObject
]

{ #category : #testing }
DASLFunctionGroupType >> isFunctionGroupType [
	^ true
]
