Class {
	#name : #DAIRConstant,
	#superclass : #DAIRValue,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #constructor }
DAIRConstant class >> bool: aBoolean [
	^ self type: DASLType boolType value: aBoolean
]

{ #category : #constructor }
DAIRConstant class >> double: anInteger [
	^ self type: DASLType doubleType value: anInteger
]

{ #category : #constructor }
DAIRConstant class >> float: anInteger [
	^ self type: DASLType floatType value: anInteger
]

{ #category : #constructor }
DAIRConstant class >> int: anInteger [
	^ self type: DASLType intType value: anInteger
]

{ #category : #constructor }
DAIRConstant class >> long: anInteger [
	^ self type: DASLType longType value: anInteger
]

{ #category : #constructor }
DAIRConstant class >> type: aDASLType value: aConstantValue [ 
	^ DAIRConstantValue new type: aDASLType; value: aConstantValue
]

{ #category : #constructor }
DAIRConstant class >> uint: anInteger [
	^ self type: DASLType uintType value: anInteger
]

{ #category : #constructor }
DAIRConstant class >> ulong: anInteger [
	^ self type: DASLType ulongType value: anInteger
]

{ #category : #testing }
DAIRConstant >> isConstant [
	^ true
]
