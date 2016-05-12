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
		'constantsInstructions',
		'globalsInstructions',
		'currentFunctionInstructions'
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
SpirVModuleBuilder >> addCapability: capability [
	self addPrologueInstruction: (SpirVInstruction opcode: SpvOpCapability operands: {capability}).
	
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
SpirVModuleBuilder >> addFunctionInstruction: anInstruction [
	currentFunctionInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addGlobalInstruction: anInstruction [
	globalsInstructions add: anInstruction.
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
	self addCapability: SpvCapabilityShader.
	
]

{ #category : #building }
SpirVModuleBuilder >> finish [
	module addInstructions: prologueInstructions.
	module addInstructions: debugInstructions.
	module addInstructions: annotationInstructions.
	module addInstructions: typeInstructions.
	module addInstructions: constantsInstructions.
	module addInstructions: globalsInstructions.
	module addInstructions: functionInstructions.
	
]

{ #category : #building }
SpirVModuleBuilder >> functionDo: aBlock [
	| oldScope |
	oldScope := currentFunctionInstructions.
	currentFunctionInstructions := OrderedCollection new.
	[
		aBlock value.
		functionInstructions addAll: currentFunctionInstructions.
	] ensure: [ currentFunctionInstructions := oldScope. ]
]

{ #category : #initialization }
SpirVModuleBuilder >> initialize [
	super initialize.
	prologueInstructions := OrderedCollection new.
	debugInstructions := OrderedCollection new.
	annotationInstructions := OrderedCollection new.
	typeInstructions := OrderedCollection new.
	constantsInstructions := OrderedCollection new.
	globalsInstructions := OrderedCollection new.
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
