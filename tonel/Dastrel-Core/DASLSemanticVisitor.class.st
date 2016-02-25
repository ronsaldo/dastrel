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

{ #category : #accessing }
DASLSemanticVisitor >> currentScope [
	^ currentScope
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
