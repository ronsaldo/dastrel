Class {
	#name : #DASLFloatType,
	#superclass : #DASLPrimitiveType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #visitor }
DASLFloatType >> accept: aVisitor [
	^ aVisitor visitFloatType: self
]

{ #category : #converting }
DASLFloatType >> asSlovimType [
	^ SLVMFloatType name: name size: size alignment: alignment
]

{ #category : #testing }
DASLFloatType >> isFloatType [
	^ true
]
