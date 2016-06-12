Class {
	#name : #DASLBoolType,
	#superclass : #DASLPrimitiveType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #visitor }
DASLBoolType >> accept: aVisitor [
	^ aVisitor visitBoolType: self
]

{ #category : #converting }
DASLBoolType >> asSlovimType [
	^ SLVMType boolType
]

{ #category : #initialization }
DASLBoolType >> initialize [
	super initialize.
	self name: #bool;
		size: 4.
]

{ #category : #testing }
DASLBoolType >> isBooleanType [
	^ true
]
