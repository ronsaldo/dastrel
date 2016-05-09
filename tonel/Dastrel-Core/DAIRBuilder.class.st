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

{ #category : #adding }
DAIRBuilder >> addInstruction: anInstruction name: theInstructionName [
	anInstruction name: theInstructionName.
	currentBlock add: anInstruction.
	^ anInstruction
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

{ #category : #accessing }
DAIRBuilder >> function [
	^ function
]

{ #category : #accessing }
DAIRBuilder >> function: anObject [
	function := anObject
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
DAIRBuilder >> returnVoid [
	^ self returnVoid: function generateSymbol
]

{ #category : #instructions }
DAIRBuilder >> returnVoid: resultName [
	^ self addInstruction: DAIRReturnVoid new name: resultName
]

{ #category : #'instance creation' }
DAIRBuilder >> withBasicBlock: aBasicBlock do: aBlock [
	| oldBlock |
	oldBlock := currentBlock.
	currentBlock := aBasicBlock.
	aBlock ensure: [ currentBlock := oldBlock ]
]
