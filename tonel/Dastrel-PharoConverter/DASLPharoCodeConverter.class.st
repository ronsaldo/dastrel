Class {
	#name : #DASLPharoCodeConverter,
	#superclass : #Object,
	#instVars : [
		'convertedStructures',
		'generatedNodes',
		'convertedFunctions',
		'convertedAnonymousFunctions',
		'anonFunctionCount'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> convertFunction: function name: requiredName argumentTypes: argumentType returnType: returnType [
	^ convertedFunctions at: {requiredName . function} ifAbsentPut: [
		| result |
		result := function generateDastrelFunctionWith: self withName: requiredName argumentTypes: argumentType returnType: returnType.
		generatedNodes add: result
	]

]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> evaluateTypeSpecification: argumentTypeDesc [
	| compositeType |
	argumentTypeDesc isSymbol ifTrue: [
		DASLType builtInTypes at: argumentTypeDesc ifPresent: [ :found | ^ found ].
		^ (Smalltalk globals at: argumentTypeDesc) asDastrelConversionTypeWith: self 
	].

	argumentTypeDesc isArray ifTrue: [ 
		compositeType := argumentTypeDesc first.
		compositeType == #tuple ifTrue: [
			^ DASLTupleType types: (argumentTypeDesc allButFirst collect: [ :elTypeSpec | self evaluateTypeSpecification: elTypeSpec ])
		] ifFalse: [ 
			self assert: argumentTypeDesc first = #ref.
			^ (self evaluateTypeSpecification: argumentTypeDesc second) asFunctionReferenceType
		]
	].

	self error: 'unsupported argument'


]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> functionTypeReturning: returnType [
	^ DASLPharoCodeFunctionType new returnType: returnType
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> generateAnonymousFunction: function argumentTypes: argumentTypes returnType: returnType [
	| name |
	name := convertedAnonymousFunctions at: function ifAbsent: [
		name := ('_anonF' , anonFunctionCount asString) asSymbol.
		anonFunctionCount := anonFunctionCount + 1.
		convertedAnonymousFunctions at: function put: name.
		self convertFunction: function name: name argumentTypes: argumentTypes returnType: returnType.
		name
	].

	^ DASLIdentifier new value: name
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> generatedNodes [
	^ generatedNodes
]

{ #category : #initialization }
DASLPharoCodeConverter >> initialize [
	super initialize.
	convertedFunctions := Dictionary new.
	generatedNodes := OrderedCollection new.
	convertedStructures := Dictionary new.
	convertedAnonymousFunctions := Dictionary new.
	anonFunctionCount := 0.
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> lowcodeStructureWrapper: lowcodeStructure [
	| result |
	convertedStructures at: lowcodeStructure ifPresent: [ :found | ^ found ].
	result := DASLPharoCodeLowcodeStructureType new
		name: lowcodeStructure;
		wrappedClass: lowcodeStructure;
		yourself.
		
	convertedStructures at: lowcodeStructure put: lowcodeStructure.
		
	
	^ result
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> lowcodeStructureWrapper: lowcodeStructure to: targetType [
	^ convertedStructures at: lowcodeStructure ifAbsentPut: [
		DASLType builtInTypes at: targetType ifAbsent: [
			DASLPharoCodeLowcodeStructureType new
				name: targetType;
				wrappedClass: lowcodeStructure;
				yourself.
		]
	]
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> parseFunctionDefinition: source [
	^ (DASLParser parse: source) modules first
]

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> sysmelStructureWrapper: sysmelStructure to: targetType [
	^ convertedStructures at: sysmelStructure ifAbsentPut: [
		DASLType builtInTypes at: targetType ifAbsent: [
			DASLPharoCodeSysmelStructureType new
				name: targetType;
				wrappedClass: sysmelStructure;
				yourself.
		]
	]
]
