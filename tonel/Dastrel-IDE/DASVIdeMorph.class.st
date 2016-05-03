Class {
	#name : #DASVIdeMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'graphBlock',
		'session'
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

{ #category : #drawing }
DASVIdeMorph >> render [
	surface drawDuring: [ :canvas |
		surface clear: Color white.
		canvas pathTransform loadIdentity.
		
		graphBlock ifNotNil: [ graphBlock drawOn: canvas ]
	].

	
]
