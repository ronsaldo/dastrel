Class {
	#name : #DASLBuiltInFunctionPrototypeParser,
	#superclass : #Object,
	#instVars : [
		'rawPrototypes',
		'prototypes',
		'currentOptions',
		'currentGroups',
		'supportedTypes'
	],
	#category : #'Dastrel-Core-Builtin'
}

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> addSupportedTypes [
	DASLType builtInTypes keysAndValuesDo: [ :key :value | supportedTypes at: key put: value ].
	self specialTypes pairsDo: [ :key :value | supportedTypes at: key put: value ].
]

{ #category : #expansion }
DASLBuiltInFunctionPrototypeParser >> expandToVectorVersions: alternatives [
	| expandedVersions newAlternative |
	expandedVersions := OrderedCollection new.
	alternatives do: [ :alternative |
		expandedVersions add: alternative.
		2 to: 4 do: [ :i |
			newAlternative := alternative copy.
			newAlternative argumentTypes: (alternative argumentTypes collect: [:arg |
				DASLVectorType baseType: arg elements: i]).
			expandedVersions add: newAlternative
		].
	].
	^ expandedVersions
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> findOrCreateFunctionGroup: name [
	^ rawPrototypes at: name ifAbsentPut: [ Set new ]
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> hasOption: optionName [
	^ currentOptions includes: optionName
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> initialize [
	prototypes := IdentityDictionary new.
	rawPrototypes := IdentityDictionary new.
	supportedTypes := IdentityDictionary new.
	self addSupportedTypes.
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> parseAlternative: overloadAlternativeSignature [
	| parsedSignature expandedSignatures |
	parsedSignature := self parseAlternativeSignature: overloadAlternativeSignature.
	parsedSignature isGeneric ifTrue: [ 
		parsedSignature canBeExpanded ifTrue: [ 
			expandedSignatures := parsedSignature expand.
		] ifFalse: [
			expandedSignatures := { parsedSignature expandReferences }.
		]
	] ifFalse: [ 
		expandedSignatures := { parsedSignature }.
	].
	
	(self hasOption: #ignoreOrder) ifTrue: [
		expandedSignatures := self shuffleArgumentOrders: expandedSignatures.
	].

	(self hasOption: #expandToVector) ifTrue: [ 
		expandedSignatures := self expandToVectorVersions: expandedSignatures.
	].

	expandedSignatures	 do: [ :signature |
		currentGroups do: [ :group | group add: signature]
	]
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> parseAlternativeSignature: overloadAlternativeSignature [
	| argumentTypes symbol coercionType returnType options |
	argumentTypes := OrderedCollection new.
	
	ReadStream with: overloadAlternativeSignature do: [ :in |
		[ symbol := in next .
		symbol ~~ #=> and: [symbol isNotNil ] ] whileTrue: [ 
			argumentTypes add: symbol.
		].
	
		coercionType := in next.
		options := in next.
		options == #=> ifTrue: [
			returnType := in next.
			options := in next.
		]
	].

	returnType ifNil: [ returnType := coercionType ].

	options ifNil: [ options := #() ].
	options := Set newFrom: options.
	
	^ DASLBuiltInFunctionAlternative new
		argumentTypes: (argumentTypes collect: [ :typeName | self parseType: typeName ]);
		coercionType: (self parseType: coercionType);
		returnType: (self parseType: returnType);
		options: options;
		isMember: (self hasOption: #member);
		yourself

]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> parsePrototype: prototypeData [
	| names alternatives |
	names := prototypeData first.
	names isArray ifFalse: [ names := { names } ].
	
	currentOptions := IdentitySet newFrom: prototypeData second.
	alternatives := prototypeData allButFirst: 2.
	
	currentGroups := names collect: [ :name | self findOrCreateFunctionGroup: name ].
	alternatives do: [ :alternative | self parseAlternative: alternative ].
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> parsePrototypes: prototypesData [
	| group |
	prototypesData do: [ :prototype | self parsePrototype: prototype ].
	rawPrototypes keysAndValuesDo: [ :name :alternatives |
		group := DASLFunctionGroup new name:
			name;
			addAllAlternatives: (alternatives collect: [:alt | alt asBuiltInFunction name: name; yourself]);
			yourself.
		prototypes at: name put: group
	].
	^ prototypes
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> parseType: aSymbolOrNumber [
	aSymbolOrNumber isNumber ifTrue: [ ^ aSymbolOrNumber ].
	^ supportedTypes at: aSymbolOrNumber ifAbsent: [ self error: 'unsupported type ' , aSymbolOrNumber printString ]
]

{ #category : #expansion }
DASLBuiltInFunctionPrototypeParser >> shuffleArgumentOrders: alternatives [
	| shuffledVersion |
	shuffledVersion := OrderedCollection new.
	alternatives do: [ :alternative |
		alternative argumentTypes permutationsDo: [ :perm |
			shuffledVersion add: (alternative copy argumentTypes: perm copy; yourself)
		]
	].

	^ shuffledVersion
]

{ #category : #parsing }
DASLBuiltInFunctionPrototypeParser >> specialTypes [
	^ {
		#any . DASLTypeConstraintAny asType .
		#smallInt . DASLTypeConstraintSmallInt asType .
		#smallUInt . DASLTypeConstraintSmallUInt asType .
		#smallIntAnySign . DASLTypeConstraintSmallIntAnySign asType .
		#integer . DASLTypeConstraintInteger asType .
		#floatingPoint . DASLTypeConstraintFloatingPoint asType .
	}
]
