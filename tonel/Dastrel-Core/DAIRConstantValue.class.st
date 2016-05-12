Class {
	#name : #DAIRConstantValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'type',
		'value'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #comparing }
DAIRConstantValue >> = other [
	^ self class = other class and: [ self type = other type and: [ self value = other value ] ]
]

{ #category : #visitor }
DAIRConstantValue >> accept: aVisitor [
	^ aVisitor visitConstantValue: self
]

{ #category : #comparing }
DAIRConstantValue >> hash [
	^ (self class hash bitXor: type hash) bitXor: value hash
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
