Class {
	#name : #DAIRMakeVector,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRMakeVector class >> type: vectorType parameters: arguments [
	^ self new type: vectorType parameters: arguments
]

{ #category : #'as yet unclassified' }
DAIRMakeVector >> mnemonic [
	^ 'makeVector'
]

{ #category : #accessing }
DAIRMakeVector >> type [
	^ type
]

{ #category : #construction }
DAIRMakeVector >> type: vectorType parameters: arguments [
	self parameters: arguments.
	type := vectorType.
	arguments do: [ :arg | self assert: arg type = vectorType baseType ].
]
