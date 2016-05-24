Class {
	#name : #DASLSampledTextureType,
	#superclass : #DASLOpaqueType,
	#instVars : [
		'texture'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLSampledTextureType >> = other [
	^ self class = other class and: [ texture = other texture ]
]

{ #category : #visitor }
DASLSampledTextureType >> accept: aVisitor [
	^ aVisitor visitSampledTextureType: self
]

{ #category : #comparing }
DASLSampledTextureType >> hash [
	^ self class hash bitXor: texture hash
]

{ #category : #testing }
DASLSampledTextureType >> isSampledTextureType [
	^ true
]

{ #category : #accessing }
DASLSampledTextureType >> texture [
	^ texture
]

{ #category : #accessing }
DASLSampledTextureType >> texture: anObject [
	texture := anObject
]
