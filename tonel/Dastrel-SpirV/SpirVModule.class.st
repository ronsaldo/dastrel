Class {
	#name : #SpirVModule,
	#superclass : #Object,
	#instVars : [
		'idBound',
		'instructions'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #'as yet unclassified' }
SpirVModule class >> build: aBlock [
	^ self new build: aBlock
]

{ #category : #building }
SpirVModule >> addInstruction: anInstruction [
	instructions add: anInstruction
]

{ #category : #building }
SpirVModule >> build: aBlock [
	| builder |
	builder := SpirVModuleBuilder new module: self.
	aBlock value: builder.
	^ self
]

{ #category : #building }
SpirVModule >> bytes [
	^ ByteArray streamContents: [ :out | self writeOn: out ]
]

{ #category : #'stream out' }
SpirVModule >> emitOn: aStream [
	aStream nextPut: SpvMagicNumber;
		nextPut: 0;
		nextPut: idBound;
		nextPut: 0.
	instructions do: [ :ins | ins emitOn: aStream ].
]

{ #category : #initialization }
SpirVModule >> initialize [
	super initialize.
	idBound := 0.
	instructions := OrderedCollection new.
]

{ #category : #'id generation' }
SpirVModule >> newId [
	| result |
	result := idBound.
	idBound := result + 1.
	^ result
]

{ #category : #building }
SpirVModule >> writeOn: aByteStream [
	self emitOn: (SpirVStream new out: aByteStream)
]
