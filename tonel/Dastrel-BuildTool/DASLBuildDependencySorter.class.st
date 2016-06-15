Class {
	#name : #DASLBuildDependencySorter,
	#superclass : #Object,
	#instVars : [
		'sortedDependencies',
		'visitedSet'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #'as yet unclassified' }
DASLBuildDependencySorter class >> sortProject: aProject [
	^ self new sortProject: aProject
]

{ #category : #'as yet unclassified' }
DASLBuildDependencySorter >> addItemAndDependencies: anItem [
	(visitedSet includes: anItem) ifTrue: [ ^ self ].
	visitedSet add: anItem.
	anItem dependencies do: [ :dep | self addItemAndDependencies: dep ].
	sortedDependencies add: anItem.
]

{ #category : #'as yet unclassified' }
DASLBuildDependencySorter >> sortProject: aProject [
	sortedDependencies := OrderedCollection new.
	visitedSet := Set new.
	self addItemAndDependencies: aProject.
	^ sortedDependencies
]
