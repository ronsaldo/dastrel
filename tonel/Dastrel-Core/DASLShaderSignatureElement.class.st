Class {
	#name : #DASLShaderSignatureElement,
	#superclass : #DASLAstNode,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #testing }
DASLShaderSignatureElement >> isShaderSignatureDescriptorSet [
	^ false
]

{ #category : #testing }
DASLShaderSignatureElement >> isShaderSignaturePushConstant [
	^ false
]

{ #category : #accessing }
DASLShaderSignatureElement >> name [
	^ name
]

{ #category : #accessing }
DASLShaderSignatureElement >> name: anObject [
	name := anObject
]
