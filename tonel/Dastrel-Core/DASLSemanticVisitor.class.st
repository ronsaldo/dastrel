Class {
	#name : #DASLSemanticVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'currentScope'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #resolving }
DASLSemanticVisitor >> adjustTypeForInference: type [
	^ type
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

{ #category : #accessing }
DASLSemanticVisitor >> currentScope [
	^ currentScope
]

{ #category : #types }
DASLSemanticVisitor >> deReferenceType: aType [
	aType isReferenceType ifTrue: [ ^ aType baseType ].
	^ aType
]

{ #category : #types }
DASLSemanticVisitor >> lookOperationFunctionGroup: operation at: position [
	| functionGroup |
	functionGroup := currentScope lookSymbolRecursively: operation.
	functionGroup ifNil: [ self error: 'Unsupported operation yet: ' , operation at: position].
	^ functionGroup
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveTupleType: types [
	| resolvedTypes |
	resolvedTypes := types collect: [:type | self resolveType: type].
	^ resolvedTypes size == 1 ifTrue: [ resolvedTypes first ] ifFalse: [ DASLTupleType types: resolvedTypes ].
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
DASLSemanticVisitor >> visitString: stringLiteral [
]

{ #category : #scope }
DASLSemanticVisitor >> withScope: aScope do: aBlock [
	| oldScope |
	oldScope := currentScope.
	currentScope := aScope.
	aBlock ensure: [ currentScope := oldScope ].
]
