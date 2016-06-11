Class {
	#name : #DASLHighLevelCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'outputStream',
		'gensymCount',
		'tabCount',
		'currentFunction',
		'visitedTranslationUnits',
		'inlineStatement'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> decreaseTabCount [
	tabCount := tabCount - 1.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateBuiltInCall: solvedFunction self: callSelf arguments: arguments [
	^ self generateCallNamed: solvedFunction name self: callSelf arguments: arguments
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateCallNamed: functionName self: callSelf arguments: arguments [
	| firstArg |
	^ ByteString streamContents: [:out |
		callSelf ifNotNil: [ 
			out nextPutAll: callSelf;
				nextPut: $..
		].
		out nextPutAll: functionName; 
			nextPut: $(.
		firstArg := true.
		arguments do: [ :arg |
			firstArg ifFalse: [ out nextPut: $,] ifTrue: [ firstArg := false ].
			out nextPutAll: arg.
		].
		out nextPut: $)
	]
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

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> generateSamplingAccess: memberAccess [
	self subclassResponsibility
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
DASLHighLevelCodegenVisitor >> generateStructure: block [
	self subclassResponsibility.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateStructures: translationUnit [
	translationUnit modules select: #isStructureBlock thenDo: [ :block | self generateStructure: block ]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> generateTranslationUnit: translationUnit [
	self
		generateStructures: translationUnit;
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
	inlineStatement := false.
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> mapType: aType [
	^ self subclassResponsibility
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> newline [
	inlineStatement ifTrue: [ ^ self ].
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
	inlineStatement ifTrue: [ ^ self printString line ].
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
	inlineStatement ifTrue: [ ^ self ].
	1 to: tabCount do: [ :v | outputStream nextPutAll: '    ' ].
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> printType: aType [
	self printString: (self mapType: aType)
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> typeSubscriptsFor: type [
	type isArrayType ifFalse: [ ^ '' ].
	^ (self typeSubscriptsFor: type baseType) , '[', (type isBounded ifTrue: [ type elements printString ] ifFalse: [ '' ]), ']'
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
DASLHighLevelCodegenVisitor >> visitBlockStatement: blockStatement [
	self 
		printLine: '{';
		withIndentation: [ blockStatement statements do: [ :statement | statement accept: self ]];
		printLine: '}'
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitBreakStatement: statement [
	self printLine: 'break;'
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitCallBlockStatement: statement [
	| block arguments variablesToDeclare resultExpression resultValue argumentExpression argumentValue first |
	block := statement blockReference type block.
	
	variablesToDeclare := OrderedCollection new.
	arguments := OrderedCollection new.
	block outputs ifNotNil: [
		block outputs keysAndValuesDo: [ :outputName :outputDecl |
			resultExpression := statement results at: outputName ifAbsent: [ nil. ].
			resultExpression ifNotNil: [
				resultValue := resultExpression accept: self
			] ifNil: [
				resultValue := self gensym
				variablesToDeclare add: { resultValue . self mapType: outputDecl type baseType }
			].
			arguments add: resultValue
		].
	].

	block inputs ifNotNil: [
		block inputs keysAndValuesDo: [ :inputName :inputDecl |
			argumentExpression := statement arguments at: inputName ifAbsent: [ nil. ].
			argumentExpression ifNotNil:[
				argumentValue := argumentExpression accept: self
			] ifNil: [
				self halt.
			].
		
			arguments add: argumentValue.
		]
	].

	variablesToDeclare do: [ :var |
		self printLine: var second , ' ' , var first, ';'
	].

	self
		printTabs;
		printString: block name;
		printString: '('.
	first := true.
	arguments do: [ :arg |
		first ifFalse: [ self printString: ', ' ].
		first := false.
		self printString: arg
	].
	self printLine: ');'.

]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitCallExpression: callExpression [
	| firstArg arguments callSelf |
	callExpression solvedFunction ifNotNil: [
		callExpression solvedFunction isBuiltInFunction ifTrue: [
			arguments := callExpression arguments collect: [ :arg | arg accept: self ].
			callSelf := nil.
			callExpression solvedFunction isMember ifTrue: [
				callSelf := callExpression reference accept: self. 
			].
			^ self generateBuiltInCall: callExpression solvedFunction self: callSelf arguments: arguments
		]
	].

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

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitContinueStatement: statement [
	self printLine: 'continue;'
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitDiscardStatement: statement [
	self printLine: 'discard;'
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
DASLHighLevelCodegenVisitor >> visitForStatement: statement [
	self
		printTabs;
		printString: 'for ( '.
	self withInlineStatement: [
		statement initStatement accept: self.
		self printString: ' '.
	].

	statement condition ifNotNil: [
		self
			printString: (statement condition accept: self);
			printString: '; '
	].
	statement increment ifNotNil: [
		self
			printString: (statement increment accept: self)
	].
	self printLine: ')'.
	statement body accept: self.

]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitIdentifier: identifier [
	| binding |
	binding := identifier binding.
	binding isType ifTrue: [ ^ self mapType: binding ].
	^ binding codegenValue
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitIfStatement: ifStatement [
	self printLine: 'if ( ' , (ifStatement condition accept: self), ' )'.
	ifStatement thenStatement accept: self.
	ifStatement elseStatement ifNotNil: [
		self printLine: 'else'.
		ifStatement elseStatement accept: self.
	]
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitLocalDeclaration: localDeclaration [
	localDeclaration flow ifNotNil: [ ^ self ].
	
	self printTabs;
		printType: localDeclaration type;
		printString: ' ';
		printString: localDeclaration name;
		printString: (self typeSubscriptsFor: localDeclaration type).
	localDeclaration codegenValue: localDeclaration name.
	localDeclaration initialValue ifNotNil: [
		self printString: ' = ';
			printString: (localDeclaration initialValue accept: self).
	].
	self printString: ';'; newline.
]

{ #category : #visitor }
DASLHighLevelCodegenVisitor >> visitMemberAccessExpression: memberAccess [
	| globalRefValue accessKind |
	globalRefValue := memberAccess globalReferenceValue.
	globalRefValue ifNotNil: [ ^ globalRefValue codegenValue ].
	
	accessKind := memberAccess accessKind.
	accessKind = #sampling ifTrue: [
		^ self generateSamplingAccess: memberAccess.
	].
	
	^ (memberAccess reference accept: self) , '.' , memberAccess memberName
]

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitPrefixUnaryOperation: prefixOperation [
	| operand |
	operand := prefixOperation operand accept: self.
	^ '(' , prefixOperation operation , operand, ')'
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
DASLHighLevelCodegenVisitor >> visitSubscriptExpression: subscriptAccess [
	| refValue indexValue |
	refValue := subscriptAccess reference accept: self.
	indexValue := subscriptAccess index accept: self.
	^ refValue , '[' , indexValue , ']'
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

{ #category : #'code generation' }
DASLHighLevelCodegenVisitor >> visitWhileStatement: statement [
	self printLine: 'while ( ' , (statement condition accept: self), ' )'.
	statement body accept: self.
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> withIndentation: aBlock [
	self increaseTabCount.
	aBlock ensure: [ self decreaseTabCount ]
]

{ #category : #'code printing' }
DASLHighLevelCodegenVisitor >> withInlineStatement: aBlock [
	| oldInlineStatement |
	oldInlineStatement := inlineStatement.
	inlineStatement := true.
	aBlock ensure: [ inlineStatement := oldInlineStatement ]
]
