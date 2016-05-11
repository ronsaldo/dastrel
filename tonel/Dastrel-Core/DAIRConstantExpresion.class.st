Class {
	#name : #DAIRConstantExpresion,
	#superclass : #DAIRConstant,
	#instVars : [
		'type',
		'parameters'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #printing }
DAIRConstantExpresion >> mnemonic [
	self subclassResponsibility
]

{ #category : #accessing }
DAIRConstantExpresion >> parameters [
	^ parameters
]

{ #category : #accessing }
DAIRConstantExpresion >> parameters: anArrayOfParameters [
	parameters := anArrayOfParameters

]

{ #category : #accessing }
DAIRConstantExpresion >> type [
	^ type
]
