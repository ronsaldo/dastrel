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
DASLAstBuilder >> literalFloat: value [
	^ DASLFloat new
		value: value;
		suffix: #f;
		type: DASLType floatType;
		yourself
]
