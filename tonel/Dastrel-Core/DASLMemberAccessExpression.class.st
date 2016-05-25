Class {
	#name : #DASLMemberAccessExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'reference',
		'memberName',
		'globalReferenceValue',
		'type',
		'memberIndex',
		'accessKind'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLMemberAccessExpression >> accept: aVisitor [
	^ aVisitor visitMemberAccessExpression: self
]

{ #category : #accessing }
DASLMemberAccessExpression >> accessKind [
	^ accessKind
]

{ #category : #accessing }
DASLMemberAccessExpression >> accessKind: anObject [
	accessKind := anObject
]

{ #category : #accessing }
DASLMemberAccessExpression >> globalReferenceValue [
	^ globalReferenceValue
]

{ #category : #accessing }
DASLMemberAccessExpression >> globalReferenceValue: anObject [
	globalReferenceValue := anObject
]

{ #category : #accessing }
DASLMemberAccessExpression >> memberIndex [
	^ memberIndex
]

{ #category : #accessing }
DASLMemberAccessExpression >> memberIndex: anObject [
	memberIndex := anObject
]

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

{ #category : #accessing }
DASLMemberAccessExpression >> type [
	^ type
]

{ #category : #accessing }
DASLMemberAccessExpression >> type: anObject [
	type := anObject
]
