Class {
	#name : #DASLBuiltInScope,
	#superclass : #DASLexicalScope,
	#classVars : [
		'BuiltInScope'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #'instance creation' }
DASLBuiltInScope class >> uniqueInstance [
	"
	This singleton is for performance reasons.
	
	BuiltInScope := nil.
	"
	^ BuiltInScope ifNil: [ BuiltInScope := DASLBuiltInScope new ]
]

{ #category : #adding }
DASLBuiltInScope >> addFunctionGroup: functionGroup [
	self at: functionGroup name put: functionGroup ifPresent: [ 
		self error: 'compiler bug'
	]
]

{ #category : #adding }
DASLBuiltInScope >> addType: type [
	self at: type name put: type ifPresent: [ 
		self error: 'compiler bug'
	]
]

{ #category : #initialization }
DASLBuiltInScope >> initialize [
	super initialize.
	DASLType builtInTypes values do: [ :type | self addType: type ].
	DASLBuiltInFunctions builtInFunctions values do: [ :functionGroup | self addFunctionGroup: functionGroup ].
	
]
