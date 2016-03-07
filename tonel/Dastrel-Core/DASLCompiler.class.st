Class {
	#name : #DASLCompiler,
	#superclass : #Object,
	#instVars : [
		'sourceCode',
		'ast',
		'parser',
		'codeGenerator',
		'generatedCode'
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

{ #category : #accessing }
DASLCompiler >> codeGenerator [
	^ codeGenerator
]

{ #category : #accessing }
DASLCompiler >> codeGenerator: anObject [
	codeGenerator := anObject
]

{ #category : #'public access' }
DASLCompiler >> compile [
	self parse;
		semanticAnalysis;
		generateCode
]

{ #category : #accessing }
DASLCompiler >> fileName: fileName [
	parser fileName: fileName
]

{ #category : #'public access' }
DASLCompiler >> generateCode [
	generatedCode := ast accept: codeGenerator.

]

{ #category : #accessing }
DASLCompiler >> generatedCode [
	^ generatedCode
]

{ #category : #'public access' }
DASLCompiler >> glslTarget [
	codeGenerator := DASLGLSLCodegenVisitor new.
]

{ #category : #'public access' }
DASLCompiler >> hlslTarget [
	codeGenerator := DASLHLSLCodegenVisitor new.
]

{ #category : #initialization }
DASLCompiler >> initialize [
	super initialize.
	
	parser := DASLParser new.
]

{ #category : #'public access' }
DASLCompiler >> metalTarget [
	codeGenerator := DASLMetalCodegenVisitor new.
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
DASLCompiler >> ssaTarget [
	codeGenerator := DASLSSACodegenVisitor new.
]
