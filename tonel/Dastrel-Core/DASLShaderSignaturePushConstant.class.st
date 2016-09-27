Class {
	#name : #DASLShaderSignaturePushConstant,
	#superclass : #DASLShaderSignatureElement,
	#instVars : [
		'properties',
		'count'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLShaderSignaturePushConstant >> count [
	^ count
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> count: anObject [
	count := anObject
]

{ #category : #'as yet unclassified' }
DASLShaderSignaturePushConstant >> isShaderSignaturePushConstant [
	^ false
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> properties [
	^ properties
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> properties: anObject [
	properties := anObject
]
