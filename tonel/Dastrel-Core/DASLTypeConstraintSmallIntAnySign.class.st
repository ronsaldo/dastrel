Class {
	#name : #DASLTypeConstraintSmallIntAnySign,
	#superclass : #DASLTypeConstraint,
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeConstraintSmallIntAnySign >> canBeExpanded [
	^ true
]

{ #category : #expansion }
DASLTypeConstraintSmallIntAnySign >> expand [
	^ { 
		DASLType charType .
		DASLType shortType .
		DASLType intType .
		
		DASLType ucharType .
		DASLType ushortType .
		DASLType uintType .
	 }
]

{ #category : #testing }
DASLTypeConstraintSmallIntAnySign >> isCompliedBy: aType [
	^ aType isIntegerType and: [ aType size <= 4]
]
