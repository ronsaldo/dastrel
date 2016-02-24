Class {
	#name : #DASLConditionalExpression,
	#superclass : #DASLExpression,
	#instVars : [
		'condition',
		'trueValue',
		'falseValue'
	],
	#category : #'Dastrel-Core'
}

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
