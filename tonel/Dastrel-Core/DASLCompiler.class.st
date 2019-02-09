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
		'optimizationLevel',
		'ssaModule',
		'astNodesToInject'
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
		generateSSAModule;
		generateCode
]

{ #category : #targets }
DASLCompiler >> cppTarget [
	self target: #cpp
]

{ #category : #accessing }
DASLCompiler >> fileName: fileName [
	currentFileName := fileName.
]

{ #category : #'public access' }
DASLCompiler >> generateCode [
	codeGenerator ifNil: [
		generatedCode := ssaModule.
		^ self
	].
	generatedCode := codeGenerator
		optimizationLevel: optimizationLevel;
		translateModule: ssaModule
]

{ #category : #'public access' }
DASLCompiler >> generateSSAModule [
	ssaModule := DASLSSACodegenVisitor new passOn: ast

]

{ #category : #accessing }
DASLCompiler >> generatedCode [
	^ generatedCode
]

{ #category : #targets }
DASLCompiler >> glslTarget [
	self target: #glsl
]

{ #category : #targets }
DASLCompiler >> hlslTarget [
	self target: #hlsl
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
	astNodesToInject := #().
]

{ #category : #targets }
DASLCompiler >> metalTarget [
	self target: #metal
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
	ast := parser parse: sourceCode.
	ast isPetitFailure ifTrue: [ compilationContext parseError: ast fileName: currentFileName ].

	astNodesToInject ifNotEmpty: [ 
		ast modules: ast modules , astNodesToInject.
		astNodesToInject := #().
	].

	ast fullPath: currentFileName.
	compilationContext addTranslationUnit: ast.
]

{ #category : #accessing }
DASLCompiler >> processedDependencies [
	^ compilationContext processedDependencies
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
	| fileRef |
	fileRef := aFileName asFileReference.
	self fileName: fileRef asAbsolute fullName.
	sourceCode := fileRef contents asDastrelCollectionWithContext.
	sourceCode name: currentFileName.

]

{ #category : #accessing }
DASLCompiler >> sourceFromFileNamed: aFileName injectingNodes: theASTNodesToInject [
	| fileRef |
	fileRef := aFileName asFileReference.
	self fileName: fileRef asAbsolute fullName.
	sourceCode := fileRef contents asDastrelCollectionWithContext.
	sourceCode name: currentFileName.
	astNodesToInject := theASTNodesToInject.
]

{ #category : #targets }
DASLCompiler >> spirVTarget [
	self target: #'spir-v'
]

{ #category : #accessing }
DASLCompiler >> ssaModule [
	^ ssaModule
]

{ #category : #targets }
DASLCompiler >> ssaTarget [
	self target: #ssa
]

{ #category : #targets }
DASLCompiler >> target: target [
	codeGenerator := SLVMCodeGenerator generatorNamed: target.
]
