Class {
	#name : #DASLShaderSignatureDescriptorSet,
	#superclass : #DASLShaderSignatureElement,
	#instVars : [
		'properties',
		'slots'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLShaderSignatureDescriptorSet >> accept: visitor [
	^ visitor visitShaderSignatureDescriptorSet: self
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSet >> properties [
	^ properties
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSet >> properties: anObject [
	properties := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSet >> slots [
	^ slots
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSet >> slots: anObject [
	slots := anObject
]
