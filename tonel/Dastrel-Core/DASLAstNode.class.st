Class {
	#name : #DASLAstNode,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'Dastrel-Core'
}

{ #category : #'as yet unclassified' }
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
