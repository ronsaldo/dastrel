Class {
	#name : #DAIRBinaryOperation,
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
DAIRBinaryOperation class >> initialize [
	"
	self initialize.
	"
	super initialize.
	
	OperationSignatures := Dictionary newFromPairs: #(
		add		integer
		sub   integer 
		mul   integer
		div   integer
		udiv  integer
		rem   integer
		urem  integer

		bitand integer
		bitor integer
		bitxor integer

		shiftleft integer
		shiftright integer

		ilt integerComp
		ile integerComp
		ieq integerComp
		ine integerComp
		igt integerComp
		ige integerComp

		fadd 		float
		fsub 		float
		fmul 		float
		fdiv 		float
		frem 		float

		uflt floatComp
		ufle floatComp
		ufeq floatComp
		ufne floatComp
		ufgt floatComp
		ufge floatComp

		oflt floatComp
		ofle floatComp
		ofeq floatComp
		ofne floatComp
		ofgt floatComp
		ofge floatComp
	).

]

{ #category : #construction }
DAIRBinaryOperation class >> operation: operation left: leftOperand right: rightOperand [
	^ self new operation: operation left: leftOperand right: rightOperand

]

{ #category : #accessing }
DAIRBinaryOperation >> computeTypeFor: anOperation left: leftOperand right: rightOperand [
	| leftType rightType operationType |
	leftType := leftOperand type.
	rightType := rightOperand type.
	leftType ~= rightType ifTrue: [ self error: 'Unsupported binary operation whose operands have a different type.' ].
	
	operationType := OperationSignatures at: anOperation.
	((operationType == #integer) or: [ operationType == #integerComp ]) ifTrue: [ 
		leftType isIntegerType ifFalse: [ self error: 'Binary operation ' , anOperation , ' requires integer operands.' ].
		^ operationType == #integerComp ifTrue: [ DASLType boolType ] ifFalse: [ leftType ]
	].

	((operationType == #float) or: [ operationType == #floatComp ]) ifTrue: [ 
		leftType isFloatType ifFalse: [ self error: 'Binary operation ' , anOperation , ' requires integer operands.' ].
		^ operationType == #floatComp ifTrue: [ DASLType boolType ] ifFalse: [ leftType ]
	].

	self error: 'Unsupported operation type'

]

{ #category : #accessing }
DAIRBinaryOperation >> left [
	^ parameters first
]

{ #category : #accessing }
DAIRBinaryOperation >> operation [
	^ operation
]

{ #category : #construction }
DAIRBinaryOperation >> operation: anOperation left: leftOperand right: rightOperand [
	operation := anOperation.
	type := self computeTypeFor: anOperation left: leftOperand right: rightOperand.
	self parameters: { leftOperand . rightOperand }
]

{ #category : #accessing }
DAIRBinaryOperation >> right [
	^ parameters second
]

{ #category : #accessing }
DAIRBinaryOperation >> type [
	^ type
]
