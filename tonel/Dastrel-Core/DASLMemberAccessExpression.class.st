Class {
	#name : #DASLMemberAccessExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'memberName'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLMemberAccessExpression >> memberName [
	^ memberName
]

{ #category : #accessing }
DASLMemberAccessExpression >> memberName: anObject [
	memberName := anObject
]

{ #category : #accessing }
DASLMemberAccessExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLMemberAccessExpression >> reference: anObject [
	reference := anObject
]
