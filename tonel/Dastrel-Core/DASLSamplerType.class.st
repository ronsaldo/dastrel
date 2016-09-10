Class {
	#name : #DASLSamplerType,
	#superclass : #DASLOpaqueType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLSamplerType >> = other [
	^ self class = other class
]

{ #category : #visitor }
DASLSamplerType >> accept: aVisitor [
	^ aVisitor visitSamplerType: self
]

{ #category : #converting }
DASLSamplerType >> asSlovimType: compilationTarget [
	^ SLVMType samplerType
]

{ #category : #comparing }
DASLSamplerType >> hash [
	^ self class hash
]

{ #category : #testing }
DASLSamplerType >> isSamplerType [
	^ true
]
