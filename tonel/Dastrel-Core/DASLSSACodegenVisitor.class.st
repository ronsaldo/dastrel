Class {
	#name : #DASLSSACodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'ssaModule',
		'currentFunction',
		'builder',
		'entryBlock',
		'allocaBuilder',
		'visitedTranslationUnits'
	],
	#classVars : [
		'BinaryOperationMap'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'as yet unclassified' }
DASLSSACodegenVisitor class >> initialize [
	"
	self initialize
	"
	BinaryOperationMap := Dictionary newFromPairs: #(
		+ (add fadd)
		- (sub fsub)
		* (mul fmul)
		/ (div fdiv)
		% (rem frem)
		
		& (bitand nil)
		| (bitor nil)
		^ (bitxor nil)
		
		<< (shiftleft nil)
		>> (shiftright nil)
		
		<  (ilt uflt)
		<= (ile ufle)
		>= (ige ufge)
		>  (igt ufgt)
		== (ieq ufeq)
		!= (ieq ufne)
	)
]

{ #category : #coercing }
DASLSSACodegenVisitor >> coerce: value into: targetType [
	| valueType |
	self flag: 'TODO: Implement this properly.'.
	valueType := value type.
	valueType = targetType ifTrue: [ ^ value ].
	targetType isReferenceType ifTrue: [ self error: 'invalid implicit conversion between reference types.' ].
	valueType isReferenceType ifTrue: [ ^ self coerce: (builder load: value) into: targetType ].
	self halt.
]

{ #category : #coercing }
DASLSSACodegenVisitor >> constructVector: type arguments: arguments [
	| baseType expandedArguments |
	baseType := type baseType.
	expandedArguments := OrderedCollection new.
	arguments do: [ :arg | self extractImplicitVectorElements: arg typeElement: baseType into: expandedArguments].
	self assert: expandedArguments size = type elements.
	^ builder makeVector: type arguments: expandedArguments asArray
]

{ #category : #coercing }
DASLSSACodegenVisitor >> extractImplicitVectorElements: vectorOrScalar typeElement: typeElement into: expandedArguments [
	| vectorOrScalarTypeNoRef loadedVector |
	vectorOrScalarTypeNoRef := vectorOrScalar type.
	vectorOrScalarTypeNoRef isReferenceType ifTrue: [ vectorOrScalarTypeNoRef := vectorOrScalarTypeNoRef baseType ].
	vectorOrScalarTypeNoRef isVectorType ifTrue: [
		loadedVector := self coerce: vectorOrScalar into: vectorOrScalarTypeNoRef.
		self assert: vectorOrScalarTypeNoRef baseType = typeElement.
		1 to: vectorOrScalarTypeNoRef elements do: [ :i |
			expandedArguments add: (builder extractVector: loadedVector element: (builder constInt: i-1))
		].
		^ self
	].

	"It has to be an scalar."
	expandedArguments add: (self coerce: vectorOrScalar into: typeElement) 
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateBuiltInCall: builtInFunction self: selfArgument arguments: arguments [
	| functionType expectedArgumentTypes coercedArguments leftValue rightValue selfType selfBaseType |
	functionType := builtInFunction functionType.
	expectedArgumentTypes := functionType arguments.
	coercedArguments := arguments collectWithIndex: [ :argument :index |
		self coerce: argument into: (expectedArgumentTypes at: index)
	].

	selfArgument ifNotNil: [
		selfType := selfArgument type.
		self assert: selfType isReferenceType.
		selfBaseType := selfType baseType.
		selfBaseType isSamplerType ifTrue: [
			self assert: arguments size >= 1.
			^ self generateSampler: selfArgument operation: builtInFunction name argument: arguments.
		].
	].

	(arguments size = 2 and: [BinaryOperationMap includesKey: builtInFunction name]) ifTrue: [ 
		"Give a special treatment to the multiplication"
		builtInFunction name = #* ifTrue: [ 
			^ self generateMultiplication: coercedArguments first with: coercedArguments second
		].
	
		leftValue := coercedArguments first.
		rightValue := coercedArguments right.
		
		self halt.
	].

	self halt.
]

{ #category : #coercing }
DASLSSACodegenVisitor >> generateCastOrConstructionOf: type arguments: argumentValues [
	type isVectorType ifTrue: [ ^ self constructVector: type arguments: argumentValues ].
	self halt.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlock: aCodeBlock [
	| contentBlock |
	currentFunction := aCodeBlock codegenValue.
	aCodeBlock attributes keysAndValuesDo: [ :key :value |
		currentFunction propertyAt: key value asSymbol put: value value
	].

	builder := DAIRBuilder on: currentFunction.

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := DAIRBuilder on: currentFunction.
	allocaBuilder currentBlock: entryBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		aCodeBlock body do: [ :statement |
			builder isLastTerminator ifFalse: [ statement accept: self ]
		].
		
		builder isLastTerminator ifFalse: [ builder returnVoid ]
	].

	allocaBuilder jump: contentBlock

]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlockPrototype: aCodeBlock [
	"TODO: Generate the proper function type."
	| functionType |
	functionType := DASLFunctionType arguments: #() returnType: DASLType voidType.
	aCodeBlock codegenValue: (DAIRFunction name: aCodeBlock name functionType: functionType).
	ssaModule add: aCodeBlock codegenValue.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlockPrototypes: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlockPrototype: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlocks: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunction: aFunctionNode [
	| contentBlock argumentValues |
	currentFunction := ssaModule globalNamed: aFunctionNode mangledName.
	builder := DAIRBuilder on: currentFunction.
	argumentValues := currentFunction arguments.
	aFunctionNode prototype arguments doWithIndex: [ :protoArg :index |
		protoArg codegenValue: (argumentValues at: index)
	].

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := DAIRBuilder on: currentFunction.
	allocaBuilder currentBlock: entryBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		aFunctionNode body do: [ :statement |
			builder isLastTerminator ifFalse: [ statement accept: self ]
		].
	
		builder isLastTerminator ifFalse: [
			currentFunction returnType isVoidType ifTrue: [
				builder returnVoid
			] ifFalse: [
				self error: 'not all the control flow paths in ' , aFunctionNode name , ' return something.'
			]
		]
	].

	allocaBuilder jump: contentBlock
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctionPrototype: aFunctionNode [
	| functionType function |
	functionType := aFunctionNode functionType.
	function := DAIRFunction name: aFunctionNode mangledName functionType: functionType.
	aFunctionNode codegenValue: function.
	ssaModule add: function.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctions: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunction: block ]		
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctionsPrototypes: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunctionPrototype: block ]		
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateGraphBlockPrototypes: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlockPrototype: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateGraphBlocks: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateMultiplication: leftValue with: rightValue [
	| leftType rightType |
	leftType := leftValue type.
	rightType := rightValue type.
	(leftType isMatrixType and: rightType isMatrixType) ifTrue: [
		^ builder mulMatrix: leftValue withMatrix: rightValue.
	].
 
	(leftType isMatrixType and: rightType isVectorType) ifTrue: [
		^ builder mulMatrix: leftValue withVector: rightValue.
	].

	(leftType isVectorType and: rightType isMatrixType) ifTrue: [
		^ builder mulVector: leftValue withMatrix: rightValue.
	].

	(leftType isFloatType or: [ leftType isVectorType  and: [leftType baseType isFloatType ] ]) ifTrue: [ 
		^ builder fmul: leftValue with: rightValue 
	] ifFalse: [
		^ builder mul: leftValue with: rightValue
	]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSampler: sampler operation: operation argument: arguments [
	| texture loadedSampler combinedSampler texcoord |
	texture := arguments first.
	texcoord := arguments second.
	loadedSampler := builder load: sampler.
	combinedSampler := builder combineSampler: loadedSampler with: texture.
	operation = #sample ifTrue: [ 
		^ builder sample: combinedSampler implicitLodAtCoord: texcoord
	].
	self halt.
	
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticBlock: semanticBlock [
	| prefix |
	prefix := semanticBlock name , '.'.
	semanticBlock body do: [ :var | self generateSemanticVar: var prefix: prefix].
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticBlocks: translationUnit [
	translationUnit modules select: #isSemanticBlock thenDo: [ :block | self generateSemanticBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticVar: aVariable prefix: namePrefix [
	| fullName globalVar |
	fullName := namePrefix , aVariable name.
	globalVar := DAIRGlobalVariable name: fullName valueType: aVariable type storage: aVariable storage.
	aVariable codegenValue: globalVar.
	globalVar propertyAt: #location put: aVariable flow location.
	ssaModule add: globalVar.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlock: uniformBlock [
	| elementTypes blockType globalVar |
	elementTypes := uniformBlock body collect: #type.
	blockType := DASLStructureType types: elementTypes.
	globalVar := DAIRGlobalVariable name: uniformBlock name valueType: blockType storage: DASLType uniformStorage.
	uniformBlock attributes keysAndValuesDo: [ :key :value |
		globalVar propertyAt: key value asSymbol put: value value
	].

	ssaModule add: globalVar.
	uniformBlock codegenValue: globalVar.
	
	uniformBlock body do: [ :var |
		var codegenValue: [:currentBuilder |
			currentBuilder getReference: globalVar element: (DAIRConstantValue int: var fieldIndex)
		]
	].

]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlocks: translationUnit [
	translationUnit modules select: #isUniformBlock thenDo: [ :block | self generateUniformBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformGlobal: uniformGlobal [
	| globalVar |
	globalVar := DAIRGlobalVariable name: uniformGlobal name valueType: uniformGlobal type storage: DASLType uniformConstantStorage.
	uniformGlobal codegenValue: globalVar.
	uniformGlobal attributes keysAndValuesDo: [ :key :value |
		globalVar propertyAt: key value asSymbol put: value value
	].

	ssaModule add: globalVar.

]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformGlobals: translationUnit [
	translationUnit modules select: #isUniformGlobal thenDo: [ :block | self generateUniformGlobal: block ]
]

{ #category : #initialization }
DASLSSACodegenVisitor >> initialize [
	super initialize.
	visitedTranslationUnits := Set new.
]

{ #category : #compilation }
DASLSSACodegenVisitor >> passOn: ast [
	ssaModule := DAIRModule new.
	^ ast accept: self.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitAssignment: assignment [
	| value variable coercedValued |
	value := assignment value accept: self.
	variable := assignment reference accept: self.
	self assert: variable type isReferenceType.
	coercedValued := self coerce: value into: variable type baseType.
	builder store: coercedValued in: variable.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitBinaryOperation: binaryOperation [
	^ self generateBuiltInCall: binaryOperation builtInFunction self: nil arguments: {
		binaryOperation left accept: self.
		binaryOperation right accept: self.
	}

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitCallExpression: callExpression [
	| function arguments functionRefType functionType expectedArgumentTypes coercedArguments callSelf |
	function := callExpression solvedFunction ifNotNil: [
		callExpression solvedFunction isBuiltInFunction ifTrue: [ 
			arguments := callExpression arguments collect: [ :arg | arg accept: self ].
			callSelf := nil.
			callExpression solvedFunction isMember ifTrue: [
				callSelf := callExpression reference accept: self. 
			].
			^ self generateBuiltInCall: callExpression solvedFunction self: callSelf arguments: arguments
		].
	
		callExpression solvedFunction codegenValue
	] ifNil: [
		callExpression reference accept: self.
	].

	arguments := callExpression arguments collect: [ :arg | arg accept: self ].
	function isType ifTrue: [ ^ self generateCastOrConstructionOf: function arguments: arguments ].
	
	functionRefType := function type.
	self assert: functionRefType isReferenceType.
	functionType := functionRefType baseType.
	self assert: functionType isFunctionType.
	
	expectedArgumentTypes := functionType arguments.
	coercedArguments := arguments collectWithIndex: [ :argValue :index |
		self coerce: argValue into: (expectedArgumentTypes at: index)
	].

	^ builder call: function arguments: coercedArguments
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitFloat: literal [
	^ DAIRConstantValue type: literal type value: literal value
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitIdentifier: identifier [
	| binding |
	binding := identifier binding.
	^ binding isType ifTrue: [ binding ] ifFalse: [
		binding codegenValue isClosure ifTrue: [ ^ binding codegenValue value: builder ] ifFalse: [ ^ binding codegenValue ]
		
	].
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitLocalDeclaration: localDeclaration [
	| valueType variable initialValue coercedInitialValue |
	valueType := localDeclaration type.
	variable := allocaBuilder alloca: valueType name: localDeclaration name.
	localDeclaration codegenValue: variable.
	localDeclaration initialValue ifNotNil: [ 
		initialValue := localDeclaration initialValue accept: self.
		coercedInitialValue := self coerce: initialValue into: valueType.
		builder store: coercedInitialValue in: variable
	].

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitMemberAccessExpression: memberAccess [
	| globalRefValue baseReference |
	globalRefValue := memberAccess globalReferenceValue.
	globalRefValue ifNotNil: [
		globalRefValue codegenValue ifNotNil: [ 
			globalRefValue codegenValue isClosure ifTrue: [ ^ globalRefValue codegenValue value: builder ] ifFalse: [ ^ globalRefValue codegenValue ]]
	].
	
	baseReference := memberAccess reference accept: self.
	memberAccess type isFunctionGroupType ifTrue: [ ^ baseReference ].
	^ builder getReference: baseReference element: (builder constInt: memberAccess memberIndex).
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitReturnStatement: returnStatement [
	| returnType returnTypes returnValues |
	returnType := currentFunction functionType returnType.
	returnTypes := returnType isTupleType ifTrue: [ returnType types ] ifFalse: [ { returnType } ].
	returnValues := returnStatement value collect: [:value | value accept: self].
	
	returnType isVoidType ifTrue: [
		^ builder returnVoid
	].

	returnTypes size = 1 ifTrue: [
		^ builder return: (self coerce: returnValues first into: returnType)
	].

	self halt.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitTranslationUnit: translationUnit [
	(visitedTranslationUnits includes: translationUnit) ifTrue: [ ^ self ].
	visitedTranslationUnits add: translationUnit.
	translationUnit importedUnits do: [ :imported | imported accept: self ].
	
	self
		generateUniformBlocks: translationUnit;
		generateUniformGlobals: translationUnit;
		generateSemanticBlocks: translationUnit;
		generateFunctionsPrototypes: translationUnit;
		generateCodeBlockPrototypes: translationUnit;
		generateGraphBlockPrototypes: translationUnit;
		generateFunctions: translationUnit;
		generateCodeBlocks: translationUnit;
		generateGraphBlocks: translationUnit.
		
	^ ssaModule.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitUsingStatement: anUsingStatement [
	"Nothing to do, for now"
]
