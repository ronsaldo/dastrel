Class {
	#name : #DASLSSASpirVTranslator,
	#superclass : #Object,
	#instVars : [
		'translatedValues',
		'builder'
	],
	#classVars : [
		'StorageClassMap'
	],
	#pools : [
		'SpirVConstants'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #'class initialization' }
DASLSSASpirVTranslator class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	StorageClassMap := IdentityDictionary newFromPairs: #(
		uniformConstant 0
		input 1
		uniform 2
		output 3
		workgroup 4
		crossWorkgroup 5
		private 6
		function 7
		generic 8
		pushConstant 9
		atomicCounter 10
		image 11
	)
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> functionTranslation: aValue do: aBlock [
	"TODO: Implement myself"
]

{ #category : #initialization }
DASLSSASpirVTranslator >> initialize [
	super initialize.
	translatedValues := Dictionary new.
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> translateSSAModule: ssaModule [
	^ SpirVModule build: [ :builderArg |
		builder := builderArg.
		ssaModule globalValues valuesDo: [ :globalValue | self translateValue: globalValue ]
	]
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> translateValue: aValue [
	^ translatedValues at: aValue ifAbsent: [ aValue accept: self ]
]

{ #category : #'as yet unclassified' }
DASLSSASpirVTranslator >> valueTranslation: aValue do: aBlock [
	| valueId |
	valueId := builder newId.
	translatedValues at: aValue put: valueId.
	aBlock value: valueId.
	^ valueId.
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFloatType: floatType [
	^ self valueTranslation: floatType do: [ :id |
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeFloat result: id operands: {floatType size})
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitFunction: function [
	^ self functionTranslation: function do: [ :id |
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitGlobalVariable: globalVariable [
	| type |
	^ self valueTranslation: globalVariable do: [ :id |
		type := self translateValue: globalVariable type.
		
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitReferenceType: referenceType [
	| baseType storage |
	^ self valueTranslation: referenceType do: [ :id |
		baseType := self translateValue: referenceType baseType.
		storage := StorageClassMap at: referenceType storage.
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypePointer result: id operands: { storage . baseType })
	]
]

{ #category : #visitor }
DASLSSASpirVTranslator >> visitVectorType: vectorType [
	| baseType |
	^ self valueTranslation: vectorType do: [ :id |
		baseType := self translateValue: vectorType baseType.
		builder addTypeInstruction: (SpirVInstruction opcode: SpvOpTypeVector result: id operands: {baseType . vectorType elements})
	]
]
