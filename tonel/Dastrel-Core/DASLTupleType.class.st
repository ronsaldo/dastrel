Class {
	#name : #DASLTupleType,
	#superclass : #DASLType,
	#instVars : [
		'types'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLTupleType class >> types: typeList [
	^ self new types: typeList; yourself
]

{ #category : #accessing }
DASLTupleType >> types [
	^ types
]

{ #category : #accessing }
DASLTupleType >> types: anObject [
	types := anObject
]
