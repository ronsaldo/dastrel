Class {
	#name : #DASLTypeConstraint,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-Type'
}

{ #category : #converting }
DASLTypeConstraint class >> asType [
	^ self new asType.
]

{ #category : #converting }
DASLTypeConstraint >> asType [
	^ DASLPlaceholderType new constraint: self; yourself
]

{ #category : #testing }
DASLTypeConstraint >> canBeExpanded [
	^ false
]

{ #category : #expansion }
DASLTypeConstraint >> expand [
	self subclassResponsibility
]

{ #category : #testing }
DASLTypeConstraint >> isCompliedBy: aType [
	self subclassResponsibility
]
