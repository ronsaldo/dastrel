Class {
	#name : #DASLBoolType,
	#superclass : #DASLPrimitiveType,
	#category : #'Dastrel-Core-Type'
}

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
