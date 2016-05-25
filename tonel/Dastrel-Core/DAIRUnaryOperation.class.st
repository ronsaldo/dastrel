Class {
	#name : #DAIRUnaryOperation,
	#superclass : #DAIRInstruction,
	#instVars : [
		'operation',
		'type'
	],
	#classVars : [
		'OperationSignatures'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #'class initialization' }
DAIRUnaryOperation class >> initialize [
	"
	self initialize.
	"
	super initialize.
	
	OperationSignatures := Dictionary newFromPairs: #(
		neg		integer
		not   integer
		lnot  bool 
		fneg   float
	).

]

{ #category : #construction }
DAIRUnaryOperation class >> operation: operation operand: operand [
	^ self new operation: operation operand: operand
]

{ #category : #visitor }
DAIRUnaryOperation >> accept: aVisitor [
	^ aVisitor visitUnaryOperation: self
]

{ #category : #'as yet unclassified' }
DAIRUnaryOperation >> computeTypeFor: anOperation operand: operand [
	| operandType rightType operationType |
	operandType := operand type.
	operationType := OperationSignatures at: anOperation.
	
	operationType == #integer ifTrue: [ 
		(operandType isIntegerType or: [operandType isVectorType and: [operandType baseType isIntegerType ] ]) ifFalse: [ self error: 'Unary operation ' , anOperation , ' requires integer operand.' ].
		^ operandType
	].

	operationType == #float ifTrue: [ 
		(operandType isFloatType or: [operandType isVectorType and: [operandType baseType isFloatType ] ]) ifFalse: [ self error: 'Unary operation ' , anOperation , ' requires float operands.' ].
		^ operandType
	].

	self error: 'Unsupported operation type'

]

{ #category : #printing }
DAIRUnaryOperation >> mnemonic [
	^ self operation
]

{ #category : #accessing }
DAIRUnaryOperation >> operand [
	^ parameters first
]

{ #category : #accessing }
DAIRUnaryOperation >> operation [
	^ operation
]

{ #category : #construction }
DAIRUnaryOperation >> operation: anOperation operand: operand [
	operation := anOperation.
	type := self computeTypeFor: anOperation operand: operand.
	self parameters: { operand }
]

{ #category : #accessing }
DAIRUnaryOperation >> type [
	^ type
]
