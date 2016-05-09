Class {
	#name : #DAIRConstantValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'type',
		'value'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #accessing }
DAIRConstantValue >> type [
	^ type
]

{ #category : #accessing }
DAIRConstantValue >> type: anObject [
	type := anObject
]

{ #category : #accessing }
DAIRConstantValue >> value [
	^ value
]

{ #category : #accessing }
DAIRConstantValue >> value: anObject [
	value := anObject
]
