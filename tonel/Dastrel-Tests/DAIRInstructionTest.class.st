"
A DAIRInstructionTest is a test class for testing the behavior of DAIRInstruction
"
Class {
	#name : #DAIRInstructionTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DAIRInstructionTest >> testBinaryOperation [
	| instruction left right |
	left := DAIRConstant int: 1.
	right := DAIRConstant int: 2.
	instruction := DAIRBinaryOperation operation: #add left: left right: right.
	self assert: instruction isTerminator not.
	self assert: instruction left = left.
	self assert: instruction right = right.
	self assert: instruction type isIntegerType.
]

{ #category : #tests }
DAIRInstructionTest >> testReturn [
	| instruction value |
	value := DAIRConstant int: 1.
	instruction := DAIRReturn value: value.
	self assert: instruction isTerminator.
	self assert: instruction value = value.
	self assert: instruction type isVoidType.
]

{ #category : #tests }
DAIRInstructionTest >> testReturnVoid [
	| instruction |
	instruction := DAIRReturnVoid new.
	self assert: instruction isTerminator.
	self assert: instruction type isVoidType.
]

{ #category : #tests }
DAIRInstructionTest >> testUnreachable [
	| instruction |
	instruction := DAIRUnreacheable new.
	self assert: instruction isTerminator.
	self assert: instruction isUnreachable.
	self assert: instruction type isVoidType.
]
