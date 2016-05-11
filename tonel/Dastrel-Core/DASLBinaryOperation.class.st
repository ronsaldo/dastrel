Class {
	#name : #DASLBinaryOperation,
	#superclass : #DASLExpression,
	#instVars : [
		'operation',
		'left',
		'right',
		'coercionType',
		'type',
		'builtInFunction'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBinaryOperation >> accept: aVisitor [
	^ aVisitor visitBinaryOperation: self
]

{ #category : #accessing }
DASLBinaryOperation >> builtInFunction [
	^ builtInFunction
]

{ #category : #accessing }
DASLBinaryOperation >> builtInFunction: anObject [
	builtInFunction := anObject
]

{ #category : #accessing }
DASLBinaryOperation >> coercionType [
	^ coercionType
]

{ #category : #accessing }
DASLBinaryOperation >> coercionType: anObject [
	coercionType := anObject
]

{ #category : #accessing }
DASLBinaryOperation >> left [
	^ left
]

{ #category : #accessing }
DASLBinaryOperation >> left: anObject [
	left := anObject
]

{ #category : #accessing }
DASLBinaryOperation >> operation [
	^ operation
]

{ #category : #accessing }
DASLBinaryOperation >> operation: anObject [
	operation := anObject
]

{ #category : #printing }
DASLBinaryOperation >> printOn: aStream [
	aStream nextPut: $(.
	aStream nextPutAll: operation.
	aStream space.
	left printOn: aStream.
	aStream space.
	right printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLBinaryOperation >> right [
	^ right
]

{ #category : #accessing }
DASLBinaryOperation >> right: anObject [
	right := anObject
]

{ #category : #accessing }
DASLBinaryOperation >> type [
	^ type
]

{ #category : #accessing }
DASLBinaryOperation >> type: anObject [
	type := anObject
]
