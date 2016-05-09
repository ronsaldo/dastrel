"
A DAIRConstantTest is a test class for testing the behavior of DAIRConstant
"
Class {
	#name : #DAIRConstantTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantBool [
	| constant |
	constant := DAIRConstant bool: true.
	self assert: constant type equals: DASLType boolType. 
	self assert: constant value equals: true.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantDouble [
	| constant |
	constant := DAIRConstant double: 1.0.
	self assert: constant type equals: DASLType doubleType. 
	self assert: constant value equals: 1.0.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantFloat [
	| constant |
	constant := DAIRConstant float: 1.0.
	self assert: constant type equals: DASLType floatType. 
	self assert: constant value equals: 1.0.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantInt [
	| constant |
	constant := DAIRConstant int: 1.
	self assert: constant type equals: DASLType intType. 
	self assert: constant value equals: 1.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantLong [
	| constant |
	constant := DAIRConstant long: 1.
	self assert: constant type equals: DASLType longType. 
	self assert: constant value equals: 1.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantUInt [
	| constant |
	constant := DAIRConstant uint: 1.
	self assert: constant type equals: DASLType uintType. 
	self assert: constant value equals: 1.
]

{ #category : #'as yet unclassified' }
DAIRConstantTest >> testConstantULong [
	| constant |
	constant := DAIRConstant ulong: 1.
	self assert: constant type equals: DASLType ulongType. 
	self assert: constant value equals: 1.
]
