Class {
	#name : #DAIRConstantBuiltInFunction,
	#superclass : #DAIRConstant,
	#instVars : [
		'functionType',
		'type',
		'name'
	],
	#classVars : [
		'ValidBuiltInFunctionNames'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #'class initialization' }
DAIRConstantBuiltInFunction class >> initialize [
	"
	self initialize
	"
	super initialize.
	ValidBuiltInFunctionNames := Set newFrom: #(
		"Vector functions"
		cross
		dot
		length
		normalize
		
		"Math functions"
		smoothstep
		step
		
		umin
		smin
		fmin
		
		umax
		smax
		fmax
		
		fmix
		
		"Matrix functions"
		transpose
	).
]

{ #category : #construction }
DAIRConstantBuiltInFunction class >> name: aName functionType: aFunctionType [
	^ self new name: aName functionType: aFunctionType
]

{ #category : #accessing }
DAIRConstantBuiltInFunction >> functionType [
	^ functionType
]

{ #category : #testing }
DAIRConstantBuiltInFunction >> isConstantBuiltInFunction [
	^ true
]

{ #category : #accessing }
DAIRConstantBuiltInFunction >> name [
	^ name
]

{ #category : #construction }
DAIRConstantBuiltInFunction >> name: aName functionType: aFunctionType [
	self assert: (ValidBuiltInFunctionNames includes: aName).
	name := aName.
	functionType := aFunctionType.
	type := DASLReferenceType baseType: functionType storage: DASLType genericStorage.
	
]

{ #category : #'as yet unclassified' }
DAIRConstantBuiltInFunction >> printOn: aStream [
	aStream nextPutAll: 'builtin '; print: name; space; print: functionType
]

{ #category : #accessing }
DAIRConstantBuiltInFunction >> type [
	^ type
]

{ #category : #accessing }
DAIRConstantBuiltInFunction >> type: anObject [
	type := anObject
]
