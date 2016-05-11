Class {
	#name : #SpirVModuleBuilder,
	#superclass : #Object,
	#instVars : [
		'module',
		'typeInstructions',
		'functionInstructions',
		'prologueInstructions',
		'debugInstructions',
		'annotationInstructions',
		'globalVariablesInstructions',
		'constantsInstructions'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #adding }
SpirVModuleBuilder >> addAnnotationInstruction: anInstruction [
	annotationInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addConstantInstruction: anInstruction [
	constantsInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addDebugInstruction: anInstruction [
	debugInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addPrologueInstruction: anInstruction [
	prologueInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addTypeInstruction: anInstruction [
	typeInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #initialization }
SpirVModuleBuilder >> createDefaultPrologue [
	
]

{ #category : #building }
SpirVModuleBuilder >> finish [
	module addInstructions: prologueInstructions.
	module addInstructions: debugInstructions.
	module addInstructions: annotationInstructions.
	module addInstructions: typeInstructions.
	module addInstructions: constantsInstructions.
	module addInstructions: functionInstructions.
	
]

{ #category : #initialization }
SpirVModuleBuilder >> initialize [
	super initialize.
	prologueInstructions := OrderedCollection new.
	debugInstructions := OrderedCollection new.
	annotationInstructions := OrderedCollection new.
	typeInstructions := OrderedCollection new.
	constantsInstructions := OrderedCollection new.
	functionInstructions := OrderedCollection new.
	self createDefaultPrologue.
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
