Class {
	#name : #SpirVConstantGenerator,
	#superclass : #Object,
	#category : #'Dastrel-SpirV'
}

{ #category : #'as yet unclassified' }
SpirVConstantGenerator >> generateEnum: enum [
	| name values generatedData |
	name := enum at: 'Name'.
	values := enum at: 'Values'.
	generatedData := String streamContents: [ :out |
		out nextPutAll: 'dataFor' , name; cr.
		out tab; nextPutAll: '^ #('; cr.
		values keysAndValuesDo: [ :key :value |
			out tab; tab; nextPutAll: key; space; print: value; cr
		].
		out tab; nextPut: $).
	].

	SpirVConstants class compile: generatedData classified: 'constant data'
]

{ #category : #'as yet unclassified' }
SpirVConstantGenerator >> generateEnums: enums [
	| enumNames enumNamesCode |
	enums do: [ :enum | self generateEnum: enum ].
	enumNames := enums collect: [ :enum | enum at: 'Name' ].
	
	enumNamesCode := String streamContents: [ :out |
		out nextPutAll: 'enumNames'; cr.
		out tab; nextPutAll: '^ #('; cr.
		enumNames do: [ :enum |
			out tab; tab; nextPutAll: enum; cr.
		].
		out tab; nextPutAll: ')'; cr.
	].

	SpirVConstants class compile: enumNamesCode classified: 'constant data'
]

{ #category : #'as yet unclassified' }
SpirVConstantGenerator >> generateFrom: constantData [
	| spv |
	spv := constantData at: 'spv'.
	self generateEnums: (spv at: 'enum').
]
