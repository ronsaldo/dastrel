Class {
	#name : #DASLFloatType,
	#superclass : #DASLPrimitiveType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #visitor }
DASLFloatType >> accept: aVisitor [
	^ aVisitor visitFloatType: self
]

{ #category : #testing }
DASLFloatType >> isFloatType [
	^ true
]
