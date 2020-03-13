Class {
	#name : #DASLSSACodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'ssaModule',
		'currentFunction',
		'builder',
		'entryBlock',
		'allocaBuilder',
		'visitedTranslationUnits',
		'breakBlock',
		'continueBlock',
		'currentFunctionType',
		'compilationTarget'
	],
	#classVars : [
		'BinaryOperationMap',
		'ImageFormatWhiteList',
		'UnaryOperationMap'
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
		
		<  (ilt oflt)
		<= (ile ofle)
		>= (ige ofge)
		>  (igt ofgt)
		== (ieq ofeq)
		!= (ine ofne)
	).
	
	UnaryOperationMap := Dictionary newFromPairs: #(
		#'pre-' (neg fneg)
		#'pre~' (not invalid)
	).
	
	ImageFormatWhiteList := Set newFrom: #(
		rgba8
	).
]

{ #category : #coercing }
DASLSSACodegenVisitor >> coerce: value into: targetType [
	| valueType coercedScalar |
	self flag: 'TODO: Implement this properly.'.
	targetType isSlovimType
		ifFalse: [ ^ self coerce: value into: (targetType asSlovimType: compilationTarget) ].
	valueType := value type.
	valueType = targetType
		ifTrue: [ ^ value ].
	targetType isPointerType
		ifTrue: [ self error: 'invalid implicit conversion between reference types.' ].
	valueType isPointerType
		ifTrue: [ ^ self coerce: (builder load: value) into: targetType ].
	(valueType isTextureType and: [ targetType isTextureType and: [valueType isSameButDiffersInFormatWith: targetType]])
		ifTrue: [ ^ value ].

	"Scalar to vector"
	(targetType isVectorType and: [ valueType isVectorType not ])
		ifTrue: [ coercedScalar := self coerce: value into: targetType baseType.
			^ builder
				makeVector: targetType
				arguments: ((1 to: targetType elements) collect: [ :i | coercedScalar ]) ].

	"Conversion between scalars"
	(valueType isFloatType and: [ targetType isIntegerType ]) ifTrue: [ 
		^ builder floatToIntCast: value target: targetType
	].
	(valueType isIntegerType and: [ targetType isFloatType ]) ifTrue: [ 
		^ builder intToFloatCast: value target: targetType
	].
	(valueType isIntegerType and: [ targetType isIntegerType ]) ifTrue: [
		^ builder intCast: value target: targetType
	].
	(valueType isFloatType and: [ targetType isFloatType ]) ifTrue: [
		^ builder floatingPointCast: value target: targetType
	].

	self halt
]

{ #category : #accessing }
DASLSSACodegenVisitor >> compilationTarget [
	^ compilationTarget
]

{ #category : #accessing }
DASLSSACodegenVisitor >> compilationTarget: aCompilationTarget [
	compilationTarget := aCompilationTarget
]

{ #category : #coercing }
DASLSSACodegenVisitor >> constructMatrix: type arguments: arguments [
	| baseType coercionType convertedArguments |
	baseType := type baseType.
	coercionType := type columnType.
	convertedArguments := arguments
		collect: [ :arg | self coerce: arg into: coercionType ].
	self assert: arguments size = type columns.
	^ builder
		makeMatrix: (type asSlovimType: compilationTarget)
		arguments: convertedArguments
]

{ #category : #coercing }
DASLSSACodegenVisitor >> constructVector: type arguments: arguments [
	| baseType expandedArguments targetType sourceType |
	baseType := type baseType.
	expandedArguments := OrderedCollection new.
	arguments
		do: [ :arg | 
			self
				extractImplicitVectorElements: arg
				typeElement: baseType
				into: expandedArguments ].

	targetType := (type asSlovimType: compilationTarget).
	expandedArguments size = 1 ifTrue: [ 
		sourceType := expandedArguments first type.
		(sourceType = targetType) ifTrue: [ 
			^ expandedArguments first
		].
	
		(sourceType isVectorType and: [targetType isVectorType and: [ sourceType elements = targetType elements ]] ) ifTrue: [
			^ builder vectorCastFrom: expandedArguments first into: targetType
		].
		
		self error: 'Cannot generate vector conversion'
	].
	^ builder
		makeVector: targetType
		arguments: expandedArguments asArray
]

{ #category : #visitor }
DASLSSACodegenVisitor >> convertProperties: properties for: globalVar [
	properties
		keysAndValuesDo:
			[ :key :value | globalVar propertyAt: key value asSymbol put: value value ].
]

{ #category : #coercing }
DASLSSACodegenVisitor >> extractImplicitVectorElements: vectorOrScalar typeElement: typeElement into: expandedArguments [
	| vectorOrScalarTypeNoRef loadedVector |
	vectorOrScalarTypeNoRef := vectorOrScalar type.
	vectorOrScalarTypeNoRef isPointerType ifTrue: [ vectorOrScalarTypeNoRef := vectorOrScalarTypeNoRef baseType ].
	vectorOrScalarTypeNoRef isVectorType ifTrue: [
		loadedVector := self coerce: vectorOrScalar into: vectorOrScalarTypeNoRef.
		expandedArguments add: loadedVector.
		^ self
	].

	"It has to be an scalar."
	expandedArguments add: (self coerce: vectorOrScalar into: typeElement) 
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateBufferBlock: bufferBlock [
	| elementTypes blockType globalVar fieldNames |
	elementTypes := bufferBlock body collect: #type.
	fieldNames := bufferBlock body collect: #name.
	blockType := DASLStructureType
		name: bufferBlock name
		types: elementTypes
		kind: DASLStructureType bufferBlockKind
		names: fieldNames.
	globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: bufferBlock name
		valueType: (blockType asSlovimType: compilationTarget)
		storage: DASLType uniformStorage.
	bufferBlock attributes
		keysAndValuesDo:
			[ :key :value | globalVar propertyAt: key value asSymbol put: value value ].
	ssaModule add: globalVar.
	bufferBlock codegenValue: globalVar.
	bufferBlock body
		do: [ :var | 
			var
				codegenValue: [ :currentBuilder | 
					currentBuilder
						getReference: globalVar
						element: (SLVMConstantValue int: var fieldIndex) ] ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateBufferBlocks: translationUnit [
	translationUnit modules select: #isBufferBlock thenDo: [ :block | self generateBufferBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateBuiltInCall: builtInFunction self: selfArgument arguments: arguments [
	| functionType expectedArgumentTypes coercedArguments leftValue rightValue selfType selfBaseType operand operationMapping operandType mappedOperation builtInFunctionRef |
	functionType := builtInFunction functionType.
	expectedArgumentTypes := functionType arguments.
	coercedArguments := arguments
		collectWithIndex:
			[ :argument :index | self coerce: argument into: (expectedArgumentTypes at: index) ].
	selfArgument
		ifNotNil: [ selfType := selfArgument type.
			self assert: selfType isPointerType.
			selfBaseType := selfType baseType.
			selfBaseType isSamplerType
				ifTrue: [ self assert: arguments size >= 1.
					^ self
						generateSampler: selfArgument
						operation: builtInFunction name
						argument: coercedArguments ] ].
	(arguments size = 2
		and: [ BinaryOperationMap includesKey: builtInFunction name ])
		ifTrue: [ "Give a special treatment to the multiplication"
			builtInFunction name = #*
				ifTrue: [ ^ self
						generateMultiplication: coercedArguments first
						with: coercedArguments second ].
			leftValue := coercedArguments first.
			rightValue := coercedArguments second.
			self assert: leftValue type = rightValue type.
			operandType := leftValue type.
			operationMapping := BinaryOperationMap at: builtInFunction name.
			(operandType isFloatType
				or: [ operandType isVectorType and: [ operandType baseType isFloatType ] ])
				ifTrue: [ mappedOperation := operationMapping second ]
				ifFalse: [ mappedOperation := operationMapping first ].
			^ builder
				addOperation: mappedOperation
				left: leftValue
				right: rightValue ].
	(arguments size = 1 and: [ builtInFunction name = #'pre!' ]) ifTrue: [ 
		^ builder lnot: coercedArguments first
	].

	(arguments size = 1
		and: [ UnaryOperationMap includesKey: builtInFunction name ])
		ifTrue: [ "Give a special treatment to the multiplication"
			operationMapping := UnaryOperationMap at: builtInFunction name.
			operand := coercedArguments first.
			operandType := operand type.
			(operandType isFloatType
				or: [ operandType isVectorType and: [ operandType baseType isFloatType ] ])
				ifTrue: [ mappedOperation := operationMapping second ]
				ifFalse: [ mappedOperation := operationMapping first ].
			^ builder addOperation: mappedOperation operand: operand ].
	builtInFunctionRef := SLVMConstantBuiltInFunction
		pointerSize: compilationTarget pointerSize
		name: builtInFunction canonicalName
		functionType: (builtInFunction functionType asSlovimType: compilationTarget).
	^ builder call: builtInFunctionRef arguments: coercedArguments
]

{ #category : #coercing }
DASLSSACodegenVisitor >> generateCastOrConstructionOf: type arguments: argumentValues [
	type isVectorType ifTrue: [ ^ self constructVector: type arguments: argumentValues ].
	type isMatrixType ifTrue: [ ^ self constructMatrix: type arguments: argumentValues ].
	(type isPrimitiveType and: [argumentValues size = 1]) ifTrue: [
		^ self coerce: argumentValues first into: type 
	].
	self halt.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlock: aCodeBlock [
	| contentBlock initBlock |
	currentFunction := aCodeBlock codegenValue.
	currentFunctionType := aCodeBlock functionType.
	aCodeBlock attributes keysAndValuesDo: [ :key :value |
		currentFunction propertyAt: key value asSymbol put: value value
	].

	builder := DASLSLVMBuilder on: currentFunction.

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := SLVMBuilder on: currentFunction.
	builder allocaBuilder: allocaBuilder.
	allocaBuilder currentBlock: entryBlock.

	initBlock := builder newBasicBlock: #initBlock.
	builder initializationBuilder: (SLVMBuilder on: currentFunction).
	builder initializationBuilder currentBlock: initBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		aCodeBlock body do: [ :statement |
			builder isLastTerminator ifFalse: [ statement accept: self ]
		].
		
		builder isLastTerminator ifFalse: [ builder returnVoid ]
	].

	allocaBuilder jump: initBlock.
	builder initializationBuilder jump: contentBlock

]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlockPrototype: aCodeBlock [
	"TODO: Generate the proper function type."

	| functionType argumentDecls function argDecl |
	argumentDecls := OrderedCollection new.
	aCodeBlock outputs
		ifNotNil: [ aCodeBlock outputs
				keysAndValuesDo: [ :name :decl | argumentDecls add: decl ] ].
	aCodeBlock inputs
		ifNotNil: [ aCodeBlock inputs
				keysAndValuesDo: [ :name :decl | argumentDecls add: decl ] ].
	functionType := DASLFunctionType
		arguments: (argumentDecls collect: #type)
		returnType: DASLType voidType.
	aCodeBlock functionType: functionType.
	function := SLVMFunction
		module: ssaModule
		name: aCodeBlock name
		functionType: (functionType asSlovimType: compilationTarget).
	function compilationTarget: compilationTarget.

	function inlineMode: (aCodeBlock hasPragmaNamed: #inline).
	(aCodeBlock hasPragmaNamed: #alwaysInline) ifTrue: [ 
		function inlineMode: #always.
	].

	function arguments
		doWithIndex: [ :arg :index | 
			argDecl := argumentDecls at: index.
			argDecl codegenValue: arg.
			arg name: argDecl name ].
	aCodeBlock codegenValue: function.
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
DASLSSACodegenVisitor >> generateConstantGlobal: constantGlobal [
	| globalType initializationConstant |
	globalType := constantGlobal type asSlovimType: compilationTarget.
	initializationConstant := constantGlobal type generateSSAConstant: constantGlobal initializationLiteral withGenerator: self.
	
	globalType isArrayType ifTrue: [ 
		constantGlobal codegenValue: [ :functionBuilder |
			functionBuilder generateReferenceToConstant: initializationConstant
		]
	] ifFalse: [
		constantGlobal codegenValue: initializationConstant
	].

	"globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: constantGlobal name
		valueType: globalType
		storage: DASLType uniformConstantStorage.
	globalVar initialValue: initializationConstant.
	constantGlobal codegenValue: globalVar.
	
	ssaModule add: globalVar"
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateConstantGlobals: translationUnit [
	translationUnit modules select: #isConstantGlobal thenDo: [ :block | self generateConstantGlobal: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunction: aFunctionNode [
	| contentBlock argumentValues initBlock |
	currentFunction := aFunctionNode prototype codegenValue.
	currentFunctionType := aFunctionNode prototype functionType.
	builder := DASLSLVMBuilder on: currentFunction.
	argumentValues := currentFunction arguments.
	aFunctionNode prototype arguments doWithIndex: [ :protoArg :index |
		protoArg codegenValue: (argumentValues at: index)
	].

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := SLVMBuilder on: currentFunction.
	builder allocaBuilder: allocaBuilder.
	allocaBuilder currentBlock: entryBlock.

	initBlock := builder newBasicBlock: #initBlock.
	builder initializationBuilder: (SLVMBuilder on: currentFunction).
	builder initializationBuilder currentBlock: initBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		aFunctionNode body do: [ :statement |
			builder isLastTerminator ifFalse: [ statement accept: self ]
		].

		builder isLastTerminator ifFalse: [
			currentFunction functionType returnType isVoidType ifTrue: [
				builder returnVoid
			] ifFalse: [
				self error: 'not all the control flow paths in ' , aFunctionNode name , ' return something.'
			]
		]	
	].

	allocaBuilder jump: initBlock.
	builder initializationBuilder jump: contentBlock
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctionPrototype: aFunctionNode [
	| functionType function |
	functionType := aFunctionNode functionType.
	function := SLVMFunction
		module: ssaModule
		name: aFunctionNode mangledName asSymbol
		functionType: (functionType asSlovimType: compilationTarget).
	function compilationTarget: compilationTarget.
	function unmangledName: aFunctionNode name.
	function inlineMode: (aFunctionNode hasPragmaNamed: #inline).
	(aFunctionNode hasPragmaNamed: #alwaysInline) ifTrue: [ 
		function inlineMode: #always.
	].
	
	aFunctionNode codegenValue: function.
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
DASLSSACodegenVisitor >> generateLogicalAnd: operation [
	| conditionValue resultBlock logicalContinueBlock branchInstruction phiNode leftBlock rightBlock |
	resultBlock := builder newBasicBlock: 'logicalAndResult'.
	logicalContinueBlock := builder newBasicBlock: 'logicalAndContinue'.

	"Test the first operand"
	conditionValue := self coerce: (operation left accept: self) into: DASLType boolType.
	leftBlock := builder currentBlock.
	branchInstruction := builder branch: conditionValue ifTrue: logicalContinueBlock ifFalse: resultBlock.
	branchInstruction block mergeBlock: resultBlock.
	
	"Test the second operand"
	builder currentBlock: logicalContinueBlock.
	conditionValue := self coerce: (operation right accept: self) into: DASLType boolType.
	rightBlock := builder currentBlock.
	builder jump: resultBlock.
	
	"Merge the results"
	builder currentBlock: resultBlock.
	phiNode := builder phi: SLVMType boolType name: 'landResult'.
	phiNode addValue: (SLVMConstantValue bool: false) from: leftBlock.
	phiNode addValue: conditionValue from: rightBlock.
	^ phiNode
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateLogicalOr: operation [
	| conditionValue resultBlock logicalContinueBlock branchInstruction phiNode leftBlock rightBlock |
	resultBlock := builder newBasicBlock: 'logicalOrResult'.
	logicalContinueBlock := builder newBasicBlock: 'logicalOrContinue'.

	"Test the first operand"
	conditionValue := self coerce: (operation left accept: self) into: DASLType boolType.
	leftBlock := builder currentBlock.
	branchInstruction := builder branch: conditionValue ifTrue: resultBlock ifFalse: logicalContinueBlock.
	branchInstruction block mergeBlock: resultBlock.
	
	"Test the second operand"
	builder currentBlock: logicalContinueBlock.
	conditionValue := self coerce: (operation right accept: self) into: DASLType boolType.
	rightBlock := builder currentBlock.
	builder jump: resultBlock.
	
	"Merge the results"
	builder currentBlock: resultBlock.
	phiNode := builder phi: SLVMType boolType name: 'lorResult'.
	phiNode addValue: (SLVMConstantValue bool: true) from: leftBlock.
	phiNode addValue: conditionValue from: rightBlock.
	^ phiNode
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
		texture type depth ifTrue: [ 
			^ builder sampleDepth: combinedSampler implicitLodAtCoord: texcoord
		] ifFalse: [ 
			^ builder sample: combinedSampler implicitLodAtCoord: texcoord
		]
	].

	(#(sampleLod fetchTexelLod) includes: operation) ifTrue: [ 
		texture type depth ifTrue: [ 
			^ builder sampleDepth: combinedSampler explicitLod: arguments third AtCoord: texcoord
		] ifFalse: [ 
			^ builder sample: combinedSampler explicitLod: arguments third atCoord: texcoord
		]
	].

	operation = #sampleWithDepthReference ifTrue: [ 
		^ builder sample: combinedSampler implicitLodAtCoord: texcoord depthReference: arguments third.
	].
	self halt.
	
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticBlock: semanticBlock [
	| prefix |
	prefix := semanticBlock name , '_sve_'.
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
	globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: fullName
		valueType: (aVariable type asSlovimType: compilationTarget)
		storage: aVariable storage.
	aVariable codegenValue: globalVar.
	globalVar propertyAt: #location put: aVariable flow location.
	ssaModule add: globalVar
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSharedGlobal: sharedGlobal [
	| globalVar globalType |
	globalType := sharedGlobal type asSlovimType: compilationTarget.
	
	globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: sharedGlobal name
		valueType: globalType
		storage: DASLType workgroupStorage.
	sharedGlobal codegenValue: globalVar.
	ssaModule add: globalVar
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSharedGlobals: translationUnit [
	translationUnit modules select: #isSharedGlobal thenDo: [ :block | self generateSharedGlobal: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlock: uniformBlock [
	| elementTypes blockType globalVar fieldNames storage isPushConstant |
	elementTypes := uniformBlock body collect: #type.
	fieldNames := uniformBlock body collect: #name.
	blockType := DASLStructureType
		name: uniformBlock name
		types: elementTypes
		kind: DASLStructureType blockKind
		names: fieldNames.
	isPushConstant := uniformBlock attributes keys
		detect: [ :key | key value == #push_constant ]
		ifFound: [ true ]
		ifNone: [ false ].
	storage := isPushConstant
		ifTrue: [ DASLType pushConstantStorage ]
		ifFalse: [ DASLType uniformStorage ].
	globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: uniformBlock name
		valueType: (blockType asSlovimType: compilationTarget)
		storage: storage.
	self convertProperties: uniformBlock attributes for: globalVar.
	ssaModule add: globalVar.
	uniformBlock codegenValue: globalVar.
	uniformBlock body
		do: [ :var | 
			var
				codegenValue: [ :currentBuilder | 
					currentBuilder
						getReference: globalVar
						element: (SLVMConstantValue int: var fieldIndex) ] ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlocks: translationUnit [
	translationUnit modules select: #isUniformBlock thenDo: [ :block | self generateUniformBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformGlobal: uniformGlobal [
	| globalVar typeWithoutFormat globalType |
	typeWithoutFormat := uniformGlobal type asSlovimType: compilationTarget.
	globalType := typeWithoutFormat.
	
	(typeWithoutFormat isTextureType and: [uniformGlobal attributes includesKey: #format]) ifTrue: [
		globalType := compilationTarget textureType: typeWithoutFormat versionWithFormat: (uniformGlobal attributes at: #format)
	].
	
	globalVar := SLVMGlobalVariable
		pointerSize: compilationTarget pointerSize
		name: uniformGlobal name
		valueType: globalType
		storage: DASLType uniformConstantStorage.
	uniformGlobal codegenValue: globalVar.
	self convertProperties: uniformGlobal attributes for: globalVar.
	ssaModule add: globalVar
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformGlobals: translationUnit [
	translationUnit modules select: #isUniformGlobal thenDo: [ :block | self generateUniformGlobal: block ]
]

{ #category : #initialization }
DASLSSACodegenVisitor >> initialize [
	super initialize.
	visitedTranslationUnits := Set new.
	compilationTarget := SLVM32BitsPointerCompilationTarget new.
]

{ #category : #compilation }
DASLSSACodegenVisitor >> passOn: ast [
	ssaModule := SLVMModule new compilationTarget: compilationTarget.
	ast accept: self.
	^ ssaModule
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitAssignment: assignment [
	| value variable coercedValued |
	value := assignment value accept: self.
	variable := assignment reference accept: self.
	self assert: variable type isPointerType.
	assignment builtInFunction ifNotNil: [
		value := self generateBuiltInCall: assignment builtInFunction self: nil arguments: { variable . value } 
	].

	coercedValued := self coerce: value into: variable type baseType.
	builder store: coercedValued in: variable.
	^ coercedValued
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitBinaryOperation: binaryOperation [
	binaryOperation operation = #'&&' ifTrue: [ ^ self generateLogicalAnd: binaryOperation ].
	binaryOperation operation = #'||' ifTrue: [ ^ self generateLogicalOr: binaryOperation ].

	^ self generateBuiltInCall: binaryOperation builtInFunction self: nil arguments: {
		binaryOperation left accept: self.
		binaryOperation right accept: self.
	}

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitBlockStatement: block [
	block statements do: [ :statement |
		statement accept: self.
		builder isLastTerminator ifTrue: [ ^ self ] 
	]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitBoolean: literal [
	^ SLVMConstantValue
		type: (literal type asSlovimType: compilationTarget)
		value: literal value
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitBreakStatement: statement [
	self assert: breakBlock isNotNil.
	builder jump: breakBlock
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitCallBlockStatement: statement [
	| block arguments resultValue resultExpression outputsToStore tempVar argumentExpression argumentValue |
	block := statement blockReference type block.
	arguments := OrderedCollection new.
	outputsToStore := OrderedCollection new.
	block outputs
		ifNotNil: [ block outputs
				keysAndValuesDo: [ :outputName :outputDecl | 
					resultExpression := statement results at: outputName ifAbsent: [ nil ].
					resultValue := resultExpression
						ifNotNil: [ resultExpression accept: self ]
						ifNil: [ allocaBuilder alloca: outputDecl type baseType ].
					resultValue type ~= outputDecl type
						ifTrue: [ tempVar := allocaBuilder
								alloca: (outputDecl type baseType asSlovimType: compilationTarget).
							arguments add: tempVar.
							outputsToStore
								add:
									{tempVar.
									resultValue} ]
						ifFalse: [ arguments add: tempVar ] ] ].
	block inputs
		ifNotNil: [ block inputs
				keysAndValuesDo: [ :inputName :inputDecl | 
					argumentExpression := statement arguments
						at: inputName
						ifAbsent: [ nil ].
					argumentExpression
						ifNotNil: [ argumentValue := self
								coerce: (argumentExpression accept: self)
								into: inputDecl type ]
						ifNil: [ self halt ].
					arguments add: argumentValue ] ].
	builder call: block codegenValue arguments: arguments asArray.
	outputsToStore
		do:
			[ :output | builder store: (builder load: output first) in: output second ]
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
	self assert: functionRefType isPointerType.
	functionType := functionRefType baseType.
	self assert: functionType isFunctionType.
	
	expectedArgumentTypes := functionType arguments.
	coercedArguments := arguments collectWithIndex: [ :argValue :index |
		self coerce: argValue into: (expectedArgumentTypes at: index)
	].

	^ builder call: function arguments: coercedArguments
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitConditionalExpression: expression [
	| conditionValue thenBlock mergeBlock elseBlock branchInstruction coercionType trueValue falseValue phi |
	conditionValue := self coerce: (self visitNode: expression condition) into: DASLType boolType.
	thenBlock := builder newBasicBlock: 'ifThen'.
	mergeBlock := builder newBasicBlock: 'ifMerge'.
	elseBlock := builder newBasicBlock: 'ifElse'.
	coercionType := expression type asSlovimType: compilationTarget.

	branchInstruction := builder branch: conditionValue ifTrue: thenBlock ifFalse: elseBlock.
	branchInstruction block mergeBlock: mergeBlock.

	"True value"
	builder currentBlock: thenBlock.
	trueValue := self coerce: (self visitNode: expression trueValue) into: coercionType.
	thenBlock := builder currentBlock.
	builder jump: mergeBlock.

	"False value"
	builder currentBlock: elseBlock.
	falseValue := self coerce: (self visitNode: expression falseValue) into: coercionType.
	elseBlock := builder currentBlock.
	builder jump: mergeBlock.
	
	builder currentBlock: mergeBlock.
	mergeBlock predecessors ifEmpty: [
		builder unreachable.
		branchInstruction block addUnreachableStructuredSuccessors.
		^ self
	].

	phi := builder phi: coercionType.
	phi
		addValue: trueValue from: thenBlock;
		addValue: falseValue from: elseBlock.
	^ phi
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitContinueStatement: statement [
	self assert: continueBlock isNotNil.
	builder jump: continueBlock
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitDiscardStatement: discardStatement [
	^ builder discardFragment
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitFloat: literal [
	^ SLVMConstantValue
		type: (literal type asSlovimType: compilationTarget)
		value: literal value
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitForStatement: statement [
	"Loop pre-header"
	| loopHeader condition loopBody loopMerge loopContinue branchInstruction |
	statement initStatement accept: self.
	builder isLastTerminator ifTrue: [ ^ self ]. "Dead code"
	
	"Loop header"
	loopHeader := builder newBasicBlock: 'forCondition'.
	loopBody := builder newBasicBlock: 'forBody'.
	loopMerge := builder newBasicBlock: 'forMerge'.
	loopContinue := loopHeader.
	
	statement increment ifNotNil: [	
		loopContinue := builder newBasicBlock: 'forContinue'.
	].
	
	builder
		jump: loopHeader;
		currentBlock: loopHeader.
		
	"Emit the condition."
	statement condition ifNotNil: [
		condition := self coerce: (statement condition accept: self) into: DASLType boolType.
		branchInstruction := builder branch: condition ifTrue: loopBody ifFalse: loopMerge.
	] ifNil: [
		branchInstruction := builder jump: loopBody
	].

	loopHeader
		mergeBlock: loopMerge;
		continueBlock: loopContinue.
			
	self withBreak: loopMerge continue: loopContinue do: [
		"Emit the loop body".
		builder currentBlock: loopBody.
		statement body accept: self.
		builder isLastTerminator ifFalse: [ builder jump: loopContinue ]
	].
	
	statement increment ifNotNil: [
		builder currentBlock: loopContinue.
		loopContinue predecessors ifNotEmpty: [ 
			statement increment accept: self.
			builder jump: loopHeader
		] ifEmpty: [
			builder unreachable.
			loopHeader addUnreachableStructuredSuccessors
		]
	].
	
	builder currentBlock: loopMerge.
	loopMerge predecessors ifEmpty: [
		builder unreachable.
		loopHeader addUnreachableStructuredSuccessors
	].

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
DASLSSACodegenVisitor >> visitIfStatement: statement [
	| conditionValue thenBlock mergeBlock elseBlock branchInstruction |
	conditionValue := self coerce: (statement condition accept: self) into: DASLType boolType.
	thenBlock := builder newBasicBlock: 'ifThen'.
	mergeBlock := builder newBasicBlock: 'ifMerge'.
	elseBlock := mergeBlock.
	statement elseStatement ifNotNil: [
		elseBlock := builder newBasicBlock: 'ifElse'.
	].

	branchInstruction := builder branch: conditionValue ifTrue: thenBlock ifFalse: elseBlock.
	branchInstruction block mergeBlock: mergeBlock.
	builder currentBlock: thenBlock.
	statement thenStatement accept: self.
	builder isLastTerminator ifFalse: [ builder jump: mergeBlock ].

	statement elseStatement ifNotNil: [
		builder currentBlock: elseBlock.
		statement elseStatement accept: self.
		builder isLastTerminator ifFalse: [ builder jump: mergeBlock ].
	].
	
	builder currentBlock: mergeBlock.
	mergeBlock predecessors ifEmpty: [
		builder unreachable.
		branchInstruction block addUnreachableStructuredSuccessors.
	]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitInteger: integer [
	^ SLVMConstant
		type: (integer type asSlovimType: self compilationTarget)
		value: integer value
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitLiteralType: node [
	^ node value wrapped
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitLocalDeclaration: localDeclaration [
	| valueType variable initialValue coercedInitialValue |
	localDeclaration flow ifNotNil: [ ^ self ].
	valueType := localDeclaration type.
	variable := allocaBuilder
		alloca: (valueType asSlovimType: compilationTarget)
		name: localDeclaration name.
	localDeclaration codegenValue: variable.
	localDeclaration initialValue
		ifNotNil: [ initialValue := localDeclaration initialValue accept: self.
			coercedInitialValue := self coerce: initialValue into: valueType.
			builder store: coercedInitialValue in: variable ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitMakeTupleExpression: tupleExpression [
	| elements tupleStructureType tempStructure elementValue |
	elements := tupleExpression elements collect: [ :el | el accept: self ].
	tupleStructureType := tupleExpression type asSlovimType: compilationTarget.
	tempStructure := allocaBuilder alloca: tupleStructureType.
	elements doWithIndex: [ :el :index |
		elementValue := self coerce: el into: (tupleStructureType types at: index).
		builder store: elementValue in: (builder getReference: tempStructure element: (builder constInt: index - 1) )
	].

	^ builder load: tempStructure
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitMemberAccessExpression: memberAccess [
	| globalRefValue baseReference accessKind indices |
	accessKind := memberAccess accessKind.
	globalRefValue := memberAccess globalReferenceValue.
	globalRefValue ifNotNil: [
		globalRefValue codegenValue ifNotNil: [ 
			globalRefValue codegenValue isClosure ifTrue: [ ^ globalRefValue codegenValue value: builder ] ifFalse: [ ^ globalRefValue codegenValue ]]
	].
	
	baseReference := memberAccess reference accept: self.
	
	accessKind = #swizzle ifTrue: [
		indices := memberAccess memberIndex.
		baseReference type isPointerType ifTrue: [
			baseReference := builder load: baseReference
		].
	
		indices size > 1 ifTrue: [ 
			^ builder shuffleVector: baseReference with: baseReference components: indices.
		] ifFalse: [
			^ builder extractVector: baseReference element: (builder constInt: indices first).
		].
	].

	memberAccess type isFunctionGroupType ifTrue: [ ^ baseReference ].
	^ builder getReference: baseReference element: (builder constInt: memberAccess memberIndex).
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitPostfixUnaryOperation: unaryOperation [
	^ self generateBuiltInCall: unaryOperation builtInFunction self: nil arguments: {
		unaryOperation operand accept: self
	}

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitPrefixUnaryOperation: unaryOperation [
	^ self generateBuiltInCall: unaryOperation builtInFunction self: nil arguments: {
		unaryOperation operand accept: self
	}

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitReturnStatement: returnStatement [
	| returnType returnValue |
	returnType := currentFunctionType returnType.
	returnValue := returnStatement value ifNotNil:  [:value | value accept: self].
	
	returnType isVoidType ifTrue: [
		^ builder returnVoid
	].

	^ builder return: (self coerce: returnValue into: returnType)
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitSubscriptExpression: subscriptAccess [
	| reference index |
	reference := subscriptAccess reference accept: self.	
	subscriptAccess reference type isTupleType ifTrue: [
		^ builder extractValue: reference indices: { subscriptAccess index value }
	].

	index := self coerce: (subscriptAccess index accept: self) into: subscriptAccess coercionType.
	^ builder getReference: reference element: index
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitTranslationUnit: translationUnit [
	(visitedTranslationUnits includes: translationUnit) ifTrue: [ ^ self ].
	visitedTranslationUnits add: translationUnit.
	translationUnit importedUnits do: [ :imported | imported accept: self ].
	
	self
		generateUniformBlocks: translationUnit;
		generateBufferBlocks: translationUnit;
		generateConstantGlobals: translationUnit;
		generateUniformGlobals: translationUnit;
		generateSharedGlobals: translationUnit;
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
	| usedValue |
	anUsingStatement identifier ifNotNil: [
		usedValue := anUsingStatement expression accept: self.
		anUsingStatement codegenValue: usedValue
	].

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitWhileStatement: statement [
	| conditionValue  loopHeader loopBody loopMerge branchInstruction loopContinue |
	loopHeader := builder newBasicBlock: 'whileCondition'.
	loopBody := builder newBasicBlock: 'whileBody'.
	loopMerge := builder newBasicBlock: 'whileMerge'.
	loopContinue := builder newBasicBlock: 'whileContinue'.
	
	builder
		jump: loopHeader;
		currentBlock: loopHeader.
		
	conditionValue := self coerce: (statement condition accept: self) into: DASLType boolType.
	branchInstruction := builder branch: conditionValue ifTrue: loopBody ifFalse: loopMerge.
	loopHeader
		mergeBlock: loopMerge;
		continueBlock: loopContinue.
		
	self withBreak: loopMerge continue: loopContinue do: [
		"Emit the loop body".
		builder currentBlock: loopBody.
		statement body accept: self.
		builder isLastTerminator ifFalse: [ builder jump: loopContinue ]
	].

	builder currentBlock: loopContinue.
	loopContinue predecessors ifEmpty: [ 
		builder unreachable.
		loopHeader addUnreachableStructuredSuccessors
	] ifNotEmpty: [ 
		builder jump: loopHeader.
	].

	builder currentBlock: loopMerge.
	loopMerge predecessors ifEmpty: [
		builder unreachable.
		loopHeader addUnreachableStructuredSuccessors
	].
]

{ #category : #'as yet unclassified' }
DASLSSACodegenVisitor >> withBreak: newBreakBlock continue: newContinueBlock do: aBlock [
	| oldBreak oldContinue |
	oldBreak := breakBlock.
	oldContinue := continueBlock.
	breakBlock := newBreakBlock.
	continueBlock := newContinueBlock.
	aBlock ensure: [
		breakBlock := oldBreak.
		continueBlock := oldContinue.
	]
]
