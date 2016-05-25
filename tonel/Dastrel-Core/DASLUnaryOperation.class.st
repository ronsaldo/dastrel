Class {
	#name : #DASLUnaryOperation,
	#superclass : #DASLExpression,
	#instVars : [
		'operation',
		'operand',
		'coercionType',
		'type',
		'builtInFunction'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLUnaryOperation >> builtInFunction [
	^ builtInFunction
]

{ #category : #accessing }
DASLUnaryOperation >> builtInFunction: anObject [
	builtInFunction := anObject
]

{ #category : #accessing }
DASLUnaryOperation >> coercionType [
	^ coercionType
]

{ #category : #accessing }
DASLUnaryOperation >> coercionType: anObject [
	coercionType := anObject
]

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

{ #category : #accessing }
DASLUnaryOperation >> type [
	^ type
]

{ #category : #accessing }
DASLUnaryOperation >> type: anObject [
	type := anObject
]
