Class {
	#name : #DASLTypeConstraintSmallInt,
	#superclass : #DASLTypeConstraint,
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeConstraintSmallInt >> canBeExpanded [
	^ true
]

{ #category : #expansion }
DASLTypeConstraintSmallInt >> expand [
	^ { 
		DASLType charType .
		DASLType shortType .
		DASLType intType .
	 }
]

{ #category : #testing }
DASLTypeConstraintSmallInt >> isCompliedBy: aType [
	^ aType isIntegerType and: [ aType size <= 4 and: [ aType isSigned ] ]
]
