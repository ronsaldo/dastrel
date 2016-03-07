Class {
	#name : #DASLTypeWrapper,
	#superclass : #DASLType,
	#instVars : [
		'wrapped'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeWrapper >> isTypeWrapper [
	^ true
]

{ #category : #accessing }
DASLTypeWrapper >> wrapped [
	^ wrapped
]

{ #category : #accessing }
DASLTypeWrapper >> wrapped: anObject [
	wrapped := anObject
]
