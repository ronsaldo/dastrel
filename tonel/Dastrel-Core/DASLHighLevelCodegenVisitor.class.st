Class {
	#name : #DASLHighLevelCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'outputStream',
		'gensymCount',
		'tabCount',
		'currentFunction',
		'visitedTranslationUnits'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> decreaseTabCount [
	tabCount := tabCount - 1.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCodeBlock: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCodeBlockPrototype: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCodeBlockPrototypes: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlockPrototype: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCodeBlocks: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlock: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCommon [
	self generatePrologue
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateEpilogue: translationUnit [
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateFunction: function [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateFunctionPrototype: function [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateFunctions: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunction: block ]		
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateFunctionsPrototypes: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunctionPrototype: block ]		
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateGraphBlock: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateGraphBlockPrototype: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateGraphBlockPrototypes: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlockPrototype: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateGraphBlocks: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlock: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generatePrologue: translationUnit [
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateSemanticBlock: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateSemanticBlocks: translationUnit [
	translationUnit modules select: #isSemanticBlock thenDo: [ :block | self generateSemanticBlock: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateTranslationUnit: translationUnit [
	self
		generateUniformBlocks: translationUnit;
		generateUniformGlobals: translationUnit;
		generateSemanticBlocks: translationUnit;
		generateFunctionsPrototypes: translationUnit;
		generateCodeBlockPrototypes: translationUnit;
		generateGraphBlockPrototypes: translationUnit;
		newline;
		generateFunctions: translationUnit;
		generateCodeBlocks: translationUnit;
		generateGraphBlocks: translationUnit;
		generateEpilogue: translationUnit
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateUniformBlock: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateUniformBlocks: translationUnit [
	translationUnit modules select: #isUniformBlock thenDo: [ :block | self generateUniformBlock: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateUniformGlobal: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateUniformGlobals: translationUnit [
	translationUnit modules select: #isUniformGlobal thenDo: [ :block | self generateUniformGlobal: block ]
]

{ #category : #utilties }
DASLHighLevelCodegenVisitor >> gensym [
	gensymCount := gensymCount + 1.
	^ ('gensym' , gensymCount printString) asSymbol
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> increaseTabCount [
	tabCount := tabCount + 1.
]

{ #category : #initialization }
DASLHighLevelCodegenVisitor >> initialize [
	super initialize.
	gensymCount := 0.
	tabCount := 0.
	visitedTranslationUnits := Set new.
	
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> mapType: aType [
	^ self subclassResponsibility
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> newline [
	outputStream lf
]

{ #category : #'as yet unclassified' }
DASLHighLevelCodegenVisitor >> passOn: anAst [
	^ ByteString streamContents: [ :out |
		outputStream := out.
		self generateCommon.
		anAst accept: self.
	]
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> prepareCodeGeneration: translationUnit [
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> printLine: line [
	self printTabs;
		printString: line;
		newline
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> printString: string [
	outputStream nextPutAll: string
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> printTabs [
	1 to: tabCount do: [ :v | outputStream nextPutAll: '    ' ].
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> printType: aType [
	self printString: (self mapType: aType)
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> visitAssignment: assignment [
	^ ByteString streamContents: [ :out |
		out
			nextPutAll: (assignment reference accept: self);
			nextPut: $ ;
			nextPutAll: assignment operation;
			nextPut: $ ;
			nextPutAll: (assignment value accept: self)
	]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitBinaryOperation: binaryOperation [
	| leftExpr rightExpr |
	leftExpr := binaryOperation left accept: self.
	rightExpr := binaryOperation right accept: self.
	^ '(' , leftExpr , binaryOperation operation , rightExpr, ')'
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitCallExpression: callExpression [
	| firstArg |
	^ ByteString streamContents: [:out |
		out nextPutAll: (callExpression reference accept: self);
			nextPut: $(.
		firstArg := true.
		callExpression arguments do: [ :arg |
			firstArg ifFalse: [ out nextPut: $,] ifTrue: [ firstArg := false ].
			out nextPutAll: (arg accept: self).
		].
		out nextPut: $)
	]
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> visitExpressionStatement: expressionStatement [
	self
		printTabs;
		printString: (expressionStatement expression accept: self);
		printString: ';';
		newline
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitIdentifier: identifier [
	| binding |
	binding := identifier binding.
	binding isType ifTrue: [ ^ self mapType: binding ].
	^ binding codegenValue
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitLocalDeclaration: localDeclaration [
	self printTabs;
		printType: localDeclaration type;
		printString: ' ';
		printString: localDeclaration name.
	localDeclaration codegenValue: localDeclaration name.
	localDeclaration initialValue ifNotNil: [
		self printString: ' = ';
			printString: (localDeclaration initialValue accept: self).
	].
	self printString: ';'; newline.
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> visitMemberAccessExpression: memberAccess [
	| globalRefValue |
	globalRefValue := memberAccess globalReferenceValue.
	globalRefValue ifNotNil: [ ^ globalRefValue codegenValue ].
	
	^ (memberAccess reference accept: self) , '.' , memberAccess memberName
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitReturnStatement: returnStatement [
	| returnValue returnVariables |
	returnValue := returnStatement value.
	returnValue size = 0 ifTrue: [ ^ self printLine: 'return;' ].
	returnValue size = 1 ifTrue: [ ^ self printLine: 'return ' , (returnValue first accept: self) , ';' ].
	self
		printLine: '{';
		withIndentation: [
			returnVariables := currentFunction prototype codegenReturnVariables.
			1 to returnValue size do: [ :i |
				self printTabs;
					printString: (returnVariables at: i);
					printString: ' = ';
					printString: ((returnValue at: i) accept: self);
					printString: ';'.
			].
			self printLine: 'return;'.
		];
		printLine: '}'.
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> visitTranslationUnit: translationUnit [
	(visitedTranslationUnits includes: translationUnit) ifTrue: [ ^ self ].
	visitedTranslationUnits add: translationUnit.
	translationUnit importedUnits do: [ :unit | unit accept: self ].
	
	self prepareCodeGeneration: translationUnit.
	self generateTranslationUnit: translationUnit.

]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitUsingStatement: usingStatement [
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> withIndentation: aBlock [
	self increaseTabCount.
	aBlock ensure: [ self decreaseTabCount ]
]
