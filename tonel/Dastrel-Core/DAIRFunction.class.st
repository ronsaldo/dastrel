Class {
	#name : #DAIRFunction,
	#superclass : #DAIRGlobalValue,
	#instVars : [
		'basicBlocks',
		'functionType',
		'type',
		'arguments',
		'gensymCount'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRFunction class >> name: aString functionType: aFunctionType [
	^ self new name: aString; functionType: aFunctionType; yourself
]

{ #category : #adding }
DAIRFunction >> addBasicBlock: aBasicBlock [
	basicBlocks add: aBasicBlock.
	aBasicBlock function: self.
]

{ #category : #accessing }
DAIRFunction >> arguments [
	^ arguments
]

{ #category : #accessing }
DAIRFunction >> basicBlocks [
	^ basicBlocks
]

{ #category : #printing }
DAIRFunction >> fullPrintOn: aStream [
	aStream nextPut: $@; print: name; space; print: type; cr.
	aStream nextPutAll: '{'; cr.
	basicBlocks do: [ :bb | bb printOn: aStream ].
	aStream nextPutAll: '}'; cr.
]

{ #category : #accessing }
DAIRFunction >> functionType [
	^ functionType
]

{ #category : #accessing }
DAIRFunction >> functionType: anObject [
	functionType := anObject.
	type := DASLReferenceType baseType: functionType.
	self makeArguments.
]

{ #category : #private }
DAIRFunction >> generateSymbol [
	gensymCount := gensymCount + 1.
	^ (#g , gensymCount printString) asSymbol
]

{ #category : #initialization }
DAIRFunction >> initialize [
	super initialize.
	basicBlocks := OrderedCollection new.
	arguments := #().
	gensymCount := 0.
]

{ #category : #private }
DAIRFunction >> makeArguments [
	arguments := functionType arguments collectWithIndex: [ :argType :index |
		DAIRFunctionArgument new
			type: argType;
			index: index;
			name: (#arg , index printString) asSymbol;
			yourself
	]
]

{ #category : #accessing }
DAIRFunction >> type [
	^ type
]
