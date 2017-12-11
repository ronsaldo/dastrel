Class {
	#name : #DASLBlockSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#instVars : [
		'currentFunction',
		'samplerBuiltIns',
		'loopLevel',
		'propertyEvaluator'
	],
	#classVars : [
		'SwizzleComponentIndices'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #'as yet unclassified' }
DASLBlockSemanticVisitor class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	SwizzleComponentIndices := Dictionary newFromPairs: #(
		$x 0
		$y 1
		$z 2
		$w 3
		
		$r 0
		$g 1
		$b 2
		$a 3
		
		$s 0
		$t 1
		$p 2
		$q 3
	)
]

{ #category : #'overload lookup' }
DASLBlockSemanticVisitor >> findIn: functionGroup bestMatchingType: checkTypes at: position [
	"Find an exact match first, removing reference types"
	| bestScore bestScoreSet score |
	functionGroup alternatives do: [ :alternative |
			(self compareAlmostExactTypes: alternative functionType arguments with: checkTypes) ifTrue: [
			^ alternative
		]
	].

	"Find the best possible match"
	bestScore := nil.
	bestScoreSet := OrderedCollection new.
	functionGroup alternatives do: [ :alternative |
		score := self compareTypes: alternative functionType arguments with: checkTypes.
		score >= 0 ifTrue: [ 
			(bestScore isNil or: [ score < bestScore ]) ifTrue: [ 
				bestScore := score.
				bestScoreSet removeAll.
			].
	
			score = bestScore ifTrue: [
				bestScoreSet add: alternative.
			]
		]
	].
	bestScoreSet size = 1 ifTrue: [ ^ bestScoreSet first ].
	self error: 'Failed to find suitable function overload for "',  functionGroup name , '".' at: position.
]

{ #category : #initialization }
DASLBlockSemanticVisitor >> initialize [
	super initialize.
	samplerBuiltIns := DASLBuiltInFunctions builtInSamplerFunctions.
	loopLevel := 0.
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitAssignment: assignment [
	| referenceType valueType operationSymbol functionGroup matchingFunction |
	assignment reference accept: self.
	assignment value accept: self.

	referenceType := assignment reference type.
	referenceType isReferenceType ifFalse: [ self error: 'a variable reference is required to perform the assignment.' at: assignment ].
		
	assignment operation = #= ifTrue: [
		valueType := assignment value type
	] ifFalse: [
		operationSymbol := assignment operation allButLast asSymbol.
		functionGroup := self lookOperationFunctionGroup: operationSymbol at: assignment.
		matchingFunction := self findIn: functionGroup bestMatchingType: { assignment reference type. assignment value type} at: assignment.
		assignment coercionType: (valueType := matchingFunction coercionType).
		assignment builtInFunction: matchingFunction.
	].

	self checkImplicitCoercion: valueType to: referenceType baseType on: assignment.
	assignment type: referenceType.
	
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitBinaryOperation: operation [
	| functionGroup matchingFunction |
	operation left accept: self.
	operation right accept: self.

	functionGroup := self lookOperationFunctionGroup: operation operation at: operation.
	matchingFunction := self findIn: functionGroup bestMatchingType: { operation left type . operation right type} at: operation.
	operation builtInFunction: matchingFunction.
	operation coercionType: matchingFunction coercionType.
	operation type: matchingFunction functionType returnType
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitBlockStatement: block [
	block scope: (DASLexicalScope new parentScope: currentScope).
	self withScope: block scope do: [ 
		block statements do: [ :statement | statement accept: self ]
	]
	
]

{ #category : #'as yet unclassified' }
DASLBlockSemanticVisitor >> visitBreakStatement: statement [
	loopLevel = 0 ifTrue: [
		self error: 'Continue is not being used in a loop.' at: statement
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitBufferBlock: interface [
	propertyEvaluator validateBufferBlockProperties: interface
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCallBlockStatement: callBlockStatement [
	| block |
	callBlockStatement blockReference accept: self.
	(callBlockStatement blockReference type isBlockType and: [callBlockStatement blockReference type block isCallableBlock ]) ifFalse: [
		self error: 'Expected code_block or graph_block for calling.' at: callBlockStatement blockReference
	].

	block := callBlockStatement blockReference type block.
	callBlockStatement arguments keysAndValuesDo: [ :name :argument |
		block inputs at: name ifAbsent: [ self error: 'Unknown block argument.' at: argument ].
		argument accept: self.
		self checkImplicitCoercion: argument type to: (block inputs at: name) type on: argument
	].

	callBlockStatement results keysAndValuesDo: [ :name :variable |
		block outputs at: name ifAbsent: [ self error: 'Unknown block result.' at: variable ].
		variable accept: self.
		self checkImplicitCoercion: variable type to: (block outputs at: name) type on: variable
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCallExpression: expression [
	| functionType functionGroup argumentTypes matchingFunction castType |
	expression reference accept: self.
	expression arguments do: [ :arg | arg accept: self ].
	
	argumentTypes := expression arguments collect: #type.
	functionType := expression reference type.
		
	"Overloaded function"
	functionType isFunctionGroupType ifTrue: [
		functionGroup := functionType functionGroup.
		matchingFunction := self findIn: functionGroup bestMatchingType: argumentTypes at: expression.
		expression solvedFunction: matchingFunction.
		expression type: matchingFunction functionType returnType.
		^ self.
	].

	"Construction or cast"
	functionType isTypeWrapper ifTrue: [
		"TODO: Perform type checking with the constructors"
		castType := functionType wrapped.
		expression type: castType.
		^ self
	].

	self error: 'Cannot call object of type "', functionType printString , '".' at: expression.

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCodeBlock: codeBlock [
	self withScope: codeBlock scope do: [
		codeBlock body do: [ :el | el accept: self. ]
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitConditionalExpression: expression [
	| condition trueValue falseValue |
	condition := expression condition.
	trueValue := expression trueValue.
	falseValue := expression falseValue.
	
	self
		visitNode: condition;
		visitNode: trueValue;
		visitNode: falseValue.
		
	self checkImplicitCoercion: condition type to: DASLType boolType on: expression.

	expression type: trueValue type withoutReference.
	(expression type = falseValue type withoutReference) ifFalse: [ 
		self error: 'Cannot determine the return type of a conditional expression' at: expression
	].

]

{ #category : #'as yet unclassified' }
DASLBlockSemanticVisitor >> visitContinueStatement: statement [
	loopLevel = 0 ifTrue: [
		self error: 'Continue is not being used in a loop.' at: statement
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitDoWhileStatement: statement [
	statement condition accept: self.
	self withLoop: [ 
		statement body accept: self.
	].
	
	(self hasImplicitCoercion: statement condition type to: DASLType boolType) ifFalse: [
		self error: 'Do while statement condition has to be a boolean expression.' at: statement.
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitForStatement: statement [
	statement scope: (DASLexicalScope new parentScope: currentScope).
	self withScope: statement scope do: [ 
		statement initStatement accept: self.
		statement condition ifNotNil: [
			statement condition accept: self.
			(self hasImplicitCoercion: statement condition type to: DASLType boolType) ifFalse: [
				self error: 'For statement condition has to be a boolean expression.' at: statement.
			]
		].
		statement increment ifNotNil: [
			statement increment accept: self
		].
	
		self withLoop: [ 
			statement body accept: self.
		].
	]

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFunction: function [
	currentFunction := function.
	self withScope: function scope do: [
		function body do: [ :el | el accept: self. ]
	].
	currentFunction := nil
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitIfStatement: statement [
	statement condition accept: self.
	statement thenStatement accept: self.
	statement elseStatement ifNotNil: [ statement elseStatement accept: self ].
	
	(self hasImplicitCoercion: statement condition type to: DASLType boolType) ifFalse: [
		self error: 'If statement condition has to be a boolean expression.' at: statement.
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitImportStatement: importStatement [
	"Nothing to do"
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitInterface: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitLocalDeclaration: declaration [
	declaration flow ifNotNil: [ ^ self ].
	
	declaration initialValue ifNotNil: [ 
		declaration initialValue accept: self.
	].

	self resolveTypeOf: declaration inferWith: declaration initialValue.
	
	declaration initialValue ifNotNil: [
		self checkImplicitCoercion: declaration initialValue type to: declaration type on: declaration
	].
	
	currentScope at: declaration name put: declaration ifPresent: [ 
		self error: 'local variable overrides an existing variable in the same lexical scope.' at: declaration.
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitMemberAccessExpression: memberAccess [
	| referencedType member baseType samplerFunction index |
	memberAccess reference accept: self.
	
	referencedType := memberAccess reference type.
	referencedType isBlockType ifTrue: [ 
		| block |
		block := referencedType block.
		block isGlobalConnectionBlock ifTrue: [
			member := block scope lookSymbol: memberAccess memberName.
			member ifNil: [ self error: 'Failed to find member "' ,  memberAccess memberName , '" in block "' , block name, '".' at:  memberAccess ].
			memberAccess memberIndex: member fieldIndex.
			memberAccess type: member referenceType.
			memberAccess globalReferenceValue: member.
			memberAccess accessKind: #global.
			^ self
		].
	
		self error: 'Cannot access member of non global connection block.' at: memberAccess.
	].

	baseType := referencedType.
	referencedType isReferenceType ifTrue: [ baseType := referencedType baseType ].
	baseType isSamplerType ifTrue: [
		samplerFunction := samplerBuiltIns at: memberAccess memberName ifAbsent: [ 
			self error: 'Failed to find sampler member named ' , memberAccess memberName at: memberAccess.
		]. 
		memberAccess type: samplerFunction referenceType.
		memberAccess accessKind: #sampling.
		^ self
	].

	baseType isVectorType ifTrue: [
		memberAccess memberIndex: (memberAccess memberName collect: [:c |
			index := SwizzleComponentIndices at: c ifAbsent: [
				self error: 'Invalid swizzle component ' , c asString at: memberAccess.
			].
			index >= baseType elements ifTrue: [ 
				self error: 'Swizzle component ' , c asString at , ' is out of bounds.' at: memberAccess.
			].
			index
		] as: Array).
		memberAccess accessKind: #swizzle.
		memberAccess memberIndex size > 4 ifTrue: [ 
			self error: 'Invalid swizzle with more than for components.' at: memberAccess.
		].
		memberAccess memberIndex size > 1 ifTrue: [
			memberAccess type: (DASLVectorType baseType: baseType baseType elements: memberAccess memberIndex size)
		] ifFalse: [
			memberAccess type: baseType baseType.
		].
		^ self
	].

	baseType isStructureType ifTrue: [
		self assert: referencedType isReferenceType.
		memberAccess memberIndex: (baseType names indexOf: memberAccess memberName ifAbsent: [
			self error: 'Failed to find member "' ,  memberAccess memberName , '" in structure "' , baseType name, '".' at:  memberAccess
		]) - 1.
		memberAccess accessKind: #structure.
		memberAccess type: (DASLReferenceType baseType: (baseType types at: memberAccess memberIndex + 1) storage: referencedType storage).
		^ self
	].
 
	self halt.
	"TODO: Check the referenced type. Ensure the member exist."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPostfixUnaryOperation: operation [
	operation operand accept: self.
	"TODO: Check the types of the operands and compute the result types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPrefixUnaryOperation: operation [
	| functionGroup matchingFunction |
	operation operand accept: self.
	
	functionGroup := self lookOperationFunctionGroup: (#pre , operation operation) asSymbol at: operation.
	matchingFunction := self findIn: functionGroup bestMatchingType: { operation operand type} at: operation.
	operation builtInFunction: matchingFunction.
	operation coercionType: matchingFunction coercionType.
	operation type: matchingFunction functionType returnType
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitReturnStatement: returnStatement [
	| expectedReturnType returnType |
	currentFunction ifNil: [
		returnStatement value ifNil: [ ^ self ].
		self error: 'return only can be used inside of functions' at: returnStatement
	].
	
	returnStatement value do: [ :val | val accept: self ].
	
	expectedReturnType := currentFunction functionType returnType.
	returnType := self arrayOfTypesToTuple: (returnStatement value collect: #type).
	self checkImplicitCoercion: returnType to: expectedReturnType on: returnStatement.
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitSemanticBlock: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitStructureBlock: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitSubscriptExpression: subscriptAccess [
	| referencedType baseType elementType isBounded elements |
	subscriptAccess reference accept: self.
	subscriptAccess index accept: self.
	
	referencedType := subscriptAccess reference type.
	referencedType isReferenceType ifFalse: [ self error: 'Expected a reference.' at: subscriptAccess ].
	baseType := referencedType baseType.
	(baseType isArrayType or: [ baseType isMatrixType or: [ baseType isVectorType ]]) ifFalse: [ self error: 'Expected an array.' at: subscriptAccess ].

	baseType isMatrixType ifTrue: [ 
		elementType := baseType columnType.
		isBounded := true.
		elements := baseType columns.
	] ifFalse: [ 
		baseType isVectorType ifTrue: [ 
			elementType := baseType baseType.
			isBounded := true.
			elements := baseType elements.
		] ifFalse: [
			elementType := baseType baseType.
			isBounded := baseType isBounded.
			elements := baseType elements.
		]
	].

	(self hasImplicitCoercion: subscriptAccess index type to: DASLType intType) ifTrue: [ 
		subscriptAccess coercionType: DASLType intType.
	] ifFalse: [ 
		(self hasImplicitCoercion: subscriptAccess index type to: DASLType uintType) ifTrue: [ 
			subscriptAccess coercionType: DASLType uintType.
		] ifFalse: [ 
			self error: 'Expected an integer index.' at: subscriptAccess index
		]
	].

	(isBounded and: [ subscriptAccess index isConstantExpression and: [ subscriptAccess index evaluateConstant >= elements ] ]) ifTrue: [
		self error: 'Array access is outside of bounds.' at: subscriptAccess index
	]. 

	subscriptAccess type: (DASLReferenceType baseType: elementType storage: referencedType storage).
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitTranslationUnit: translationUnit [
	propertyEvaluator := DASLPropertyEvaluator new compilationContext: compilationContext.
	self withScope: translationUnit package do: [
		translationUnit modules do: [ :module | module accept: self ]
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUniformBlock: interface [
	propertyEvaluator validateUniformBlockProperties: interface
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUniformGlobal: uniformGlobal [
	propertyEvaluator validateUniformGlobalProperties: uniformGlobal
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUsingStatement: usingStatement [
	| usedType identifier useScope |
	usingStatement expression accept: self.
	identifier := usingStatement identifier.
	identifier ifNotNil: [
		usedType := usingStatement expression type.
		usedType isReferenceType ifTrue: [
			usingStatement type: usedType.
			currentScope at: identifier value put: usingStatement ifPresent: [ 
				self error: 'alias overrides an existing variable in the same lexical scope.' at: usingStatement.
	].
			^ self
		].

		"TODO: Implement this"
		self halt.
	].

	usedType := usingStatement expression type.
	useScope := usedType useScope.
	useScope ifNil: [ self error: 'cannot be used.' at: usingStatement ].
	
	currentScope addUseScope: useScope.
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitWhileStatement: statement [
	statement condition accept: self.
	self withLoop: [ 
		statement body accept: self.
	].
	
	(self hasImplicitCoercion: statement condition type to: DASLType boolType) ifFalse: [
		self error: 'While statement condition has to be a boolean expression.' at: statement.
	]
]

{ #category : #'as yet unclassified' }
DASLBlockSemanticVisitor >> withLoop: aBlock [
	| oldLoopLevel |
	oldLoopLevel := loopLevel.
	loopLevel := loopLevel + 1.
	aBlock ensure: [ loopLevel := oldLoopLevel ]

]
