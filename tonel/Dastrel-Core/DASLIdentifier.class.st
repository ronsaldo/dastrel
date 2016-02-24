Class {
	#name : #DASLIdentifier,
	#superclass : #DASLExpression,
	#instVars : [
		'value'
	],
	#category : #'Dastrel-Core'
}

{ #category : #'instance creation' }
DASLIdentifier class >> token: aPPToken [
	^ self new setPositionFromToken: aPPToken; value: aPPToken inputValue asSymbol; yourself
]

{ #category : #'as yet unclassified' }
DASLIdentifier >> printOn: aStream [
	value printOn: aStream
]

{ #category : #accessing }
DASLIdentifier >> value [
	^ value
]

{ #category : #accessing }
DASLIdentifier >> value: anObject [
	value := anObject
]
