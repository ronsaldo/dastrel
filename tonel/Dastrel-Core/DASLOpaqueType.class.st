Class {
	#name : #DASLOpaqueType,
	#superclass : #DASLType,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #accessing }
DASLOpaqueType >> alignment [
	^ 0
]

{ #category : #testing }
DASLOpaqueType >> isOpaqueType [
	^ true
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
