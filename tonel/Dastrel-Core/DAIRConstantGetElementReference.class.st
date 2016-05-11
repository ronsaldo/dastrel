Class {
	#name : #DAIRConstantGetElementReference,
	#superclass : #DAIRConstantExpresion,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRConstantGetElementReference class >> reference: reference index: index [
	^ self new reference: reference index: index
]

{ #category : #accessing }
DAIRConstantGetElementReference >> index [
	^ parameters second
]

{ #category : #printing }
DAIRConstantGetElementReference >> mnemonic [
	^ 'constantGetElementRef'
]

{ #category : #printing }
DAIRConstantGetElementReference >> printOn: aStream [
	aStream nextPutAll: '('; nextPutAll: self mnemonic.
	parameters doWithIndex: [ :param :index |
		index >= 1 ifTrue: [ aStream nextPutAll: ', ' ].
		aStream print: param.
	].
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DAIRConstantGetElementReference >> reference [
	^ parameters first
]

{ #category : #construction }
DAIRConstantGetElementReference >> reference: reference index: index [
	self parameters: { reference . index }.
	self assert: reference type isReferenceType.
	type := DASLReferenceType baseType: (reference type baseType memberAt: index)
]
