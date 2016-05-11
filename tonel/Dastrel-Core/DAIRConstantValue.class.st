Class {
	#name : #DAIRConstantValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'type',
		'value'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRConstantValue >> accept: aVisitor [
	^ aVisitor visitConstantValue: self
]

{ #category : #printing }
DAIRConstantValue >> printOn: aStream [
	aStream nextPutAll: 'constant '; print: type; space; print: value
]

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
