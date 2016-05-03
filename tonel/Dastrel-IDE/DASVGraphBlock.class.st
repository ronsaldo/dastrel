Class {
	#name : #DASVGraphBlock,
	#superclass : #DASVVisualElement,
	#instVars : [
		'nodes',
		'connections'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #adding }
DASVGraphBlock >> addNode: aNode [ 
	nodes add: aNode
]

{ #category : #drawing }
DASVGraphBlock >> drawOn: canvas [
	nodes do: [ :node | node drawOn: canvas ].
	connections do: [ :connection | connection drawOn: canvas ].
]

{ #category : #initialization }
DASVGraphBlock >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	connections := OrderedCollection new.
]

{ #category : #accessing }
DASVGraphBlock >> numberOfConnections [
	^ connections size
]

{ #category : #accessing }
DASVGraphBlock >> numberOfNodes [
	^ nodes size
]
