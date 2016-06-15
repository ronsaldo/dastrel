Class {
	#name : #DASVGraphNodeSlot,
	#superclass : #DASVVisualElement,
	#instVars : [
		'size',
		'name',
		'type'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #accessing }
DASVGraphNodeSlot >> name [
	^ name
]

{ #category : #accessing }
DASVGraphNodeSlot >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASVGraphNodeSlot >> type [
	^ type
]

{ #category : #accessing }
DASVGraphNodeSlot >> type: anObject [
	type := anObject
]
