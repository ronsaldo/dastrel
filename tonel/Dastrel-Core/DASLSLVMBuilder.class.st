Class {
	#name : #DASLSLVMBuilder,
	#superclass : #SLVMBuilder,
	#instVars : [
		'referencedConstants',
		'initializationBuilder'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'as yet unclassified' }
DASLSLVMBuilder >> generateReferenceToConstant: aConstant [
	| variable |
	^ referencedConstants at: aConstant ifAbsentPut: [
		variable := (allocaBuilder alloca: aConstant type).
		
		(initializationBuilder store: aConstant in: variable)
			volatile: true.
		variable
	]

]

{ #category : #accessing }
DASLSLVMBuilder >> initializationBuilder [
	^ initializationBuilder
]

{ #category : #accessing }
DASLSLVMBuilder >> initializationBuilder: anObject [
	initializationBuilder := anObject
]

{ #category : #'as yet unclassified' }
DASLSLVMBuilder >> initialize [
	super initialize.
	referencedConstants := Dictionary new.
]
