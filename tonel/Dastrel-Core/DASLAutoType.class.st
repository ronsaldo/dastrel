Class {
	#name : #DASLAutoType,
	#superclass : #DASLOpaqueType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLAutoType >> = other [
	^ self class == other class
]

{ #category : #comparing }
DASLAutoType >> hash [
	^ self class hash
]

{ #category : #testing }
DASLAutoType >> isAutoType [
	^ true
]
