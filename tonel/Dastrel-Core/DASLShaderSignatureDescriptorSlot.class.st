Class {
	#name : #DASLShaderSignatureDescriptorSlot,
	#superclass : #DASLShaderSignatureElement,
	#instVars : [
		'type',
		'arraySize',
		'repetitionCount'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLShaderSignatureDescriptorSlot >> accept: visitor [
	^ visitor visitShaderSignatureDescriptorSlot: self
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> arraySize [
	^ arraySize
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> arraySize: anObject [
	arraySize := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> repetitionCount [
	^ repetitionCount
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> repetitionCount: anObject [
	repetitionCount := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> type [
	^ type
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> type: anObject [
	type := anObject
]
