Class {
	#name : #DASLAutoType,
	#superclass : #DASLOpaqueType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLAutoType >> = other [
	^ self class == other class
]

{ #category : #visitor }
DASLAutoType >> accept: aVisitor [
	^ aVisitor visitAutoType: self
]

{ #category : #comparing }
DASLAutoType >> hash [
	^ self class hash
]

{ #category : #testing }
DASLAutoType >> isAutoType [
	^ true
]

{ #category : #printing }
DASLAutoType >> printMangledOn: aStream [
	aStream nextPutAll: 'Da'
]
