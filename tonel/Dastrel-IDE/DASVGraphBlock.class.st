Class {
	#name : #DASVGraphBlock,
	#superclass : #DASVVisualElement,
	#instVars : [
		'name',
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
	name := 'Unknown'.
	nodes := OrderedCollection new.
	connections := OrderedCollection new.
]

{ #category : #accessing }
DASVGraphBlock >> name [
	^ name
]

{ #category : #accessing }
DASVGraphBlock >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASVGraphBlock >> nodes [
	^ nodes
]

{ #category : #accessing }
DASVGraphBlock >> numberOfConnections [
	^ connections size
]

{ #category : #accessing }
DASVGraphBlock >> numberOfNodes [
	^ nodes size
]
