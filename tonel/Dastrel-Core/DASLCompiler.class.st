Class {
	#name : #DASLCompiler,
	#superclass : #Object,
	#instVars : [
		'compilationContext',
		'sourceCode',
		'ast',
		'parser',
		'codeGenerator',
		'generatedCode',
		'currentFileName',
		'optimizationLevel'
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

{ #category : #accessing }
DASLCompiler >> compilationContext [
	^ compilationContext
]

{ #category : #accessing }
DASLCompiler >> compilationContext: anObject [
	compilationContext := anObject
]

{ #category : #'public access' }
DASLCompiler >> compile [
	self parse;
		semanticAnalysis;
		generateCode
]

{ #category : #accessing }
DASLCompiler >> fileName: fileName [
	currentFileName := fileName.
]

{ #category : #'public access' }
DASLCompiler >> generateCode [
	generatedCode := codeGenerator passOn: ast optimizationLevel: optimizationLevel.

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

{ #category : #'public access' }
DASLCompiler >> importCompilation [
	self parse;
		semanticAnalysis.
	^ ast
]

{ #category : #initialization }
DASLCompiler >> initialize [
	super initialize.
	
	parser := DASLParser new.
	compilationContext := DASLCompilationContext new.
	optimizationLevel := 0.
]

{ #category : #'public access' }
DASLCompiler >> metalTarget [
	codeGenerator := DASLMetalCodegenVisitor new.
]

{ #category : #accessing }
DASLCompiler >> optimizationLevel [
	^ optimizationLevel
]

{ #category : #accessing }
DASLCompiler >> optimizationLevel: anObject [
	optimizationLevel := anObject
]

{ #category : #parsing }
DASLCompiler >> parse [
	ast := parser
		compilationContext: compilationContext;
		fileName: currentFileName;
		parse: sourceCode.
	ast isPetitFailure ifTrue: [ compilationContext parseError: ast fileName: currentFileName ].
	ast fullPath: currentFileName.
	compilationContext addTranslationUnit: ast.
]

{ #category : #'public access' }
DASLCompiler >> semanticAnalysis [
	DASLModuleSemanticVisitor for: compilationContext passOn: ast.
	DASLBlockPublicSemanticVisitor for: compilationContext passOn: ast.
	DASLBlockSemanticVisitor for: compilationContext passOn: ast.
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
	self fileName: aFileName asFileReference asAbsolute fullName;
		sourceCode: aFileName asFileReference contents
]

{ #category : #'public access' }
DASLCompiler >> spirVTarget [
	codeGenerator := DASLSpirVCodegenVisitor new.
]

{ #category : #'public access' }
DASLCompiler >> ssaTarget [
	codeGenerator := DASLSSACodegenVisitor new.
]
