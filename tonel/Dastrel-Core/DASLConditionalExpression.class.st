Class {
	#name : #DASLConditionalExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'condition',
		'trueValue',
		'falseValue',
		'type'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLConditionalExpression >> accept: aVisitor [
	^ aVisitor visitConditionalExpression: self
]

{ #category : #accessing }
DASLConditionalExpression >> condition [
	^ condition
]

{ #category : #accessing }
DASLConditionalExpression >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
DASLConditionalExpression >> falseValue [
	^ falseValue
]

{ #category : #accessing }
DASLConditionalExpression >> falseValue: anObject [
	falseValue := anObject
]

{ #category : #accessing }
DASLConditionalExpression >> trueValue [
	^ trueValue
]

{ #category : #accessing }
DASLConditionalExpression >> trueValue: anObject [
	trueValue := anObject
]

{ #category : #accessing }
DASLConditionalExpression >> type [
	^ type
]

{ #category : #accessing }
DASLConditionalExpression >> type: anObject [
	type := anObject
]
