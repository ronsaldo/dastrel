Class {
	#name : #DASLSSASpirVTranslator,
	#superclass : #Object,
	#instVars : [
		'translatedValues',
		'builder',
		'basicBlockDictionary',
		'instructionDictionary'
	],
	#classVars : [
		'StorageClassMap'
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
	)
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> basicBlockLabelId: basicBlock [
	^ basicBlockDictionary at: basicBlock ifAbsentPut: [ builder newId ].
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> functionTranslation: aValue do: aBlock [
	^ self valueTranslation: aValue do: [:id |
		builder functionDo: [ aBlock value: id]
	]
]

{ #category : #initialization }
DASLSSASpirVTranslator >> initialize [
	super initialize.
	translatedValues := Dictionary new.
	basicBlockDictionary := Dictionary new.
	instructionDictionary := Dictionary new.
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
		
		function arguments do: [ :arg | self translateValue: arg ].
		
		function basicBlocks do: [ :basicBlock | self translateBasicBlock: basicBlock ].
		
		builder addFunctionInstruction: (SpirVInstruction opcode: SpvOpFunctionEnd).
		
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
			location >= 0 ifTrue: [ 
				builder addGlobalInstruction: (SpirVInstruction
					opcode: SpvOpDecorate
					operands: { id . SpvDecorationLocation . location }
				).
			] ifFalse: [
				builder addGlobalInstruction: (SpirVInstruction
					opcode: SpvOpDecorate
					operands: { id . SpvDecorationBuiltIn . -1 - location }
				).
			]
		]
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
DASLSSASpirVTranslator >> visitReturnVoid: returnVoidInstruction [
	^ self instructionTranslation: returnVoidInstruction do: [ :id |
		builder addFunctionInstruction: (SpirVInstruction
			opcode: SpvOpReturn)
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
			operands: { value . variable })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitStructureType: structureType [
	| types |
	^ self valueTranslation: structureType do: [ :id |
		types := structureType types collect: [:type | self translateValue: type ].
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeStruct result: id operands: types)
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
	| resultType arguments |
	^ self valueTranslation: voidType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction
			opcode: SpvOpTypeVoid
			result: id
		)
	]
]
