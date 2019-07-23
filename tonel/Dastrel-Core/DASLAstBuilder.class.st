Class {
	#name : #DASLAstBuilder,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-AST'
}

{ #category : #'as yet unclassified' }
DASLAstBuilder >> constantGlobalNamed: name typeNamed: typeName value: value [
	^ DASLConstantGlobal new
		name: name;
		type: (self identifier: typeName);
		initializationLiteral: value;
		yourself
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> identifier: value [
	^ DASLIdentifier new value: value
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> listLiteralWith: elements [
	^ DASLBlockListLiteral new
		elements: elements
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> literalFloat: value [
	^ DASLFloat new
		value: value;
		suffix: #f;
		type: DASLType floatType;
		yourself
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> literalInt: value [
	^ DASLFloat new
		value: value;
		type: DASLType intType;
		yourself
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> literalUInt: value [
	^ DASLFloat new
		value: value;
		suffix: #u;
		type: DASLType uintType;
		yourself
]

{ #category : #'as yet unclassified' }
DASLAstBuilder >> literalVector: type values: values [
	| actualType |
	actualType := type.
	actualType isSymbol ifTrue: [ actualType := DASLType builtInTypes at: type ].
	
	^ DASLCallExpression new
			reference: actualType asDastrelTypeNode;
			arguments: values;
			yourself
]
