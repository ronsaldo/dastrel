Class {
	#name : #DASLAstNode,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'Dastrel-Core'
}

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

{ #category : #accessing }
DASLAstNode >> setPositionFromToken: aPPToken [
	self position: (DASLCodePosition fromToken: aPPToken)
]
