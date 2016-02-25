Class {
	#name : #SpirVModuleBuilder,
	#superclass : #Object,
	#instVars : [
		'module'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #adding }
SpirVModuleBuilder >> addInstruction: anInstruction [
	module addInstruction: anInstruction.

]

{ #category : #'control flow' }
SpirVModuleBuilder >> label: aLabel [
	^ self operation: SpvOpLabel result: aLabel
]

{ #category : #building }
SpirVModuleBuilder >> makeLabel [
	^ module newId
]

{ #category : #accessing }
SpirVModuleBuilder >> module [
	^ module
]

{ #category : #accessing }
SpirVModuleBuilder >> module: anObject [
	module := anObject
]

{ #category : #building }
SpirVModuleBuilder >> newId [
	^ module newId
]

{ #category : #miscellaneous }
SpirVModuleBuilder >> nop [
	self operation: SpvOpNop
]

{ #category : #adding }
SpirVModuleBuilder >> operation: opcode [
	self addInstruction: (SpirVInstruction new opcode: opcode)
]

{ #category : #adding }
SpirVModuleBuilder >> operation: opcode result: resultId [
	self addInstruction: (SpirVInstruction new opcode: opcode; resultId: resultId).
	^ resultId
]

{ #category : #miscellaneous }
SpirVModuleBuilder >> undef [
	^ self undef: self newId
]

{ #category : #miscellaneous }
SpirVModuleBuilder >> undef: result [
	^ self operation: SpvOpNop result: result
]
