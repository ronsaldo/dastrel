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

{ #category : #visitor }
DAIRJump >> accept: aVisitor [
	^ aVisitor visitJump: self
]

{ #category : #accessing }
DAIRJump >> destination [
	^ destination
]

{ #category : #accessing }
DAIRJump >> destination: anObject [
	destination := anObject
]

{ #category : #printing }
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

{ #category : #printing }
DAIRJump >> mnemonic [
	^ #jump
]

{ #category : #printing }
DAIRJump >> printOn: aStream [
	aStream nextPutAll: self mnemonic; nextPutAll:destination name
]

{ #category : #accessing }
DAIRJump >> successors [
	^ { destination }
]

{ #category : #accessing }
DAIRJump >> type [
	^ DASLType voidType
]
