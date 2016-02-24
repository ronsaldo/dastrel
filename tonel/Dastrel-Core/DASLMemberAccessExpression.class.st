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

{ #category : #printing }
DASLMemberAccessExpression >> printOn: aStream [
	aStream nextPutAll: '(member-access '.
	reference printOn: aStream.
	aStream space.
	memberName printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLMemberAccessExpression >> reference [
	^ reference
]

{ #category : #accessing }
DASLMemberAccessExpression >> reference: anObject [
	reference := anObject
]
