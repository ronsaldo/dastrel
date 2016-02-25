Class {
	#name : #DASLModuleSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitCodeBlock: codeBlock [
	currentScope at: codeBlock name put: codeBlock ifPresent: [
		self error: 'code block overrides a previously defined symbol' at: codeBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitFunction: function [
	"TODO: Support function overloading"
	currentScope at: function name put: function ifPresent: [
		self error: 'function overrides a previously defined symbol' at: function
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitGraphBlock: graphBlock [
	currentScope at: graphBlock name put: graphBlock ifPresent: [
		self error: 'graph block overrides a previously defined symbol' at: graphBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitInterface: interface [
	currentScope at: interface name put: interface ifPresent: [
		self error: 'interface overrides a previously defined symbol' at: interface
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitSemanticBlock: semanticBlock [
	currentScope at: semanticBlock name put: semanticBlock ifPresent: [
		self error: 'semanticBlock overrides a previously defined symbol' at: semanticBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitTranslationUnit: translationUnit [
	| packageScope |
	packageScope := DASLPackageScope new node: translationUnit.
	translationUnit package: packageScope.
	self withScope: packageScope do: [
		translationUnit modules do: [ :module | module accept: self ]
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitUniformBlock: uniformBlock [
	currentScope at: uniformBlock name put: uniformBlock ifPresent: [
		self error: 'uniform block overrides a previously defined symbol' at: uniformBlock
	].
]