Class {
	#name : #DASLBlockPublicSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitCodeBlock: codeBlock [
	codeBlock interfaceList do: [ :iface | iface accept: self ].
	
	codeBlock scope: (DASLModuleScope new parentScope: currentScope; node: codeBlock).
	self withScope: codeBlock scope do: [
		codeBlock body do: [ :el |
			el isLocalDeclaration ifFalse: [^ self ].
			el accept: self.
		]
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitFieldDefinition: fieldDefinition [
	self resolveTypeOf: fieldDefinition.

	currentScope at: fieldDefinition name put: fieldDefinition ifPresent: [
		self error: 'field overrides a previously defined symbol' at: fieldDefinition
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitFunction: function [
	function prototype accept: self.
	
	function scope: (DASLModuleScope new parentScope: function prototype scope).

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitFunctionArgument: argument [
	self resolveTypeOf: argument.
	
	currentScope at: argument name put: argument ifPresent: [
		self error: 'argument overrides a previously defined symbol' at: argument
	].
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitFunctionPrototype: functionPrototype [
	functionPrototype returnType: (self resolveTupleType: functionPrototype returnType).
	
	functionPrototype scope: (DASLModuleScope new parentScope: currentScope; node: functionPrototype).
	self withScope: functionPrototype scope do: [ 
		functionPrototype arguments do: [ :arg | arg accept: self ]
	]
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitInterface: interface [
	interface interfaceList do: [ :iface | iface accept: self ].
	
	interface scope: (DASLModuleScope new parentScope: currentScope; node: interface).
	self withScope: interface scope do: [
		interface body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitLocalDeclaration: declaration [
	"TODO: Support in/out for code blocks"
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitSemanticBlock: semanticBlock [
	semanticBlock interfaceList do: [ :iface | iface accept: self ].
	
	semanticBlock scope: (DASLModuleScope new parentScope: currentScope; node: semanticBlock).
	self withScope: semanticBlock scope do: [
		semanticBlock body do: [ :el | el accept: self. ]
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitTranslationUnit: translationUnit [
	self withScope: translationUnit package do: [
		translationUnit modules do: [ :module | module accept: self ]
	].
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitUniformBlock: uniformBlock [
	uniformBlock interfaceList do: [ :iface | iface accept: self ].
	
	uniformBlock scope: (DASLModuleScope new parentScope: currentScope; node: uniformBlock).
	self withScope: uniformBlock scope do: [
		uniformBlock body do: [ :el | el accept: self. ]
	].

]
