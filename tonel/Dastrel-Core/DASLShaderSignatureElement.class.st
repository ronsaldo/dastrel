Class {
	#name : #DASLShaderSignatureElement,
	#superclass : #DASLAstNode,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLShaderSignatureElement >> name [
	^ name
]

{ #category : #accessing }
DASLShaderSignatureElement >> name: anObject [
	name := anObject
]
