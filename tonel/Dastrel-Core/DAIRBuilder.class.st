Class {
	#name : #DAIRBuilder,
	#superclass : #DASLObject,
	#instVars : [
		'function',
		'currentBlock'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #'instance creation' }
DAIRBuilder class >> on: aFunction [
	^ self new function: aFunction
]

{ #category : #instructions }
DAIRBuilder >> add: left with: right [
	^ self add: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> add: left with: right name: resultName [
	^ self addOperation: #add left: left right: right name: resultName
]

{ #category : #adding }
DAIRBuilder >> addInstruction: anInstruction name: theInstructionName [
	anInstruction name: theInstructionName.
	currentBlock add: anInstruction.
	^ anInstruction
]

{ #category : #adding }
DAIRBuilder >> addOperation: operation left: left right: right [
	^ self addOperation: operation left: left right: right name: function generateSymbol
]

{ #category : #adding }
DAIRBuilder >> addOperation: operation left: left right: right name: name [
	^ self addInstruction: (DAIRBinaryOperation operation: operation left: left right: right) name: name
]

{ #category : #adding }
DAIRBuilder >> addOperation: operation operand: operand [
	^ self addOperation: operation operand: operand name: function generateSymbol
]

{ #category : #adding }
DAIRBuilder >> addOperation: operation operand: operand name: name [
	^ self addInstruction: (DAIRUnaryOperation operation: operation operand: operand) name: name
]

{ #category : #instructions }
DAIRBuilder >> alloca: valueType [
	^ self alloca: valueType name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> alloca: valueType name: variableName [
	^ self addInstruction: (DAIRAlloca valueType: valueType) name: variableName
]

{ #category : #instructions }
DAIRBuilder >> branch: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock [
	^ self branch: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> branch: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock name: resultName [
	^ self addInstruction: (DAIRBranch condition: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> call: functionValue arguments: arguments [
	^ self call: functionValue arguments: arguments name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> call: functionValue arguments: arguments name: resultName [
	^ self addInstruction: (DAIRCall function: functionValue arguments: arguments) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> combineSampler: sampler with: texture [
	^ self combineSampler: sampler with: texture name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> combineSampler: sampler with: texture name: resultName [
	^ self addInstruction: (DAIRCombineSamplerWithTexture sampler: sampler texture: texture) name: resultName
]

{ #category : #constants }
DAIRBuilder >> constBool: aValue [
	^ DAIRConstant bool: aValue
]

{ #category : #constants }
DAIRBuilder >> constDouble: aValue [
	^ DAIRConstant double: aValue
]

{ #category : #constants }
DAIRBuilder >> constFloat: aValue [
	^ DAIRConstant float: aValue
]

{ #category : #constants }
DAIRBuilder >> constInt: aValue [
	^ DAIRConstant int: aValue
]

{ #category : #constants }
DAIRBuilder >> constLong: aValue [
	^ DAIRConstant long: aValue
]

{ #category : #constants }
DAIRBuilder >> constUInt: aValue [
	^ DAIRConstant uint: aValue
]

{ #category : #constants }
DAIRBuilder >> constULong: aValue [
	^ DAIRConstant ulong: aValue
]

{ #category : #accessing }
DAIRBuilder >> currentBlock [
	^ currentBlock
]

{ #category : #accessing }
DAIRBuilder >> currentBlock: anObject [
	currentBlock := anObject
]

{ #category : #instructions }
DAIRBuilder >> div: left with: right [
	^ self div: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> div: left with: right name: resultName [
	^ self addOperation: #div left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> extractVector: aVectorValue element: indexValue [
	^ self extractVector: aVectorValue element: indexValue name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> extractVector: aVectorValue element: indexValue name: resultName [
	^ self addInstruction: (DAIRExtractVectorElement vector: aVectorValue index: indexValue) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> fadd: left with: right [
	^ self fadd: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> fadd: left with: right name: resultName [
	^ self addOperation: #fadd left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> fdiv: left with: right [
	^ self fdiv: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> fdiv: left with: right name: resultName [
	^ self addOperation: #fdiv left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> fmul: left with: right [
	^ self fmul: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> fmul: left with: right name: resultName [
	^ self addOperation: #fmul left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> fneg: operand [
	^ self fneg: operand name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> fneg: operand name: resultName [
	^ self addOperation: #fneg operand: operand name: resultName
]

{ #category : #instructions }
DAIRBuilder >> frem: left with: right [
	^ self frem: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> frem: left with: right name: resultName [
	^ self addOperation: #frem left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> fsub: left with: right [
	^ self fsub: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> fsub: left with: right name: resultName [
	^ self addOperation: #fsub left: left right: right name: resultName
]

{ #category : #accessing }
DAIRBuilder >> function [
	^ function
]

{ #category : #accessing }
DAIRBuilder >> function: anObject [
	function := anObject
]

{ #category : #instructions }
DAIRBuilder >> getReference: reference element: element [
	^ self getReference: reference element: element resultName: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> getReference: reference element: element resultName: resultName [
	^ self addInstruction: (DAIRGetElementReference reference: reference index: element) name: resultName
]

{ #category : #testing }
DAIRBuilder >> isLastTerminator [
	^ currentBlock isLastTerminator
]

{ #category : #instructions }
DAIRBuilder >> jump: destination [
	^ self jump: destination name: function generateSymbol

]

{ #category : #instructions }
DAIRBuilder >> jump: destination name: resultName [
	^ self addInstruction: (DAIRJump destination: destination) name: resultName
]

{ #category : #accessing }
DAIRBuilder >> lastInstruction [
	^ currentBlock lastInstruction
]

{ #category : #instructions }
DAIRBuilder >> load: variable [
	^ self load: variable name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> load: variable name: resultName [
	^ self addInstruction: (DAIRLoadInstruction variable: variable) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> makeVector: vectorType arguments: arguments [
	^ self makeVector: vectorType arguments: arguments name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> makeVector: vectorType arguments: arguments name: resultName [
	^ self addInstruction: (DAIRMakeVector type: vectorType parameters: arguments) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> mul: left with: right [
	^ self mul: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> mul: left with: right name: resultName [
	^ self addOperation: #mul left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> mulMatrix: left withMatrix: right [
	^ self mulMatrix: left withMatrix: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> mulMatrix: left withMatrix: right name: resultName [
	^ self addOperation: #mulMatrixMatrix left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> mulMatrix: left withVector: right [
	^ self mulMatrix: left withVector: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> mulMatrix: left withVector: right name: resultName [
	^ self addOperation: #mulMatrixVector left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> mulVector: left withMatrix: right [
	^ self mulVector: left withMatrix: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> mulVector: left withMatrix: right name: resultName [
	^ self addOperation: #mulVectorMatrix left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> neg: operand [
	^ self neg: operand name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> neg: operand name: resultName [
	^ self addOperation: #neg operand: operand name: resultName
]

{ #category : #'instance creation' }
DAIRBuilder >> newBasicBlock [
	^ self newBasicBlock: function generateSymbol
]

{ #category : #'instance creation' }
DAIRBuilder >> newBasicBlock: aName [
	| block |
	block := DAIRBasicBlock new name: aName.
	function addBasicBlock: block.
	^ block.
]

{ #category : #instructions }
DAIRBuilder >> not: operand [
	^ self not operand name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> not: operand name: resultName [
	^ self addOperation: #not operand: operand name: resultName
]

{ #category : #instructions }
DAIRBuilder >> phi [
	^ self phi: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> phi: resultName [
	^ self addInstruction: DAIRPhi new name: resultName
]

{ #category : #instructions }
DAIRBuilder >> rem: left with: right [
	^ self rem: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> rem: left with: right name: resultName [
	^ self addOperation: #rem left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> return: value [
	^ self return: value name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> return: value name: resultName [
	^ self addInstruction: (DAIRReturn value: value) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> returnVoid [
	^ self returnVoid: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> returnVoid: resultName [
	^ self addInstruction: DAIRReturnVoid new name: resultName
]

{ #category : #instructions }
DAIRBuilder >> sample: combinedSampler implicitLodAtCoord: texcoord [
	^ self sample: combinedSampler implicitLodAtCoord: texcoord name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> sample: combinedSampler implicitLodAtCoord: texcoord name: resultName [
	^ self addInstruction: (DAIRSampleImplicitLod sampledTexture: combinedSampler texcoord: texcoord) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> shuffleVector: firstVector with: secondVector components: components [
	^ self shuffleVector: firstVector with: secondVector components: components name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> shuffleVector: firstVector with: secondVector components: components name: resultName [
	^ self addInstruction: (DAIRShuffleVectors firstVector: firstVector secondVector: secondVector components: components) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> store: value in: variable [
	^ self store: value in: variable name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> store: value in: variable name: resultName [
	^ self addInstruction: (DAIRStoreInstruction value: value variable: variable) name: resultName
]

{ #category : #instructions }
DAIRBuilder >> sub: left with: right [
	^ self sub: left with: right name: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> sub: left with: right name: resultName [
	^ self addOperation: #sub left: left right: right name: resultName
]

{ #category : #instructions }
DAIRBuilder >> unreachable [
	^ self unreachable: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> unreachable: resultName [
	^ self addInstruction: DAIRUnreacheable new name: resultName
]

{ #category : #'instance creation' }
DAIRBuilder >> withBasicBlock: aBasicBlock do: aBlock [
	| oldBlock |
	oldBlock := currentBlock.
	currentBlock := aBasicBlock.
	aBlock ensure: [ currentBlock := oldBlock ]
]
