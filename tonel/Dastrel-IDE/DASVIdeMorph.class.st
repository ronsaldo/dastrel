Class {
	#name : #DASVIdeMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'graphBlock'
	],
	#category : #'Dastrel-IDE'
}

{ #category : #initialization }
DASVIdeMorph >> defaultExtent [
	^ 640@480
]

{ #category : #drawing }
DASVIdeMorph >> drawOn: aCanvas [
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

{ #category : #initialization }
DASVIdeMorph >> initialize [
	super initialize.
	self extent: self defaultExtent.
	
	surface := AthensCairoSurface extent: self extent.

]

{ #category : #drawing }
DASVIdeMorph >> render [
	surface drawDuring: [ :canvas |
		surface clear: Color white.
		canvas pathTransform loadIdentity.
	].

	
]
