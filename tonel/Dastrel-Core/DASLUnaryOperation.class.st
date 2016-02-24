Class {
	#name : #DASLUnaryOperation,
	#superclass : #DASLExpression,
	#instVars : [
		'operation',
		'operand'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLUnaryOperation >> operand [
	^ operand
]

{ #category : #accessing }
DASLUnaryOperation >> operand: anObject [
	operand := anObject
]

{ #category : #accessing }
DASLUnaryOperation >> operation [
	^ operation
]

{ #category : #accessing }
DASLUnaryOperation >> operation: anObject [
	operation := anObject
]
