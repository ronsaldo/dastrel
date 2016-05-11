Class {
	#name : #DASLBuiltInFunctionAlternative,
	#superclass : #Object,
	#instVars : [
		'argumentTypes',
		'returnType',
		'coercionType',
		'options'
	],
	#category : #'Dastrel-Core-Builtin'
}

{ #category : #comparing }
DASLBuiltInFunctionAlternative >> = other [
	^ argumentTypes = other argumentTypes and: [ coercionType = other coercionType and: [ returnType = other returnType ] ]
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> argumentTypes [
	^ argumentTypes
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> argumentTypes: anObject [
	argumentTypes := anObject
]

{ #category : #convertion }
DASLBuiltInFunctionAlternative >> asBuiltInFunction [
	^ DASLBuiltInFunction new
		functionType: self functionType;
		coercionType: coercionType;
		builtInOptions: options
		yourself
]

{ #category : #testing }
DASLBuiltInFunctionAlternative >> canBeExpanded [
	argumentTypes do: [ :argType |
		(argType isPlaceholderType and: [ argType canBeExpanded not ]) ifTrue: [ 
			^ false
		]
	].
	^ true
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> cartesianProducts: arrayOfSets [
	| result |
	result := arrayOfSets first collect: [ :el | { el } ].
	2 to: arrayOfSets size do: [ :i | result := self vectors: result appendSet: (arrayOfSets at: i) ].
	^ result
	
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> coercionType [
	^ coercionType
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> coercionType: anObject [
	coercionType := anObject
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> expand [
	| expandedArguments argumentCartesianProduct |
	expandedArguments := argumentTypes collect: [ :type | self expandType: type ].
	argumentCartesianProduct := self cartesianProducts: expandedArguments.
	^ argumentCartesianProduct collect: [ :newArgumentTypes |
		(self copy) argumentTypes: newArgumentTypes; expandReferences
		 ]
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> expandReferenceValue: value [
	value isInteger ifFalse: [ ^ value ].
	(value > argumentTypes size or: [ value < 1 ]) ifTrue: [ self error: 'invalid expanded type reference' ].
	^ argumentTypes at: value
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> expandReferences [
	| reference |
	1 to: argumentTypes size do: [ :i |
		reference := argumentTypes at: i.
		reference isInteger ifTrue: [ 
			reference >= i ifTrue: [ self error: 'expanding invalid reference' ].
			argumentTypes at: i put: (argumentTypes at: reference)
		].
	].
	coercionType := self expandReferenceValue: coercionType.
	returnType := self expandReferenceValue: returnType.
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> expandType: type [
	type isInteger ifTrue: [ ^ { type } ].
	type isPlaceholderType ifTrue: [ ^ type expand ].
	^ { type }
]

{ #category : #convertion }
DASLBuiltInFunctionAlternative >> functionType [
	^ DASLFunctionType arguments: argumentTypes returnType: returnType
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> hasOption: anOption [
	^ options includes: anOption
]

{ #category : #comparing }
DASLBuiltInFunctionAlternative >> hash [
	^ (argumentTypes hash bitXor: coercionType hash) bitXor: returnType hash
]

{ #category : #testing }
DASLBuiltInFunctionAlternative >> isGeneric [
	argumentTypes do: [ :argType |
		argType isPlaceholderType ifTrue: [ ^ true ]
	].
	^ false
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> options [
	^ options
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> options: anObject [
	options := anObject
]

{ #category : #printing }
DASLBuiltInFunctionAlternative >> printOn: aStream [
	argumentTypes do: [ :argType | aStream print: argType; nextPut: $  ].
	aStream nextPutAll: '=> '; print: coercionType; nextPutAll: ' => '; print: returnType
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLBuiltInFunctionAlternative >> returnType: anObject [
	returnType := anObject
]

{ #category : #expansion }
DASLBuiltInFunctionAlternative >> vectors: vectors appendSet: set [
	| result |
	result := OrderedCollection new.
	vectors collect: [ :vector | 
		set do: [ :el | result add: vector , { el } ]
	].
	^ result
]
