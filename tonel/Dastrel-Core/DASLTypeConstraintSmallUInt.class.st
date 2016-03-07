Class {
	#name : #DASLTypeConstraintSmallUInt,
	#superclass : #DASLTypeConstraint,
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeConstraintSmallUInt >> canBeExpanded [
	^ true
]

{ #category : #expansion }
DASLTypeConstraintSmallUInt >> expand [
	^ { 
		DASLType ucharType .
		DASLType ushortType .
		DASLType uintType .
	 }
]

{ #category : #testing }
DASLTypeConstraintSmallUInt >> isCompliedBy: aType [
	^ aType isIntegerType and: [ aType size <= 4 and: [ aType isUnsigned ] ]
]
