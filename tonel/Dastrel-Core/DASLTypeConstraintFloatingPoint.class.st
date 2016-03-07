Class {
	#name : #DASLTypeConstraintFloatingPoint,
	#superclass : #DASLTypeConstraint,
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeConstraintFloatingPoint >> canBeExpanded [
	^ true
]

{ #category : #expansion }
DASLTypeConstraintFloatingPoint >> expand [
	^ { 
		DASLType floatType .
		DASLType doubleType .
	 }
]

{ #category : #testing }
DASLTypeConstraintFloatingPoint >> isCompliedBy: aType [
	^ aType isFloatType
]
