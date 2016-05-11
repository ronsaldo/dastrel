Class {
	#name : #DAIRJump,
	#superclass : #DAIRInstruction,
	#instVars : [
		'destination'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #accessing }
DAIRJump class >> destination: aBasicBlock [
	^ self new destination: aBasicBlock
]

{ #category : #accessing }
DAIRJump >> destination [
	^ destination
]

{ #category : #accessing }
DAIRJump >> destination: anObject [
	destination := anObject
]

{ #category : #'as yet unclassified' }
DAIRJump >> fullPrintOn: aStream [
	aStream nextPutAll: 'jump '; nextPutAll:destination name
]

{ #category : #testing }
DAIRJump >> isJump [
	^ true
]

{ #category : #testing }
DAIRJump >> isTerminator [
	^ true
]

{ #category : #'as yet unclassified' }
DAIRJump >> printOn: aStream [
	aStream nextPutAll: 'jump '; nextPutAll:destination name
]

{ #category : #accessing }
DAIRJump >> successors [
	^ { destination }
]

{ #category : #accessing }
DAIRJump >> type [
	^ DASLType voidType
]
