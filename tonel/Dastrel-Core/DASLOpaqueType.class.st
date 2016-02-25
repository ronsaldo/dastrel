Class {
	#name : #DASLOpaqueType,
	#superclass : #DASLType,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLOpaqueType >> alignment [
	^ 0
]

{ #category : #accessing }
DASLOpaqueType >> name [
	^ name
]

{ #category : #accessing }
DASLOpaqueType >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLOpaqueType >> size [
	^ 0
]
