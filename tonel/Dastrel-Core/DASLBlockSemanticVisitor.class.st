Class {
	#name : #DASLBlockSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCodeBlock: codeBlock [
	codeBlock interfaceList do: [ :iface | iface accept: self ].
	
	codeBlock scope: (DASLModuleScope new parentScope: currentScope; node: codeBlock).
	"self withScope: codeBlock scope do: [
		codeBlock body do: [ :el | el accept: self. ]
	].
"
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
