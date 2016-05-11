Class {
	#name : #DAIRExtractVectorElement,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #'as yet unclassified' }
DAIRExtractVectorElement class >> vector: aVectorValue index: indexValue [
	^ self new vector: aVectorValue index: indexValue
]

{ #category : #visitor }
DAIRExtractVectorElement >> accept: aVisitor [
	^ aVisitor visitExtractVectorElement: self
]

{ #category : #accessing }
DAIRExtractVectorElement >> index [
	^ parameters second
]

{ #category : #printing }
DAIRExtractVectorElement >> mnemonic [
	^ 'extractVectorElement'
]

{ #category : #accessing }
DAIRExtractVectorElement >> type [
	^ type
]

{ #category : #accessing }
DAIRExtractVectorElement >> vector [
	^ parameters first
]

{ #category : #accessing }
DAIRExtractVectorElement >> vector: aVectorValue [
	self assert: aVectorValue isVectorType.
	type := aVectorValue baseType.
	self parameters: { aVectorValue }
]

{ #category : #accessing }
DAIRExtractVectorElement >> vector: aVectorValue index: indexValue [
	self assert: aVectorValue type isVectorType.
	type := aVectorValue type baseType.
	self parameters: { aVectorValue . indexValue}
]
