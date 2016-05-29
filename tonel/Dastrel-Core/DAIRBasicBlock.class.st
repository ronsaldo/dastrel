Class {
	#name : #DAIRBasicBlock,
	#superclass : #DASLObject,
	#instVars : [
		'index',
		'name',
		'function',
		'instructions',
		'predecessors',
		'successors'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #adding }
DAIRBasicBlock >> add: anInstruction [ 
	instructions add: anInstruction.
	anInstruction block: self.
	anInstruction isTerminator ifTrue: [
		self computeSuccessors
	].
]

{ #category : #adding }
DAIRBasicBlock >> addPredecessor: aBasicBlock [
	predecessors add: aBasicBlock
]

{ #category : #adding }
DAIRBasicBlock >> computeSuccessors [
	successors := instructions last successors.
	successors do: [ :suc | suc addPredecessor: self]

]

{ #category : #accessing }
DAIRBasicBlock >> function [
	^ function
]

{ #category : #accessing }
DAIRBasicBlock >> function: anObject [
	function := anObject
]

{ #category : #accessing }
DAIRBasicBlock >> index [
	^ index
]

{ #category : #accessing }
DAIRBasicBlock >> index: anObject [
	index := anObject
]

{ #category : #initialization }
DAIRBasicBlock >> initialize [
	super initialize.
	instructions := OrderedCollection new.
	predecessors := Set new.
	successors := #()
]

{ #category : #accessing }
DAIRBasicBlock >> instructions [
	^ instructions
]

{ #category : #accessing }
DAIRBasicBlock >> instructions: anObject [
	instructions := anObject
]

{ #category : #testing }
DAIRBasicBlock >> isEmpty [
	^ instructions isEmpty
]

{ #category : #testing }
DAIRBasicBlock >> isLastTerminator [
	^ self isEmpty not and: [ self lastInstruction isTerminator ]
]

{ #category : #accessing }
DAIRBasicBlock >> lastInstruction [
	^ instructions last
]

{ #category : #accessing }
DAIRBasicBlock >> name [
	^ name
]

{ #category : #accessing }
DAIRBasicBlock >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DAIRBasicBlock >> numberOfInstructions [
	^ instructions size
]

{ #category : #accessing }
DAIRBasicBlock >> predecessors [
	^ predecessors
]

{ #category : #accessing }
DAIRBasicBlock >> predecessors: anObject [
	predecessors := anObject
]

{ #category : #printing }
DAIRBasicBlock >> printOn: aStream [
	aStream nextPutAll: name; nextPut: $:; cr.
	instructions do: [ :ins | aStream tab. ins fullPrintOn: aStream. aStream cr ]
]

{ #category : #accessing }
DAIRBasicBlock >> successors [
	^ successors
]

{ #category : #accessing }
DAIRBasicBlock >> successors: anObject [
	successors := anObject
]
