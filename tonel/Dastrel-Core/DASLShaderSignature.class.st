Class {
	#name : #DASLShaderSignature,
	#superclass : #DASLAstNode,
	#instVars : [
		'name',
		'elements'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLShaderSignature >> accept: visitor [
	^ visitor visitShaderSignature: self
]

{ #category : #accessing }
DASLShaderSignature >> elements [
	^ elements
]

{ #category : #accessing }
DASLShaderSignature >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
DASLShaderSignature >> memberAt: memberName ifAbsent: aBlock [
	elements do: [ :element |
		element name = memberName ifTrue: [ ^ element ]
	].

	^ aBlock value
]

{ #category : #accessing }
DASLShaderSignature >> name [
	^ name
]

{ #category : #accessing }
DASLShaderSignature >> name: anObject [
	name := anObject
]
