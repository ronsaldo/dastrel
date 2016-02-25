Class {
	#name : #DASLIdentifier,
	#superclass : #DASLExpression,
	#instVars : [
		'value',
		'binding'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'instance creation' }
DASLIdentifier class >> token: aPPToken [
	^ self new setPositionFromToken: aPPToken; value: aPPToken inputValue asSymbol; yourself
]

{ #category : #visitor }
DASLIdentifier >> accept: aVisitor [
	^ aVisitor visitIdentifier: self
]

{ #category : #accessing }
DASLIdentifier >> binding [
	^ binding
]

{ #category : #accessing }
DASLIdentifier >> binding: anObject [
	binding := anObject
]

{ #category : #printing }
DASLIdentifier >> printOn: aStream [
	value printOn: aStream
]

{ #category : #accessing }
DASLIdentifier >> type [
	^ binding type
]

{ #category : #accessing }
DASLIdentifier >> value [
	^ value
]

{ #category : #accessing }
DASLIdentifier >> value: anObject [
	value := anObject
]
