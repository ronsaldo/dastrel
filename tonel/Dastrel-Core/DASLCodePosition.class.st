Class {
	#name : #DASLCodePosition,
	#superclass : #Object,
	#instVars : [
		'collection',
		'start',
		'stop',
		'line',
		'column',
		'endLine',
		'endColumn'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #default }
DASLCodePosition class >> default [
	^ self new
]

{ #category : #converting }
DASLCodePosition >> asDASLCodePosition [
	^ self
]

{ #category : #accessing }
DASLCodePosition >> collection [
	^ collection
]

{ #category : #accessing }
DASLCodePosition >> collection: anObject [
	collection := anObject
]

{ #category : #converting }
DASLCodePosition >> column [
	column ifNil: [ self fetchLineAndColumn ].
	^ column
]

{ #category : #accessing }
DASLCodePosition >> endLine [
	endLine ifNil: [ self fetchEndLineAndColumn ].
	^ endLine
]

{ #category : #'as yet unclassified' }
DASLCodePosition >> fetchEndLineAndColumn [
	| lineColumn |
	collection ifNil: [
		endLine := 0.
		endColumn := 0.
		^ self
	].

	lineColumn := collection lineColumnAt: stop.
	endLine := lineColumn first.
	endColumn := lineColumn second.
]

{ #category : #'as yet unclassified' }
DASLCodePosition >> fetchLineAndColumn [
	| lineColumn |
	collection ifNil: [
		line := 0.
		column := 0.
		^ self
	].

	lineColumn := collection lineColumnAt: start.
	line := lineColumn first.
	column := lineColumn second.
]

{ #category : #accessing }
DASLCodePosition >> fileName [
	^ collection ifNil: ['generated'] ifNotNil: [collection name]
]

{ #category : #converting }
DASLCodePosition >> line [
	line ifNil: [ self fetchLineAndColumn ].
	^ line
]

{ #category : #printing }
DASLCodePosition >> printOn: aStream [
	aStream nextPutAll: self fileName; nextPut: $:; print: self line; nextPut: $:; print: self column 
]

{ #category : #accessing }
DASLCodePosition >> start [
	^ start
]

{ #category : #accessing }
DASLCodePosition >> start: anObject [
	start := anObject
]

{ #category : #accessing }
DASLCodePosition >> stop [
	^ stop
]

{ #category : #accessing }
DASLCodePosition >> stop: anObject [
	stop := anObject
]
