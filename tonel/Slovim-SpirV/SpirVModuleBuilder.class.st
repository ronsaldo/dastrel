Class {
	#name : #SpirVModuleBuilder,
	#superclass : #Object,
	#instVars : [
		'module',
		'functionInstructions',
		'prologueInstructions',
		'debugInstructions',
		'annotationInstructions',
		'currentFunctionInstructions',
		'glsl450ExtensionId',
		'capabilityInstructions',
		'executionModeInstructions',
		'entryPointInstructions',
		'constantGlobalAndTypeInstructions'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Slovim-SpirV'
}

{ #category : #building }
SpirVModuleBuilder class >> build: aBlock [
	| builder |
	builder := self new.
	aBlock value: builder.
	^ builder finish.
]

{ #category : #adding }
SpirVModuleBuilder >> addAnnotationInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	annotationInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addCapability: capability [
	capabilityInstructions add: (SpirVInstruction opcode: SpvOpCapability operands: {capability}).
	
]

{ #category : #adding }
SpirVModuleBuilder >> addConstantInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	constantGlobalAndTypeInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addDebugInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	debugInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addEntryPointInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	entryPointInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addExecutionModeInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	executionModeInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addFunctionInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	currentFunctionInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addGlobalInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	constantGlobalAndTypeInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addPrologueInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	prologueInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #adding }
SpirVModuleBuilder >> addTypeInstruction: anInstruction [
	self assert: anInstruction opcode isNotNil.
	constantGlobalAndTypeInstructions add: anInstruction.
	^ anInstruction resultId
]

{ #category : #initialization }
SpirVModuleBuilder >> createDefaultPrologue [
	self addCapability: SpvCapabilityShader.
	glsl450ExtensionId := self newId.
	self addPrologueInstruction: (SpirVInstruction
		opcode: SpvOpExtInstImport
		result: glsl450ExtensionId
		operands: 'GLSL.std.450' asSpirVStringLiteral
	).
	self addPrologueInstruction: (SpirVInstruction
		opcode: SpvOpMemoryModel
		operands: {SpvAddressingModelLogical . SpvMemoryModelGLSL450}).
	
]

{ #category : #building }
SpirVModuleBuilder >> finish [
	module addInstructions: capabilityInstructions.
	module addInstructions: prologueInstructions.
	module addInstructions: entryPointInstructions.
	module addInstructions: executionModeInstructions.
	module addInstructions: debugInstructions.
	module addInstructions: annotationInstructions.
	module addInstructions: constantGlobalAndTypeInstructions.
	module addInstructions: functionInstructions.
	^ module
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

{ #category : #accessing }
SpirVModuleBuilder >> glsl450ExtensionSet [
	^ glsl450ExtensionId
]

{ #category : #initialization }
SpirVModuleBuilder >> initialize [
	super initialize.
	module := SpirVModule new.
	capabilityInstructions := OrderedCollection new.
	prologueInstructions := OrderedCollection new.
	entryPointInstructions := OrderedCollection new.
	executionModeInstructions := OrderedCollection new.
	debugInstructions := OrderedCollection new.
	annotationInstructions := OrderedCollection new.
	constantGlobalAndTypeInstructions := OrderedCollection new.
	functionInstructions := OrderedCollection new.
	self createDefaultPrologue.
]

{ #category : #building }
SpirVModuleBuilder >> makeLabel [
	^ module newId
]

{ #category : #accessing }
SpirVModuleBuilder >> module [
	^ module
]

{ #category : #building }
SpirVModuleBuilder >> newId [
	^ module newId
]