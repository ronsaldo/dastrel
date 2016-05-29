Class {
	#name : #DASLSSASpirVTranslator,
	#superclass : #Object,
	#instVars : [
		'translatedValues',
		'builder',
		'basicBlockDictionary',
		'instructionDictionary',
		'currentFunction',
		'interfaceList'
	],
	#classVars : [
		'BinaryOperationMap',
		'BuiltInExtensionInstructionMap',
		'StorageClassMap',
		'UnaryOperationMap'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #'class initialization' }
DASLSSASpirVTranslator class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	(Smalltalk at: #SpirVConstants) initialize.
	
	StorageClassMap := IdentityDictionary newFromPairs: #(
		uniformConstant 0
		input 1
		uniform 2
		output 3
		workgroup 4
		crossWorkgroup 5
		private 6
		function 7
		generic 8
		pushConstant 9
		atomicCounter 10
		image 11
	).
	
	BinaryOperationMap := Dictionary new.
	#(
		add 		SpvOpIAdd
		sub 		SpvOpISub 
		mul 		SpvOpIMul
		div 		SpvOpSDiv
		udiv 		SpvOpUDiv
		rem 		SpvOpSRem
		urem 		SpvOpURem

		bitand 	SpvOpBitwiseAnd
		bitor		SpvOpBitwiseOr
		bitxor 	SpvOpBitwiseXor

		shiftleft 	SpvOpShiftLeftLogical
		shiftright 	SpvOpShiftRightLogical
		ashiftright 	SpvOpShiftRightArithmetic

		ieq SpvOpIEqual
		ine SpvOpINotEqual

		ilt SpvOpSLessThan
		ile SpvOpSLessThanEqual
		igt SpvOpSGreaterThan
		ige SpvOpSGreaterThanEqual

		ult SpvOpULessThan
		ule SpvOpULessThanEqual
		ugt SpvOpUGreaterThan
		uge SpvOpUGreaterThanEqual

		fadd 		SpvOpFdd
		fsub 		SpvOpFSub
		fmul 		SpvOpFMul
		fdiv 		SpvOpFDiv
		frem 		SpvOpFRem
				
		uflt SpvOpFUnordLessThan
		ufle SpvOpFUnordLessThanEqual
		ufeq SpvOpFUnordEqual
		ufne SpvOpFUnordNotEqual
		ufgt SpvOpFUnordGreaterThan
		ufge SpvOpFUnordGreaterThanEqual

		oflt SpvOpFOrdLessThan
		ofle SpvOpFOrdLessThanEqual
		ofeq SpvOpFOrdEqual
		ofne SpvOpFOrdNotEqual
		ofgt SpvOpFOrdGreaterThan
		ofge SpvOpFOrdGreaterThanEqual
		
		mulMatrixMatrix SpvOpMatrixTimesMatrix
		mulMatrixVector SpvOpMatrixTimesVector
		mulVectorMatrix SpvOpVectorTimesMatrix
	) pairsDo: [ :k :v |
		BinaryOperationMap at: k put: (SpirVConstants bindingOf: v) value
	].

	UnaryOperationMap := Dictionary new.
	#(
		not SpvOpNot
		neg SpvOpSNegate
		fneg SpvOpFNegate
	) pairsDo: [ :k :v |
		UnaryOperationMap at: k put: (SpirVConstants bindingOf: v) value
	].

	BuiltInExtensionInstructionMap := Dictionary new.
	#(
		cross (glsl450 GLSLstd450Cross)
		dot (SpirV SpvOpDot)
		length (glsl450 GLSLstd450Length)
		normalize (glsl450 GLSLstd450Normalize)
	
		smoothstep (glsl450 GLSLstd450SmoothStep)
		
		transpose (SpirV SpvOpTranspose)
	) pairsDo: [ :k :v |
		BuiltInExtensionInstructionMap at: k put: { v first . (SpirVConstants bindingOf: v second) value }
	].
	
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> basicBlockLabelId: basicBlock [
	^ basicBlockDictionary at: basicBlock ifAbsentPut: [ builder newId ].
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> functionTranslation: aFunction do: aBlock [
	| oldFunction |
	^ self valueTranslation: aFunction do: [:id |
		oldFunction := currentFunction.
		currentFunction := aFunction.
		[
		builder functionDo: [ aBlock value: id]
		] ensure: [ currentFunction := aFunction ]
	]
]

{ #category : #initialization }
DASLSSASpirVTranslator >> initialize [
	super initialize.
	translatedValues := Dictionary new.
	basicBlockDictionary := Dictionary new.
	instructionDictionary := Dictionary new.
	interfaceList := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> instructionTranslation: aValue do: aBlock [
	| instructionId |
	instructionId := instructionDictionary at: aValue ifAbsentPut: [ builder newId ].
	translatedValues at: aValue put: instructionId.
	aBlock value: instructionId.
	^ instructionId.
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> translateBasicBlock: basicBlock [
	| labelId |
	labelId := self basicBlockLabelId: basicBlock.
	builder addFunctionInstruction: (SpirVInstruction opcode: SpvOpLabel result: labelId).
	basicBlock instructions do: [ :ins | ins accept: self ] 
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> translateSSAModule: ssaModule [
	^ SpirVModuleBuilder build: [ :builderArg |
		builder := builderArg.
		ssaModule globalValues valuesDo: [ :globalValue | self translateValue: globalValue ]
	]
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> translateValue: aValue [
	^ translatedValues at: aValue ifAbsent: [ aValue accept: self ]
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> valueTranslation: aValue do: aBlock [
	| valueId |
	(aValue isType not and: [aValue isInstruction]) ifTrue: [ ^ instructionDictionary at: aValue ifAbsentPut: [ builder newId ]].
	valueId := builder newId.
	translatedValues at: aValue put: valueId.
	aBlock value: valueId.
	^ valueId.
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitAlloca: allocaInstruction [
	| resultType |
	^ self instructionTranslation: allocaInstruction do: [ :id |
		resultType := self translateValue: allocaInstruction type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpVariable
			type: resultType
			result: id
			operands: { SpvStorageClassFunction })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitBinaryOperation: binaryOp [
	| opcode resultType left right |
	^ self instructionTranslation: binaryOp do: [ :id |
		opcode := BinaryOperationMap at: binaryOp operation.
		resultType := self translateValue: binaryOp type.
		left := self translateValue: binaryOp left.
		right := self translateValue: binaryOp right.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: opcode
			type: resultType
			result: id
			operands: { left . right }
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitBoolType: voidType [
	^ self valueTranslation: voidType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeBool
			result: id
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitBranch: branchInstruction [
	| condition trueBlock falseBlock mergeBlock continueBlock |
	^ self instructionTranslation: branchInstruction do: [ :id |
		condition := self translateValue: branchInstruction condition.
		trueBlock := self basicBlockLabelId: branchInstruction trueBlock. 
		falseBlock := self basicBlockLabelId: branchInstruction falseBlock. 
		branchInstruction mergeBlock ifNotNil: [
			mergeBlock := self basicBlockLabelId: branchInstruction mergeBlock.
			branchInstruction continueBlock ifNotNil: [
				continueBlock := self basicBlockLabelId: branchInstruction continueBlock.
				builder addFunctionInstruction: (SpirVInstruction
					opcode: SpvOpLoopMerge 
					operands: { mergeBlock . continueBlock . SpvLoopControlNone }
				)
			] ifNil: [
				builder addFunctionInstruction: (SpirVInstruction
					opcode: SpvOpSelectionMerge 
					operands: { mergeBlock . SpvSelectionControlNone }
				)
			]
		].
	
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpBranchConditional
			operands: { condition . trueBlock . falseBlock }
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitCall: callInstruction [
	| resultType function arguments functionValue setInstructionPair extensionSet extensionInstruction |
	^ self instructionTranslation: callInstruction do: [ :id |
		functionValue := callInstruction functionValue.
		resultType := self translateValue: callInstruction type.
		arguments := callInstruction arguments collect: [:arg | self translateValue: arg].

		functionValue isConstantBuiltInFunction ifTrue: [
			setInstructionPair := BuiltInExtensionInstructionMap at: functionValue name.
			setInstructionPair first = #SpirV ifTrue: [ 
				builder addFunctionInstruction: (SpirVInstruction
					opcode: setInstructionPair second
					type: resultType
					result: id
					operands: arguments)
			] ifFalse: [ 
				extensionSet := builder perform: (setInstructionPair first , #ExtensionSet) asSymbol. 
				extensionInstruction := setInstructionPair second.
				builder addFunctionInstruction: (SpirVInstruction
					opcode: SpvOpExtInst
					type: resultType
					result: id
					operands: { extensionSet . extensionInstruction } , arguments)
			]
		] ifFalse: [ 
			function := self translateValue: functionValue.
			builder addFunctionInstruction: (SpirVInstruction
				opcode: SpvOpFunctionCall
				type: resultType
				result: id
				operands: { function } , arguments)
		]
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitCombineSamplerWithTexture: combineSampler [
	| sampler texture resultType |
	^ self instructionTranslation: combineSampler do: [ :id |
		sampler := self translateValue: combineSampler sampler.
		texture := self translateValue: combineSampler texture.
		resultType := self translateValue: combineSampler type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpSampledImage
			type: resultType
			result: id
			operands: { texture . sampler })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitConstantValue: constantValue [
	| value type encodedValue |
	^ self valueTranslation: constantValue do: [ :id |
		value := constantValue value.
		type := self translateValue: constantValue type.
		
		constantValue type isBooleanType ifTrue: [
			builder addConstantInstruction: (SpirVInstruction
				opcode: (constantValue ifTrue: [ SpvOpConstantTrue ] ifFalse: [ SpvOpConstantFalse ])
				type: type
				result: id
			) 
		] ifFalse: [
			constantValue type isFloatType ifTrue: [
				constantValue type size = 4 ifTrue: [
					encodedValue := { value asIEEE32BitWord }.
				] ifFalse: [
					encodedValue := { value at: 1 . value at: 2}.
				]
			] ifFalse: [
				constantValue type size > 4 ifTrue: [
					self assert: type size = 8 .
					encodedValue := { value bitAnd: 16rffffffff . (value bitShift: -32) bitAnd: 16rffffffff }
				] ifFalse: [
					encodedValue := { value bitAnd: 16rffffffff }
				]
			].
	
			builder addConstantInstruction: (SpirVInstruction
				opcode: SpvOpConstant
				type: type
				result: id
				operands: encodedValue)
		]
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitExtractVectorElement: extractElement [
	| resultType vector index |
	^ self instructionTranslation: extractElement do: [ :id |
		resultType := self translateValue: extractElement type.
		vector := self translateValue: extractElement vector.
		extractElement index isConstantValue ifTrue: [
			builder addFunctionInstruction: (SpirVInstruction
				opcode: SpvOpCompositeExtract
				type: resultType
				result: id
				operands: { vector . extractElement index value }
			)
		] ifFalse: [ 
			index := self translateValue: extractElement index.
			builder addFunctionInstruction: (SpirVInstruction
				opcode: SpvOpVectorExtractDynamic
				type: resultType
				result: id
				operands: { vector . index }
			)
		]
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFloatType: floatType [
	^ self valueTranslation: floatType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeFloat result: id operands: {floatType size})
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFunction: function [
	| functionType resultType |
	^ self functionTranslation: function do: [ :id |
		functionType := self translateValue: function functionType.
		resultType := self translateValue: function functionType returnType.
		
		builder addFunctionInstruction: (SpirVInstruction 
			opcode: SpvOpFunction
			type: resultType
			result: id
			operands: { SpvFunctionControlNone . functionType }
		).
		
		
		currentFunction arguments do: [ :arg | self translateValue: arg ].
		
		function basicBlocks do: [ :basicBlock | self translateBasicBlock: basicBlock ].
		
		builder addFunctionInstruction: (SpirVInstruction opcode: SpvOpFunctionEnd).
		
		function propertyAt: #vertex ifPresent: [ :dummy |
			builder addEntryPointInstruction: (SpirVInstruction
				opcode: SpvOpEntryPoint
				operands: { SpvExecutionModelVertex . id . } , function name asSpirVStringLiteral , interfaceList
			).
		].
		function propertyAt: #fragment ifPresent: [ :dummy |
			builder addEntryPointInstruction: (SpirVInstruction
				opcode: SpvOpEntryPoint
				operands: { SpvExecutionModelFragment . id . } , function name asSpirVStringLiteral , interfaceList
			).
		].
		function propertyAt: #geometry ifPresent: [ :dummy |
			self halt.
		].
		function propertyAt: #tcontrol ifPresent: [ :dummy |
			self halt.
		].
		function propertyAt: #teval ifPresent: [ :dummy |
			self halt.
		].
		function propertyAt: #compute ifPresent: [ :dummy |
			self halt.
		].
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFunctionArgument: functionArgument [
	| type |
	^ self valueTranslation: functionArgument do: [ :id |
		type := self translateValue: functionArgument type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpFunctionParameter
			type: type
			result: id)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFunctionType: functionType [
	| resultType arguments |
	^ self valueTranslation: functionType do: [ :id |
		resultType := self translateValue: functionType returnType.
		arguments := functionType arguments collect: [:arg | self translateValue: arg ].
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeFunction
			result: id
			operands: {resultType} , arguments)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitGetElementReference: getElementRef [
	| resultType pointer index |
	^ self instructionTranslation: getElementRef do: [ :id |
		pointer := self translateValue: getElementRef reference.
		index := self translateValue: getElementRef index.
		resultType := self translateValue: getElementRef type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpInBoundsAccessChain
			type: resultType
			result: id
			operands: { pointer . index })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitGlobalVariable: globalVariable [
	| type storage |
	^ self valueTranslation: globalVariable do: [ :id |
		type := self translateValue: globalVariable type.
		storage := StorageClassMap at: globalVariable type storage.
		builder addGlobalInstruction: (SpirVInstruction
			opcode: SpvOpVariable
			type: type 
			result: id
			operands: { storage }
		).
		
		builder addDebugInstruction: (SpirVInstruction
			opcode: SpvOpName
			operands: { id } , globalVariable name asSpirVStringLiteral
		).
		
		globalVariable propertyAt: #location ifPresent: [ :location |
			interfaceList add: id.
			location >= 0 ifTrue: [ 
				builder addAnnotationInstruction: (SpirVInstruction
					opcode: SpvOpDecorate
					operands: { id . SpvDecorationLocation . location }
				).
			] ifFalse: [
				builder addAnnotationInstruction: (SpirVInstruction
					opcode: SpvOpDecorate
					operands: { id . SpvDecorationBuiltIn . -1 - location }
				).
			]
		].
	
		globalVariable propertyAt: #binding ifPresent: [ :binding |
			builder addAnnotationInstruction: (SpirVInstruction
				opcode: SpvOpDecorate
				operands: { id . SpvDecorationBinding  . binding }
			).
		].
	
		globalVariable propertyAt: #set ifPresent: [ :bindingSet |
			builder addAnnotationInstruction: (SpirVInstruction
				opcode: SpvOpDecorate
				operands: { id . SpvDecorationDescriptorSet  . bindingSet }
			).
		].
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitIntegerType: integerType [
	^ self valueTranslation: integerType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeInt result: id operands: {integerType size . integerType isSigned asBit})
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitJump: jumpInstruction [
	| destination |
	^ self instructionTranslation: jumpInstruction do: [ :id |
		destination := self basicBlockLabelId: (jumpInstruction destination). 
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpBranch
			operands: { destination }
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitLoad: loadInstruction [
	| variable resultType |
	^ self instructionTranslation: loadInstruction do: [ :id |
		variable := self translateValue: loadInstruction variable.
		resultType := self translateValue: loadInstruction type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpLoad
			type: resultType
			result: id
			operands: { variable })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitMakeVector: makeVectorInstruction [
	| resultType arguments |
	^ self instructionTranslation: makeVectorInstruction do: [ :id |
		resultType := self translateValue: makeVectorInstruction type.
		arguments := makeVectorInstruction parameters collect: [ :arg | self translateValue: arg ].
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpCompositeConstruct
			type: resultType
			result: id
			operands: arguments)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitMatrixType: matrixType [
	| columnType |
	^ self valueTranslation: matrixType do: [ :id |
		columnType := self translateValue: matrixType columnType.
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeMatrix
			result: id
			operands: { columnType . matrixType columns}
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitReferenceType: referenceType [
	| baseType storage |
	^ self valueTranslation: referenceType do: [ :id |
		baseType := self translateValue: referenceType baseType.
		storage := StorageClassMap at: referenceType storage.
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypePointer result: id operands: { storage . baseType })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitReturn: returnInstruction [
	| value |
	^ self instructionTranslation: returnInstruction do: [ :id |
		value := self translateValue: returnInstruction value.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpReturnValue
			operands: { value })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitReturnVoid: returnVoidInstruction [
	^ self instructionTranslation: returnVoidInstruction do: [ :id |
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpReturn)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitSampleImplicitLod: sampleImplicitLod [
	| sampledTexture texcoord resultType |
	^ self instructionTranslation: sampleImplicitLod do: [ :id |
		sampledTexture := self translateValue: sampleImplicitLod sampledTexture.
		texcoord := self translateValue: sampleImplicitLod texcoord.
		resultType := self translateValue: sampleImplicitLod type.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpImageSampleImplicitLod
			type: resultType
			result: id
			operands: { sampledTexture . texcoord })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitSampledTextureType: sampledTextureType [
	| textureType |
	^ self valueTranslation: sampledTextureType do: [ :id |
		textureType := self translateValue: sampledTextureType texture.
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeSampledImage
			result: id
			operands: { textureType }
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitSamplerType: samplerType [
	^ self valueTranslation: samplerType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeSampler
			result: id
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitShuffleVectors: shuffleVectors [
	| resultType firstVector secondVector |
	^ self instructionTranslation: shuffleVectors do: [ :id |
		firstVector := self translateValue: shuffleVectors firstVector.
		secondVector := self translateValue: shuffleVectors secondVector.
		resultType := self translateValue: shuffleVectors type.
		builder addFunctionInstruction: (SpirVInstruction
				opcode: SpvOpVectorShuffle
				type: resultType
				result: id
				operands: { firstVector . secondVector } , shuffleVectors components
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitStore: storeInstruction [
	| value variable |
	^ self instructionTranslation: storeInstruction do: [ :id |
		value := self translateValue: storeInstruction value.
		variable := self translateValue: storeInstruction variable.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpStore
			operands: { variable . value })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitStructureType: structureType [
	| types |
	^ self valueTranslation: structureType do: [ :id |
		types := structureType types collect: [:type | self translateValue: type ].
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeStruct
			result: id
			operands: types
		).
		
		structureType name ifNotNil: [ 
			builder addDebugInstruction: (SpirVInstruction
				opcode: SpvOpName
				operands: { id } , structureType name asSpirVStringLiteral
			).
			
			structureType names doWithIndex: [ :name :index |
				builder addDebugInstruction: (SpirVInstruction
					opcode: SpvOpMemberName
					operands: { id . index - 1} , name asSpirVStringLiteral
				).
			].
		].

		structureType types doWithIndex: [ :type :index |
			type isMatrixType ifTrue: [ 
				builder addAnnotationInstruction: (SpirVInstruction
					opcode: SpvOpMemberDecorate
					operands: { id . index - 1 . SpvDecorationColMajor }
				).
				builder addAnnotationInstruction: (SpirVInstruction
					opcode: SpvOpMemberDecorate
					operands: { id . index - 1 . SpvDecorationMatrixStride . type columnType size }
				)
			].
			
		].
		
		structureType offsets doWithIndex: [ :offset :index |
			builder addAnnotationInstruction: (SpirVInstruction
				opcode: SpvOpMemberDecorate
				operands: { id . index - 1 . SpvDecorationOffset . offset }
			)
		].
	
		structureType kind = DASLStructureType blockKind ifTrue: [ 
			builder addAnnotationInstruction: (SpirVInstruction
				opcode: SpvOpDecorate
				operands: { id . SpvDecorationBlock }
			)
		].
	
		structureType kind = DASLStructureType bufferBlockKind ifTrue: [ 
			builder addAnnotationInstruction: (SpirVInstruction
				opcode: SpvOpDecorate
				operands: { id . SpvDecorationBufferBlock }
			)
		].
	
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitTextureType: textureType [
	| sampledType |
	^ self valueTranslation: textureType do: [ :id |
		sampledType := self translateValue: textureType sampledType.
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeImage
			result: id
			operands: {
				sampledType .
				textureType dimensions - 1.
				textureType depth asBit .
				textureType array asBit .
				textureType multisample asBit .
				textureType sampled asBit .
				"Unknown format" 0}
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitUnaryOperation: unaryOp [
	| opcode resultType operand |
	^ self instructionTranslation: unaryOp do: [ :id |
		opcode := UnaryOperationMap at: unaryOp operation.
		resultType := self translateValue: unaryOp type.
		operand := self translateValue: unaryOp operand.
		builder addFunctionInstruction: (SpirVInstruction
			opcode: opcode
			type: resultType
			result: id
			operands: { operand }
		)
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitVectorType: vectorType [
	| baseType |
	^ self valueTranslation: vectorType do: [ :id |
		baseType := self translateValue: vectorType baseType.
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeVector result: id operands: {baseType . vectorType elements})
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitVoidType: voidType [
	^ self valueTranslation: voidType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeVoid
			result: id
		)
	]
]
