Class {
	#name : #DASLTypeWrapper,
	#superclass : #DASLType,
	#instVars : [
		'wrapped'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #visitor }
DASLTypeWrapper >> accept: aVisitor [
	^ aVisitor visitTypeWrapper: self
]

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
