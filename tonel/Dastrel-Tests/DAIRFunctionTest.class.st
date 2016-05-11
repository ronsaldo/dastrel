"
A DAIRFunctionTest is a test class for testing the behavior of DAIRFunction
"
Class {
	#name : #DAIRFunctionTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #'as yet unclassified' }
DAIRFunctionTest >> testGenerateSymbol [
	| functionType function gsym1 gsym2 |
	functionType := DASLFunctionType arguments: {DASLType intType} returnType: DASLType voidType.
	function := DAIRFunction name: #testFunction functionType: functionType.
	gsym1 := function generateSymbol.
	gsym2 := function generateSymbol.
	self assert: gsym1 isSymbol.
	self assert: gsym2 isSymbol.
	self assert: gsym1 ~= gsym2.
]

{ #category : #'as yet unclassified' }
DAIRFunctionTest >> testNew [
	| functionType function |
	functionType := DASLFunctionType arguments: {DASLType intType} returnType: DASLType voidType.
	function := DAIRFunction name: #testFunction functionType: functionType.
	self assert: function functionType equals: functionType.
	self assert: function type equals: (DASLReferenceType baseType: functionType storage: DASLType genericStorage).
	self assert: function arguments size equals: 1.
]
