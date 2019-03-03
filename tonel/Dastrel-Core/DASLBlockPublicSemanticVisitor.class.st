Class {
	#name : #DASLBlockPublicSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> declareBlockInputArgument: declaration [
	| blockNode |
	blockNode := currentScope node.
	blockNode inputs ifNil: [ blockNode inputs: OrderedDictionary new ].
	blockNode inputs at: declaration name ifPresent: [
		self error: 'Declaring repeated input variable ' , declaration at: declaration
	].

	blockNode inputs at: declaration name put: declaration
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> declareBlockOutputArgument: declaration [
	| blockNode |
	blockNode := currentScope node.
	blockNode outputs ifNil: [ blockNode outputs: OrderedDictionary new ].
	blockNode outputs at: declaration name ifPresent: [
		self error: 'Declaring repeated output variable ' , declaration at: declaration
	].

	declaration type: (DASLReferenceType baseType: declaration type storage: DASLType functionStorage).
	blockNode outputs at: declaration name put: declaration
]

{ #category : #resolving }
DASLBlockPublicSemanticVisitor >> resolveStructureBlockType: structureBlock on: typeExpression [
	structureBlock type ifNil: [ structureBlock accept: self ].
	^ super resolveStructureBlockType: structureBlock on: typeExpression

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitBufferBlock: bufferBlock [
	bufferBlock interfaceList do: [ :iface | iface accept: self ].
	
	bufferBlock scope: (DASLModuleScope new parentScope: currentScope; node: bufferBlock).
	self withScope: bufferBlock scope do: [
		bufferBlock body do: [ :field |
			field storage: DASLType uniformStorage.
			field accept: self.
		]
	].

]

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
DASLBlockPublicSemanticVisitor >> visitConstantGlobal: uniformGlobal [
	self resolveTypeOf: uniformGlobal.
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
	| argumentTypes |
	functionPrototype returnType: (self resolveTupleType: functionPrototype returnType).
	
	functionPrototype scope: (DASLModuleScope new parentScope: currentScope; node: functionPrototype).
	self withScope: functionPrototype scope do: [ 
		functionPrototype arguments do: [ :arg | arg accept: self ]
	].

	argumentTypes := functionPrototype arguments collect: #type.
	functionPrototype functionType: (DASLFunctionType arguments: argumentTypes returnType: functionPrototype returnType).
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitImportStatement: importStatement [
	"nothing to do"
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
	declaration flow ifNil: [ ^ self ].
	
	declaration initialValue ifNotNil: [ 
		declaration initialValue accept: self.
	].

	self resolveTypeOf: declaration inferWith: declaration initialValue.
	
	declaration initialValue ifNotNil: [
		self checkImplicitCoercion: declaration initialValue type to: declaration type on: declaration initialValue.
	].
	
	currentScope at: declaration name put: declaration ifPresent: [ 
		self error: 'local variable overrides an existing variable in the same lexical scope.' at: declaration.
	].

	declaration flow direction = #in ifTrue: [ ^ self declareBlockInputArgument: declaration ].
	declaration flow direction = #out ifTrue: [ ^ self declareBlockOutputArgument: declaration ].
	self halt.
]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitSemanticBlock: semanticBlock [
	semanticBlock interfaceList do: [ :iface | iface accept: self ].
	
	semanticBlock scope: (DASLModuleScope new parentScope: currentScope; node: semanticBlock).
	self withScope: semanticBlock scope do: [
		semanticBlock body do: [ :field |
			field flow ifNil: [ self error: 'flow information is required for members of semantic blocks.' ].
			field flow direction = #in ifTrue: [
				field storage: DASLType inputStorage
			].
			field flow direction = #out ifTrue: [
				field storage: DASLType outputStorage
			].
			
			field accept: self.
		]
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitStructureBlock: structureBlock [
	| fieldTypes fieldNames |
	structureBlock type ifNotNil: [ ^ self ].
	structureBlock type: #solving.
	structureBlock interfaceList do: [ :iface | iface accept: self ].
	
	structureBlock scope: (DASLModuleScope new parentScope: currentScope; node: structureBlock).
	fieldTypes := structureBlock body collect: [ :field |
		field accept: self.
		field type
	].

	fieldNames := structureBlock body collect: #name.
	structureBlock type: (DASLStructureType name: structureBlock name types: fieldTypes kind: DASLStructureType genericKind names: fieldNames)
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
		uniformBlock body do: [ :field |
			field storage: DASLType uniformStorage.
			field accept: self.
		]
	].

]

{ #category : #visitor }
DASLBlockPublicSemanticVisitor >> visitUniformGlobal: uniformGlobal [
	self resolveTypeOf: uniformGlobal.
]
