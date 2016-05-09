Class {
	#name : #DAIRBasicBlock,
	#superclass : #DASLObject,
	#instVars : [
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
		successors := anInstruction successors.
		successors do: [ :suc | suc addPredecessor: self]
	].
]

{ #category : #adding }
DAIRBasicBlock >> addPredecessor: aBasicBlock [
	predecessors add: aBasicBlock
]

{ #category : #accessing }
DAIRBasicBlock >> function [
	^ function
]

{ #category : #accessing }
DAIRBasicBlock >> function: anObject [
	function := anObject
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

{ #category : #accessing }
DAIRBasicBlock >> successors [
	^ successors
]

{ #category : #accessing }
DAIRBasicBlock >> successors: anObject [
	successors := anObject
]
