Class {
	#name : #DAIRBasicBlock,
	#superclass : #DASLObject,
	#instVars : [
		'index',
		'postOrderIndex',
		'preOrderIndex',
		'name',
		'function',
		'instructions',
		'predecessors',
		'successors',
		'immediateDominator',
		'dominanceFrontier'
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
DAIRBasicBlock >> dominanceFrontier [
	^ dominanceFrontier
]

{ #category : #accessing }
DAIRBasicBlock >> dominanceFrontier: anObject [
	dominanceFrontier := anObject
]

{ #category : #printing }
DAIRBasicBlock >> fullPrintOn: aStream [
	aStream print: self; nextPut: $:.
	aStream space.
	self printArray: predecessors on: aStream.
	aStream space.
	self printArray: successors on: aStream.
	aStream cr.
	instructions do: [ :ins | aStream tab. ins fullPrintOn: aStream. aStream cr ]
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
DAIRBasicBlock >> immediateDominator [
	^ immediateDominator
]

{ #category : #accessing }
DAIRBasicBlock >> immediateDominator: anObject [
	immediateDominator := anObject
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
DAIRBasicBlock >> postOrderIndex [
	^ postOrderIndex
]

{ #category : #accessing }
DAIRBasicBlock >> postOrderIndex: anObject [
	postOrderIndex := anObject
]

{ #category : #accessing }
DAIRBasicBlock >> preOrderIndex [
	^ preOrderIndex
]

{ #category : #accessing }
DAIRBasicBlock >> preOrderIndex: anObject [
	preOrderIndex := anObject
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
DAIRBasicBlock >> printArray: anArray on: aStream [
	aStream nextPut: $[; space.
	anArray do: [ :el |
		 aStream print: el; space].
	aStream nextPut: $].
]

{ #category : #printing }
DAIRBasicBlock >> printOn: aStream [
	aStream nextPutAll: name; nextPut: $@; print: index
]

{ #category : #adding }
DAIRBasicBlock >> remove: anInstruction [ 
	instructions remove: anInstruction.
	anInstruction block: nil.

]

{ #category : #accessing }
DAIRBasicBlock >> successors [
	^ successors
]

{ #category : #accessing }
DAIRBasicBlock >> successors: anObject [
	successors := anObject
]
