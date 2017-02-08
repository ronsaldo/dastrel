Class {
	#name : #DASLShaderSignaturePushConstant,
	#superclass : #DASLShaderSignatureElement,
	#instVars : [
		'properties',
		'count',
		'metalBinding',
		'metalType'
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

{ #category : #testing }
DASLShaderSignaturePushConstant >> isShaderSignaturePushConstant [
	^ true
]

{ #category : #'as yet unclassified' }
DASLShaderSignaturePushConstant >> lowerProperty: property for: global on: newProperties [
	property key ~= #push_constant ifTrue: [
		self halt
	].

	newProperties
		at: #push_constant put: nil;
		at: #metalBinding put: metalBinding;
		at: #metalType put: metalType
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> metalBinding [
	^ metalBinding
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> metalBinding: anObject [
	metalBinding := anObject
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> metalType [
	^ metalType
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> metalType: anObject [
	metalType := anObject
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> properties [
	^ properties
]

{ #category : #accessing }
DASLShaderSignaturePushConstant >> properties: anObject [
	properties := anObject
]
