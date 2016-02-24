Class {
	#name : #DASLSubscriptExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'index'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLSubscriptExpression >> index [
	^ index
]

{ #category : #accessing }
DASLSubscriptExpression >> index: anObject [
	index := anObject
]

{ #category : #accessing }
DASLSubscriptExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLSubscriptExpression >> reference: anObject [
	reference := anObject
]
