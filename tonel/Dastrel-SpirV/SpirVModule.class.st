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

{ #category : #building }
SpirVModule >> addInstruction: anInstruction [
	instructions add: anInstruction
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

{ #category : #building }
SpirVModule >> writeOn: aByteStream [
	self emitOn: (SpirVStream new out: aByteStream)
]
