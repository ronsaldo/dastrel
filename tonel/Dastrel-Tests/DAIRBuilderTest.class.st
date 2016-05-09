"
A DAIRBuilderTest is a test class for testing the behavior of DAIRBuilder
"
Class {
	#name : #DAIRBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'functionType',
		'function',
		'builder'
	],
	#category : #'Dastrel-Tests'
}

{ #category : #running }
DAIRBuilderTest >> setUp [
	functionType := DASLFunctionType arguments: {DASLType intType} returnType: DASLType voidType.
	function := DAIRFunction name: #testFunction functionType: functionType.
	builder := DAIRBuilder on: function.
]

{ #category : #tests }
DAIRBuilderTest >> testConstBool [
	| constant |
	constant := builder constBool: true.
	self assert: constant isConstant.
	self assert: constant type = DASLType boolType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstDouble [
	| constant |
	constant := builder constDouble: 1.0.
	self assert: constant isConstant.
	self assert: constant type = DASLType doubleType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstFloat [
	| constant |
	constant := builder constFloat: 1.0.
	self assert: constant isConstant.
	self assert: constant type = DASLType floatType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstInt [
	| constant |
	constant := builder constInt: 1.
	self assert: constant isConstant.
	self assert: constant type = DASLType intType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstLong [
	| constant |
	constant := builder constLong: 1.
	self assert: constant isConstant.
	self assert: constant type = DASLType longType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstUInt [
	| constant |
	constant := builder constUInt: 1.
	self assert: constant isConstant.
	self assert: constant type = DASLType uintType.
]

{ #category : #tests }
DAIRBuilderTest >> testConstULong [
	| constant |
	constant := builder constULong: 1.
	self assert: constant isConstant.
	self assert: constant type = DASLType ulongType.
]

{ #category : #tests }
DAIRBuilderTest >> testNew [
	self assert: builder function equals: function.
]

{ #category : #'as yet unclassified' }
DAIRBuilderTest >> testNewBasicBlock [
	| block |
	block := builder newBasicBlock.
	self assert: function basicBlocks first equals: block
]

{ #category : #'as yet unclassified' }
DAIRBuilderTest >> testReturnVoid [
	| top instruction |
	top := builder newBasicBlock: #top.
	builder withBasicBlock: top do: [
		instruction := builder returnVoid
	].

	self assert: instruction block function equals: function.
	self assert: function basicBlocks first instructions first equals: instruction.
]
