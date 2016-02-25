Class {
	#name : #SpirVInstruction,
	#superclass : #Object,
	#instVars : [
		'opcode',
		'typeId',
		'resultId',
		'operands'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #'stream out' }
SpirVInstruction >> emitOn: aWordStream [
	aWordStream nextPut: opcode | (self wordCount << 16).
	typeId ifNotNil: [ aWordStream nextPut: typeId ].
	resultId ifNotNil: [ aWordStream nextPut: resultId ].
	aWordStream nextPutAll: operands.
]

{ #category : #accessing }
SpirVInstruction >> opcode [
	^ opcode
]

{ #category : #accessing }
SpirVInstruction >> opcode: anObject [
	opcode := anObject
]

{ #category : #accessing }
SpirVInstruction >> operands [
	^ operands
]

{ #category : #accessing }
SpirVInstruction >> operands: anObject [
	operands := anObject
]

{ #category : #accessing }
SpirVInstruction >> resultId [
	^ resultId
]

{ #category : #accessing }
SpirVInstruction >> resultId: anObject [
	resultId := anObject
]

{ #category : #accessing }
SpirVInstruction >> typeId [
	^ typeId
]

{ #category : #accessing }
SpirVInstruction >> typeId: anObject [
	typeId := anObject
]

{ #category : #accessing }
SpirVInstruction >> wordCount [
	| wordCount |
	wordCount := 0.
	typeId ifNotNil: [ wordCount := wordCount + 1 ].
	resultId ifNotNil: [ wordCount := wordCount + 1 ].
	wordCount := wordCount + operands size.
	^ wordCount
]
