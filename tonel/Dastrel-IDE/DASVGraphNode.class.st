Class {
	#name : #DASVGraphNode,
	#superclass : #DASVVisualElement,
	#instVars : [
		'inputs',
		'outputs',
		'title',
		'bounds'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #initialize }
DASVGraphNode class >> defaultBounds [
	^ 0@0 extent: 64@64
]

{ #category : #accessing }
DASVGraphNode class >> defaultTitle [
	^ 'Untitled'
]

{ #category : #accessing }
DASVGraphNode >> backgroundColor [
	^ Color veryLightGray
]

{ #category : #drawing }
DASVGraphNode >> borderColor [
	^ Color black
]

{ #category : #accessing }
DASVGraphNode >> bounds [
	^ bounds
]

{ #category : #accessing }
DASVGraphNode >> bounds: anObject [
	bounds := anObject
]

{ #category : #drawing }
DASVGraphNode >> drawOn: canvas [
	| shape |
	canvas pathTransform restoreAfter: [
		shape := self createShapeOn: canvas rectangleShape: self localRectangle radius: 5.
	
		canvas
			pathTransform translateX: self position x Y: self position y.
		canvas
			setPaint: self backgroundColor;
			setShape: shape;
			draw;
			setStrokePaint: self borderColor;
			draw.
	]
]

{ #category : #accessing }
DASVGraphNode >> extent [
	^ bounds extent
]

{ #category : #initialization }
DASVGraphNode >> initialize [
	super initialize.
	inputs := OrderedCollection new.
	outputs := OrderedCollection new.
	title := self class defaultTitle.
	bounds := self class defaultBounds.
]

{ #category : #accessing }
DASVGraphNode >> inputs [
	^ inputs
]

{ #category : #accessing }
DASVGraphNode >> inputs: anObject [
	inputs := anObject
]

{ #category : #accessing }
DASVGraphNode >> localRectangle [
	^ 0@0 extent: self extent
]

{ #category : #accessing }
DASVGraphNode >> numberOfInputs [
	^ inputs size
]

{ #category : #accessing }
DASVGraphNode >> numberOfOutputs [
	^ outputs size
]

{ #category : #accessing }
DASVGraphNode >> outputs [
	^ outputs
]

{ #category : #accessing }
DASVGraphNode >> outputs: anObject [
	outputs := anObject
]

{ #category : #accessing }
DASVGraphNode >> position [
	^ bounds origin
]

{ #category : #accessing }
DASVGraphNode >> title [
	^ title
]

{ #category : #accessing }
DASVGraphNode >> title: anObject [
	title := anObject
]
