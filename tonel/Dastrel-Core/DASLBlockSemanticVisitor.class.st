Class {
	#name : #DASLBlockSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitAssignment: assignment [
	assignment reference accept: self.
	assignment value accept: self.

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitBinaryOperation: operation [
	operation left accept: self.
	operation right accept: self.
	"TODO: Check the types of the operands and compute the return types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCallExpression: operation [
	operation reference accept: self.
	operation arguments do: [ :arg | arg accept: self ].
	"TODO: Check the types of the operands and compute the result types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCodeBlock: codeBlock [
	codeBlock interfaceList do: [ :iface | iface accept: self ].
	
	codeBlock scope: (DASLModuleScope new parentScope: currentScope; node: codeBlock).
	self withScope: codeBlock scope do: [
		codeBlock body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFieldDefinition: fieldDefinition [
	currentScope at: fieldDefinition name put: fieldDefinition ifPresent: [
		self error: 'field overrides a previously defined symbol' at: fieldDefinition
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFunction: function [
	function prototype accept: self.
	
	function scope: (DASLModuleScope new parentScope: function prototype scope).
	self withScope: function scope do: [
		function body do: [ :el | el accept: self. ]
	]

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFunctionArgument: argument [
	self resolveTypeOf: argument.
	
	currentScope at: argument name put: argument ifPresent: [
		self error: 'argument overrides a previously defined symbol' at: argument
	].
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFunctionPrototype: functionPrototype [
	functionPrototype returnType: (self resolveTupleType: functionPrototype returnType).
	
	functionPrototype scope: (DASLModuleScope new parentScope: currentScope; node: functionPrototype).
	self withScope: functionPrototype scope do: [ 
		functionPrototype arguments do: [ :arg | arg accept: self ]
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitIdentifier: identifier [
	identifier binding: (currentScope lookSymbolRecursively: identifier value).
	identifier binding ifNil: [ self error: 'failed to find symbol "' ,identifier value , '".' at: identifier ]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitInterface: interface [
	interface interfaceList do: [ :iface | iface accept: self ].
	
	interface scope: (DASLModuleScope new parentScope: currentScope; node: interface).
	self withScope: interface scope do: [
		interface body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitLocalDeclaration: declaration [
	declaration initialValue ifNotNil: [ 
		declaration initialValue accept: self.
	].

	self resolveTypeOf: declaration inferWith: declaration initialValue.
	
	"TODO: check the initial value type."
	
	currentScope at: declaration name put: declaration ifPresent: [ 
		self error: 'local variable overrides an existing variable in the same lexical scope.' at: declaration.
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitMemberAccessExpression: memberAccess [
	memberAccess reference accept: self.
	
	"TODO: Check the referenced type. Ensure the member exist."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPostfixUnaryOperation: operation [
	operation operand accept: self.
	"TODO: Check the types of the operands and compute the result types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPrefixUnaryOperation: operation [
	operation operand accept: self.
	"TODO: Check the types of the operands and compute the result types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitReturnStatement: returnStatement [
	returnStatement value do: [ :val | val accept: self ].
	"TODO: Check the return type"
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitSemanticBlock: semanticBlock [
	semanticBlock interfaceList do: [ :iface | iface accept: self ].
	
	semanticBlock scope: (DASLModuleScope new parentScope: currentScope; node: semanticBlock).
	self withScope: semanticBlock scope do: [
		semanticBlock body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitTranslationUnit: translationUnit [
	self withScope: translationUnit package do: [
		translationUnit modules do: [ :module | module accept: self ]
	].
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUniformBlock: uniformBlock [
	uniformBlock interfaceList do: [ :iface | iface accept: self ].
	
	uniformBlock scope: (DASLModuleScope new parentScope: currentScope; node: uniformBlock).
	self withScope: uniformBlock scope do: [
		uniformBlock body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUsingStatement: usingStatement [
	| usedType identifier useScope |
	usingStatement expression accept: self.
	identifier := usingStatement identifier.
	identifier ifNotNil: [ self halt.
	].

	usedType := usingStatement expression type.
	useScope := usedType useScope.
	useScope ifNil: [ self error: 'cannot be used.' at: usingStatement ].
	
	currentScope addUseScope: useScope.
]
