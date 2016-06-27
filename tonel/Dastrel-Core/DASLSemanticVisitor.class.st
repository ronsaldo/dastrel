Class {
	#name : #DASLSemanticVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'compilationContext',
		'currentScope'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #'as yet unclassified' }
DASLSemanticVisitor class >> for: compilationContext passOn: ast [
	^ self new compilationContext: compilationContext; passOn: ast
]

{ #category : #resolving }
DASLSemanticVisitor >> adjustTypeForInference: type [
	type isReferenceType ifTrue: [ ^ type baseType ].
	^ type
]

{ #category : #resolving }
DASLSemanticVisitor >> arrayOfTypesToTuple: arrayOfTypes [
	^ arrayOfTypes size == 1 ifTrue: [ arrayOfTypes first ] ifFalse: [ DASLTupleType types: arrayOfTypes ].
]

{ #category : #types }
DASLSemanticVisitor >> checkImplicitCoercion: rawType to: rawCoercionType on: node [
	(self hasImplicitCoercion: rawType to: rawCoercionType) ifFalse: [ 
		self error: 'Cannot convert implicitly value of type "', rawCoercionType printString, '" into type "' , rawType printString , '".' at: node.
	]
]

{ #category : #types }
DASLSemanticVisitor >> compareAlmostExactTypes: functionTypes with: valueRefTypes [
	| functionType valueRefType |
	functionTypes size ~= valueRefTypes size ifTrue: [ ^ false ].
	
	1 to: functionTypes size do: [ :i |
		functionType := functionTypes at: i.
		valueRefType := valueRefTypes at: i.
		functionType ~= valueRefType ifTrue: [
			(valueRefType isReferenceType and: [ valueRefType baseType = functionType]) ifFalse: [ ^ false ]
		]
	].
	
	^ true
]

{ #category : #types }
DASLSemanticVisitor >> compareTypes: functionTypes with: valueRefTypes [
	| functionType valueRefType differences |
	functionTypes size ~= valueRefTypes size ifTrue: [ ^ -1 ].
	
	differences := 0.
	1 to: functionTypes size do: [ :i |
		functionType := functionTypes at: i.
		valueRefType := valueRefTypes at: i.
		functionType ~= valueRefType ifTrue: [
			(valueRefType isReferenceType and: [ valueRefType baseType = functionType]) ifFalse: [
				 (self hasImplicitCoercion: valueRefType to: functionType) ifTrue: [
					differences := differences + 1.
				] ifFalse: [
					^ -1
				]
			]
		]
	].

	^ differences
]

{ #category : #accessing }
DASLSemanticVisitor >> compilationContext [
	^ compilationContext
]

{ #category : #accessing }
DASLSemanticVisitor >> compilationContext: anObject [
	compilationContext := anObject
]

{ #category : #accessing }
DASLSemanticVisitor >> currentScope [
	^ currentScope
]

{ #category : #types }
DASLSemanticVisitor >> deReferenceType: aType [
	aType isReferenceType ifTrue: [ ^ aType baseType ].
	^ aType
]

{ #category : #'as yet unclassified' }
DASLSemanticVisitor >> error: errorMessage at: position [
	DASLSemanticError new
		position: position;
		messageText: errorMessage;
		signal
]

{ #category : #types }
DASLSemanticVisitor >> hasImplicitCoercion: rawType to: rawCoercionType [
	| type coercionType |
	rawType = rawCoercionType ifTrue: [ ^ true ].
	
	(rawCoercionType isReferenceType and: [ rawType isReferenceType and: [rawType baseType = rawCoercionType baseType ]]) ifTrue: [
		^ self hasStorageCoercion: rawType storage to: rawCoercionType storage
	].
	
	type := rawType.
	coercionType := rawCoercionType.

	"De reference the variable"
	type isReferenceType ifTrue: [ type := type baseType ].
	type = coercionType ifTrue: [ ^ true ].
	
	"Convert scalars into vectors automatically."
	(rawCoercionType isVectorType and: [ type isVectorType not ]) ifTrue: [ ^ self hasImplicitCoercion: type to: rawCoercionType baseType ].
	
	^ false
]

{ #category : #types }
DASLSemanticVisitor >> hasStorageCoercion: sourceStorage to: destStorage [
	sourceStorage = destStorage ifTrue: [ ^ true ].
	(sourceStorage = #output and: [ destStorage = #function ]) ifTrue: [ ^ true ].
	self halt.
]

{ #category : #types }
DASLSemanticVisitor >> lookOperationFunctionGroup: operation at: position [
	| functionGroup |
	functionGroup := currentScope lookSymbolRecursively: operation.
	functionGroup ifNil: [ self error: 'Unsupported operation yet: ' , operation at: position].
	^ functionGroup
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveStructureBlockType: structureBlock on: typeExpression [
	structureBlock type ifNil: [ self error: 'Failed to complete structure type.' at: typeExpression ].
	structureBlock type isSymbol ifTrue: [ self error: 'Circular structure types are not supported.' at: typeExpression].
	^ structureBlock type
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveTupleType: types [
	| resolvedTypes |
	resolvedTypes := types collect: [:type | self resolveType: type].
	^ self arrayOfTypesToTuple: resolvedTypes.
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveType: typeExpression [
	^ self resolveType: typeExpression inferWith: nil
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveType: typeExpression inferWith: inferenceExpression [
	| wrappedType |
	"Visit the type expression"
	typeExpression accept: self.
	
	(typeExpression type isType and: [typeExpression type isTypeWrapper]) ifFalse: [ 
		self error: 'expected a type' at: typeExpression.
	].

	wrappedType := typeExpression type wrapped.
	(wrappedType isBlockType and: [ wrappedType block isStructureBlock ]) ifTrue: [
		wrappedType := self resolveStructureBlockType: wrappedType block on: typeExpression.
	].

	wrappedType isAutoType ifTrue: [
		inferenceExpression ifNil: [ self error: 'cannot infer type without an expression' at: typeExpression ].
		wrappedType := self adjustTypeForInference: inferenceExpression type.
	].

	^ wrappedType
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveTypeOf: node [
	self resolveTypeOf: node inferWith: nil
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveTypeOf: node inferWith: inferenceExpression [
	node type: (self resolveType: node type inferWith: inferenceExpression) 
]

{ #category : #visitor }
DASLSemanticVisitor >> visitCharacter: characterLiteral [
]

{ #category : #visitor }
DASLSemanticVisitor >> visitFloat: floatLiteral [
]

{ #category : #visitor }
DASLSemanticVisitor >> visitIdentifier: identifier [
	identifier binding ifNotNil: [ ^self  ].
	identifier binding: (currentScope lookSymbolRecursively: identifier value).
	identifier binding ifNil: [ self error: 'failed to find symbol "' ,identifier value , '".' at: identifier ]
]

{ #category : #visitor }
DASLSemanticVisitor >> visitInteger: integerLiteral [
]

{ #category : #visitor }
DASLSemanticVisitor >> visitLiteralType: stringLiteral [
]

{ #category : #visitor }
DASLSemanticVisitor >> visitString: stringLiteral [
]

{ #category : #visitor }
DASLSemanticVisitor >> visitStructureBlock: structureBlock [
	self subclassResponsibility
]

{ #category : #visitor }
DASLSemanticVisitor >> visitTypeSubscriptExpression: expression [
	| baseType |
	baseType := self resolveType: expression reference inferWith: nil.
	expression type: (DASLTypeWrapper new wrapped: (DASLArrayType baseType: baseType elements: expression bounds)).
]

{ #category : #scope }
DASLSemanticVisitor >> withScope: aScope do: aBlock [
	| oldScope |
	oldScope := currentScope.
	currentScope := aScope.
	aBlock ensure: [ currentScope := oldScope ].
]
