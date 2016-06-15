Class {
	#name : #DASVGraphNode,
	#superclass : #DASVVisualElement,
	#instVars : [
		'name',
		'inputs',
		'outputs',
		'title',
		'position',
		'size',
		'extent'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #initialize }
DASVGraphNode class >> defaultExtent [
	^ 180@150
]

{ #category : #initialize }
DASVGraphNode class >> defaultPosition [
	^ 0@0
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
	^ selected ifTrue: [ Color lightGray ] ifFalse: [ hasMouseOver ifTrue: [ Color gray ] ifFalse: [ Color black ] ]
]

{ #category : #accessing }
DASVGraphNode >> bounds [
	^ position extent: extent
]

{ #category : #accessing }
DASVGraphNode >> bounds: aRectangle [
	position := aRectangle topLeft.
	extent := aRectangle extent.
]

{ #category : #accessing }
DASVGraphNode >> center [
	^ position + (extent / 2)
]

{ #category : #accessing }
DASVGraphNode >> center: newCenter [
	position := position + newCenter - self center
]

{ #category : #drawing }
DASVGraphNode >> drawFrameOn: canvas [
	| shape |
	shape := self createShapeOn: canvas rectangleShape: self localRectangle radius: 5.
	
	canvas
		setPaint: self backgroundColor;
		setShape: shape;
		draw;
		setStrokePaint: self borderColor;
		draw.
]

{ #category : #drawing }
DASVGraphNode >> drawOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas
			pathTransform translateX: self position x Y: self position y.
		
		self
			drawFrameOn: canvas;
			drawTitleBarOn: canvas.
		
	]
]

{ #category : #drawing }
DASVGraphNode >> drawTitleBarOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: 5 Y: self font getPreciseAscent.
		canvas
			setFont: self font;
			setPaint: Color black;
			drawString: name
	]
]

{ #category : #accessing }
DASVGraphNode >> extent [
	^ extent
]

{ #category : #accessing }
DASVGraphNode >> extent: aPoint [
	extent := aPoint
]

{ #category : #initialization }
DASVGraphNode >> initialize [
	super initialize.
	name := 'Untitled node'.
	inputs := OrderedCollection new.
	outputs := OrderedCollection new.
	title := self class defaultTitle.
	position := self class defaultPosition.
	extent := self class defaultExtent.
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
DASVGraphNode >> name [
	^ name
]

{ #category : #accessing }
DASVGraphNode >> name: anObject [
	name := anObject
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
	^ position
]

{ #category : #accessing }
DASVGraphNode >> position: aPoint [
	position := aPoint
]

{ #category : #accessing }
DASVGraphNode >> title [
	^ title
]

{ #category : #accessing }
DASVGraphNode >> title: anObject [
	title := anObject
]

{ #category : #drawing }
DASVGraphNode >> titleBarHeight [
	^ self font getPreciseAscent + 5
]
