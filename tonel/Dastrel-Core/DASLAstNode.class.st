Class {
	#name : #DASLAstNode,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLAstNode >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #initialization }
DASLAstNode >> initialize [
	super initialize.
	position := DASLCodePosition  default.
]

{ #category : #accessing }
DASLAstNode >> position [
	^ position
]

{ #category : #accessing }
DASLAstNode >> position: anObject [
	position := anObject
]

{ #category : #printing }
DASLAstNode >> printList: aList on: aStream [
	| first |
	first := true.
	aStream nextPut: $(.
	aList do: [:el |
		first ifFalse: [ aStream space ].
		el printOn: aStream.
		first := false.
	].
	aStream nextPut: $).
]

{ #category : #accessing }
DASLAstNode >> setPositionFromToken: aPPToken [
	self position: (DASLCodePosition fromToken: aPPToken)
]
