Class {
	#name : #DAIRJump,
	#superclass : #DAIRInstruction,
	#instVars : [
		'destination',
		'mergeBlock',
		'continueBlock',
		'unreachableSuccessors'
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

{ #category : #'as yet unclassified' }
DAIRJump >> addUnreachableSuccessors [
	| changed |
	changed := false.
	mergeBlock predecessors ifEmpty: [
		unreachableSuccessors := { mergeBlock }.
		changed := true.
	].

	continueBlock predecessors ifEmpty: [
		unreachableSuccessors := { mergeBlock }.
		changed := true.
	].

	changed ifTrue: [ block computeSuccessors. ]
]

{ #category : #accessing }
DAIRJump >> continueBlock [
	^ continueBlock
]

{ #category : #accessing }
DAIRJump >> continueBlock: anObject [
	continueBlock := anObject
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

{ #category : #'as yet unclassified' }
DAIRJump >> initialize [
	super initialize.
	unreachableSuccessors := #()
]

{ #category : #testing }
DAIRJump >> isJump [
	^ true
]

{ #category : #testing }
DAIRJump >> isTerminator [
	^ true
]

{ #category : #accessing }
DAIRJump >> mergeBlock [
	^ mergeBlock
]

{ #category : #accessing }
DAIRJump >> mergeBlock: anObject [
	mergeBlock := anObject
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
	^ { destination } , unreachableSuccessors
]

{ #category : #accessing }
DAIRJump >> type [
	^ DASLType voidType
]
