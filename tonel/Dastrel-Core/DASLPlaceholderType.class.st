Class {
	#name : #DASLPlaceholderType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'constraint'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #testing }
DASLPlaceholderType >> canBeExpanded [
	^ constraint canBeExpanded
]

{ #category : #accessing }
DASLPlaceholderType >> constraint [
	^ constraint
]

{ #category : #accessing }
DASLPlaceholderType >> constraint: anObject [
	constraint := anObject
]

{ #category : #expansion }
DASLPlaceholderType >> expand [
	^ constraint expand
]

{ #category : #initialization }
DASLPlaceholderType >> initialize [
	super initialize.
	constraint := DASLTypeConstraintAny new.
]

{ #category : #testing }
DASLPlaceholderType >> isCompliedBy: aType [
	^ constraint isCompliedBy: aType
]

{ #category : #testing }
DASLPlaceholderType >> isPlaceholderType [
	^ true
]
