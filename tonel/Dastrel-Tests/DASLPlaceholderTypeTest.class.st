Class {
	#name : #DASLPlaceholderTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLPlaceholderTypeTest >> testNew [
	| placeholderType |
	placeholderType := DASLPlaceholderType new.
	self assert: placeholderType isPlaceholderType
	
]

{ #category : #tests }
DASLPlaceholderTypeTest >> testNotEqual [
	| placeholderType1 placeholderType2|
	placeholderType1 := DASLPlaceholderType new.
	placeholderType2 := DASLPlaceholderType new.
	self deny: placeholderType1 = placeholderType2.
	self deny: placeholderType1 hash = placeholderType2 hash.
	
]
