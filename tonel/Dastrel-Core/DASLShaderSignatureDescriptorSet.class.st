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

{ #category : #'as yet unclassified' }
DASLShaderSignatureDescriptorSet >> isShaderSignatureDescriptorSet [
	^ true
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSet >> memberAt: memberName ifAbsent: aBlock [
	slots do: [ :slot |
		slot name = memberName ifTrue: [ ^ slot ]
	].
	
	^ aBlock value
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
