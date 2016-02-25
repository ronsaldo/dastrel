Class {
	#name : #DASLCompiler,
	#superclass : #Object,
	#instVars : [
		'sourceCode',
		'ast',
		'parser'
	],
	#category : #'Dastrel-Core-Compiler'
}

{ #category : #accessing }
DASLCompiler >> ast [
	^ ast
]

{ #category : #accessing }
DASLCompiler >> ast: anObject [
	ast := anObject
]

{ #category : #'public access' }
DASLCompiler >> compile [
	self parse;
		semanticAnalysis
]

{ #category : #accessing }
DASLCompiler >> fileName: fileName [
	parser fileName: fileName
]

{ #category : #initialization }
DASLCompiler >> initialize [
	super initialize.
	
	parser := DASLParser new.
]

{ #category : #parsing }
DASLCompiler >> parse [
	ast := parser parse: sourceCode.
]

{ #category : #'public access' }
DASLCompiler >> semanticAnalysis [
	DASLModuleSemanticVisitor passOn: ast.
	DASLBlockSemanticVisitor passOn: ast.
]

{ #category : #accessing }
DASLCompiler >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
DASLCompiler >> sourceCode: anObject [
	sourceCode := anObject
]

{ #category : #accessing }
DASLCompiler >> sourceFromFileNamed: aFileName [
	self fileName: aFileName;
		sourceCode: aFileName asFileReference contents
]
