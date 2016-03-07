Class {
	#name : #DASLTypeConstraintInteger,
	#superclass : #DASLTypeConstraint,
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLTypeConstraintInteger >> canBeExpanded [
	^ true
]

{ #category : #expansion }
DASLTypeConstraintInteger >> expand [
	^ { 
		DASLType charType .
		DASLType shortType .
		DASLType intType .
		DASLType longType .
		
		DASLType ucharType .
		DASLType ushortType .
		DASLType uintType .
		DASLType ulongType .
	 }
]

{ #category : #testing }
DASLTypeConstraintInteger >> isCompliedBy: aType [
	^ aType isIntegerType
]
