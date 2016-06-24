Class {
	#name : #DASLModuleSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#instVars : [
		'currentDirectory',
		'currentTranslationUnit'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitBufferBlock: bufferBlock [
	currentScope at: bufferBlock name put: bufferBlock ifPresent: [
		self error: 'buffer block overrides a previously defined symbol' at: bufferBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitCodeBlock: codeBlock [
	currentScope at: codeBlock name put: codeBlock ifPresent: [
		self error: 'code block overrides a previously defined symbol' at: codeBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitFunction: function [
	| functionGroup |
	functionGroup := currentScope lookSymbol: function name.
	(functionGroup isNotNil and: [ functionGroup isFunctionGroup not]) ifTrue: [
		self error: 'function overrides a previously defined symbol' at: function
	].

	functionGroup ifNil: [ 
		functionGroup := DASLFunctionGroup new name: function name.
		currentScope at: function name put: functionGroup ifPresent: [self error: 'compiler bug'].
	].

	functionGroup addAlternative: function.
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitGraphBlock: graphBlock [
	currentScope at: graphBlock name put: graphBlock ifPresent: [
		self error: 'graph block overrides a previously defined symbol' at: graphBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitImportStatement: importStatement [
	| importedFileName |
	importedFileName := currentDirectory / (importStatement packageName , '.dastrel').
	importStatement importedUnit: (compilationContext importTranslationUnit: importedFileName).
	currentScope addImportScope: importStatement importedUnit package.
	currentTranslationUnit addImportedUnit: importStatement importedUnit.
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
DASLModuleSemanticVisitor >> visitStructureBlock: structureBlock [
	currentScope at: structureBlock name put: structureBlock ifPresent: [
		self error: 'uniform block overrides a previously defined symbol' at: structureBlock
	].
]

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitTranslationUnit: translationUnit [
	| builtInScope packageScope |
	currentDirectory := translationUnit fullPath asFileReference parent.
	currentTranslationUnit := translationUnit.
	self assert: currentDirectory isDirectory.
	builtInScope := DASLBuiltInScope uniqueInstance.
	packageScope := DASLPackageScope new parentScope: builtInScope; node: translationUnit.
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

{ #category : #visitor }
DASLModuleSemanticVisitor >> visitUniformGlobal: uniformGlobal [
	currentScope at: uniformGlobal name put: uniformGlobal ifPresent: [
		self error: 'uniform global overrides a previously defined symbol' at: uniformGlobal
	].
]
