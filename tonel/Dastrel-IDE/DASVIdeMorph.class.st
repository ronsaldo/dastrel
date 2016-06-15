Class {
	#name : #DASVIdeMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'graphBlock',
		'session',
		'draggingNode',
		'draggingMouseStartPosition',
		'draggingStartPosition',
		'selectedNode',
		'nodeBelowMouse'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #initialization }
DASVIdeMorph >> checkSession [
	session ~~ Smalltalk session ifTrue: [ 
		self initializeForNewSession.
	]
]

{ #category : #initialization }
DASVIdeMorph >> defaultExtent [
	^ 640@480
]

{ #category : #drawing }
DASVIdeMorph >> drawOn: aCanvas [
	self checkSession.
	self render.
	surface displayOnMorphicCanvas: aCanvas at: bounds origin
]

{ #category : #accessing }
DASVIdeMorph >> graphBlock [
	^ graphBlock
]

{ #category : #accessing }
DASVIdeMorph >> graphBlock: anObject [
	graphBlock := anObject
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handleMouseDown: anEvent [
	| position elementIndex |
	graphBlock ifNil: [ ^ self ].
	anEvent wasHandled: true.
	position := anEvent position - self position.
	elementIndex := self nodeAtPosition: position.
	elementIndex ifNotNil: [ ^ self handleMouseDown: anEvent nodeIndex: elementIndex ].
	self selectedNode: nil.
	self openContextMenu: anEvent.
	
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handleMouseDown: anEvent nodeIndex: nodeIndex [
	| node |
	node := graphBlock nodes at: nodeIndex.
	graphBlock nodes swap: nodeIndex with: graphBlock nodes size.
	self selectedNode: node.
	draggingNode := node.
	draggingMouseStartPosition := anEvent position.
	draggingStartPosition := node position.
	self changed.
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handleMouseMove: anEvent [
	| delta newPosition elementIndex |
	anEvent wasHandled: true.
	graphBlock ifNil: [ ^ self ].
	
	elementIndex := self nodeAtPosition: anEvent position - self position.
	self nodeBelowMouse: (elementIndex ifNotNil: [ graphBlock nodes at: elementIndex ]).
	
	draggingNode ifNil: [ ^ self ].
	delta := anEvent position - draggingMouseStartPosition.
	newPosition := draggingStartPosition + delta.
	draggingNode position: newPosition.
	self changed.
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handleMouseUp: anEvent [

	anEvent wasHandled: true.
	draggingNode := nil.
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handlesMouseDown: evt [
	^ evt wasHandled not
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handlesMouseMove: evt [
	^ evt wasHandled not
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> handlesMouseUp: evt [
	^ evt wasHandled not
]

{ #category : #initialization }
DASVIdeMorph >> initialize [
	super initialize.
	self extent: self defaultExtent.
	self initializeForNewSession.
]

{ #category : #initialization }
DASVIdeMorph >> initializeForNewSession [
	surface := AthensCairoSurface extent: self extent.
	session := Smalltalk session.
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> nodeAtPosition: aPoint [
	graphBlock ifNil: [ ^ nil ].
	graphBlock nodes reverseWithIndexDo: [ :node :index |
		(node bounds containsPoint: aPoint) ifTrue: [ ^ index ]
	].
	^ nil
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> nodeBelowMouse: aNode [
	nodeBelowMouse ifNotNil: [ nodeBelowMouse hasMouseOver: false ].
	nodeBelowMouse := aNode.
	nodeBelowMouse ifNotNil: [ nodeBelowMouse hasMouseOver: true ].
	self changed.
]

{ #category : #'as yet unclassified' }
DASVIdeMorph >> openContextMenu: anEvent [
	| position node |
	position := anEvent position - self position.
	node := DASVGraphNode new center: position.
	graphBlock addNode: node.
	self selectedNode: node.
	self changed
]

{ #category : #drawing }
DASVIdeMorph >> render [
	surface drawDuring: [ :canvas |
		surface clear: Color white.
		canvas pathTransform loadIdentity.
		
		graphBlock ifNotNil: [ graphBlock drawOn: canvas ]
	].

	
]

{ #category : #accessing }
DASVIdeMorph >> selectedNode [
	^ selectedNode
]

{ #category : #accessing }
DASVIdeMorph >> selectedNode: aNode [
	selectedNode ifNotNil: [ selectedNode selected: false ].
	selectedNode := aNode.
	selectedNode ifNotNil: [ selectedNode selected: true ].
	self changed.
]
