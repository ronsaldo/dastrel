Class {
	#name : #DASLCompiler,
	#superclass : #Object,
	#instVars : [
		'sourceCode',
		'ast',
		'parser',
		'ssaModule'
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
		semanticAnalysis;
		generateSSA
]

{ #category : #accessing }
DASLCompiler >> fileName: fileName [
	parser fileName: fileName
]

{ #category : #'public access' }
DASLCompiler >> generateSSA [
	| codegen |
	codegen := DASLSSACodegenVisitor new.
	ssaModule := ast accept: codegen.

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
	DASLBlockPublicSemanticVisitor passOn: ast.
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

{ #category : #'public access' }
DASLCompiler >> ssaModule [
	^ ssaModule
]
