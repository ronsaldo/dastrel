Class {
	#name : #DASLGLSLCodegenVisitor,
	#superclass : #DASLHighLevelCodegenVisitor,
	#instVars : [
		'typeDictionary'
	],
	#classVars : [
		'SamplerTypeDictionary',
		'SamplerTypeMapping',
		'SpecialSemanticVariableMap',
		'TypeDictionary',
		'TypeMapping'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'class initialization' }
DASLGLSLCodegenVisitor class >> initialize [
	"
	self initialize
	"
	| builtInTypes |
	TypeMapping := #(
		bool bool
		char char
		short short
		int int
		uint uint
		long long
		ulong ulong
		float float
		double double
		float2 vec2
		float3 vec3
		float4 vec4
		float2x2 mat2
		float3x3 mat3
		float4x4 mat4
		
		texture2D texture2D
		textureCube textureCube
		sampler sampler
	).
	
	SamplerTypeMapping := #(
		texture2D sampler2D
		textureCube samplerCube
	).
	
	TypeDictionary := Dictionary new.
	SamplerTypeDictionary := Dictionary new.
	builtInTypes := DASLType builtInTypes.
	TypeMapping pairsDo: [ :myName :mappedName |
		TypeDictionary at: (builtInTypes at: myName) put: mappedName
	].

	SamplerTypeMapping pairsDo: [ :myName :mappedName |
		SamplerTypeDictionary at: (builtInTypes at: myName) put: mappedName
	].

	SpecialSemanticVariableMap := Dictionary newFromPairs: #(
		-1 gl_Position
	)
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateBufferBlock: uniformBlock [
	| prefix instanceName layoutString |
	instanceName := uniformBlock name , '_dastrel_singleton_'.
	prefix := instanceName , '.'.
	layoutString := self generateUniformLayoutString: uniformBlock.
	self
		printLine: layoutString , 'buffer ' , uniformBlock name;
		printLine: '{';
		withIndentation: [
			uniformBlock body do: [ :var | self generateUniformVar: var prefix: prefix].
		];
		printLine: '} ' , instanceName , ';';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateBuiltInCall: solvedFunction self: callSelf arguments: arguments [
	| samplerType |
	callSelf ifNotNil: [ 
		solvedFunction name = #sample ifTrue: [ 
			^ ByteString streamContents: [ :out |
				samplerType := self mapSamplerType: solvedFunction functionType arguments first.
				out nextPutAll: 'texture('.
				out nextPutAll: samplerType; nextPut: $(;
					nextPutAll: callSelf; nextPutAll: ', '; nextPutAll: arguments first;
					nextPut: $).
				out nextPutAll: ', '; nextPutAll: arguments second; nextPutAll: ')'.
			]
		].
	].

	^ super generateBuiltInCall: solvedFunction self: callSelf arguments: arguments

]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateCodeBlock: codeBlock [
	self printCodeBlockPrototype: codeBlock;
		newline;
		printLine: '{';
		withIndentation: [
			codeBlock body do: [ :statement | statement accept: self ]
		];
		printLine: '}';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateCodeBlockPrototype: codeBlock [
	self printCodeBlockPrototype: codeBlock;
		printString: ';';
		newline 
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateFunction: function [
	function prototype accept: self.
	self newline;
		printLine: '{';
		withIndentation: [
			currentFunction := function.
			function body do: [:statement | statement accept: self ].
			currentFunction := nil.
		];
		printLine: '}';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateFunctionPrototype: function [
	function prototype accept: self.
	self printString: ';';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateGraphBlock: uniformBlock [
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateGraphBlockPrototype: uniformBlock [
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generatePrologue [
	self printLine: '#version 400';
		printLine: '#extension GL_ARB_separate_shader_objects : enable';
		printLine: '#extension GL_ARB_shading_language_420pack : enable';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateSamplingAccess: memberAccess [
	^ memberAccess reference accept: self.
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateSemanticBlock: semanticBlock [
	| prefix |
	prefix := semanticBlock name , '_m_'.
	semanticBlock body do: [ :var | self generateSemanticVar: var prefix: prefix].
	self newline.
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateSemanticVar: semanticVar prefix: prefix [
	| flow glslType name varString |
	flow := semanticVar flow.
	flow location < 0 ifTrue: [
		semanticVar codegenValue: (SpecialSemanticVariableMap at: flow location).
		^ self.
	].

	varString := ByteString streamContents: [ :out |
		flow location >= 0 ifTrue: [ 
			out nextPutAll: 'layout (location = ';
				nextPutAll: flow location asString;
				nextPutAll: ') '.
		].

		glslType := self mapType: semanticVar type.
		name := semanticVar name.
		semanticVar codegenValue: prefix , name.
			
		out nextPutAll: flow direction; space;
			 nextPutAll: glslType; space;
			 nextPutAll: semanticVar codegenValue;
			 nextPutAll: (self typeSubscriptsFor: semanticVar type);
			 nextPut: $;.
	].

	self printLine: varString.
	
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateStructure: structure [
	| structureType |
	structureType := structure type.
	typeDictionary at: structureType ifPresent: [ ^ self ].
	self
		printLine: 'struct ' , structure name;
		printLine: '{';
		withIndentation: [
			structure body do: [ :var | self generateStructureField: var].
		];
		printLine: '};';
		newline.
	typeDictionary at: structureType put: structure name.
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateStructureField: var [
	| glslType |
	glslType := self mapType: var type.
	self printLine: glslType , ' ' , var name , (self typeSubscriptsFor: var type) , ';'
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateUniformBlock: uniformBlock [
	| prefix instanceName layoutString |
	instanceName := uniformBlock name , '_dastrel_singleton_'.
	prefix := instanceName , '.'.
	layoutString := self generateUniformLayoutString: uniformBlock.
	self
		printLine: layoutString , 'uniform ' , uniformBlock name;
		printLine: '{';
		withIndentation: [
			uniformBlock body do: [ :var | self generateUniformVar: var prefix: prefix].
		];
		printLine: '} ' , instanceName , ';';
		newline
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateUniformGlobal: uniformGlobal [
	| prefix instanceName layoutString glslType |
	instanceName := uniformGlobal name , '_dastrel_global_'.
	glslType := self mapType: uniformGlobal type.
	uniformGlobal codegenValue: instanceName.
	prefix := instanceName , '.'.
	layoutString := self generateUniformLayoutString: uniformGlobal.
	self
		printLine: layoutString , 'uniform ' , glslType, ' ', instanceName, ';'
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateUniformLayoutString: uniform [
	| layoutProperties pushConstant |
	layoutProperties := OrderedCollection new.
	pushConstant := false.
	uniform attributes keysAndValuesDo: [ :key :value |
		(key value = #binding or: [ key value = #set ]) ifTrue: [
			layoutProperties add: key value -> value value
		].
	
		key value = #push_constant ifTrue: [ 
			layoutProperties add: key value.
			pushConstant := true.
		]
	].

	(uniform isUniformBlock and: [ pushConstant not ]) ifTrue: [ 
		layoutProperties add: #std140
	].

	layoutProperties ifEmpty: [ ^ '' ].
	layoutProperties sort: [ :a :b |
		| sa sb |
		sa := a isSymbol ifTrue: [a] ifFalse: [ a key ].
		sb := b isSymbol ifTrue: [b] ifFalse: [ b key ].
		sa < sb
	].

	^ ByteString streamContents: [ :out |
		out nextPutAll: 'layout ('.
		layoutProperties doWithIndex: [ :prop :index |
			index > 1 ifTrue: [ out nextPutAll: ', ' ].
			prop isSymbol ifTrue: [
				out nextPutAll: prop 
			] ifFalse:[
				out nextPutAll: prop key; nextPutAll: ' = '; nextPutAll: prop value asString 
			]
		].
	
		out nextPutAll: ') '
	]
	
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateUniformVar: uniformVariable prefix: prefix [
	| glslType name |
	glslType := self mapType: uniformVariable type.
	name := uniformVariable name.
	self printLine: glslType , ' ' , name , (self typeSubscriptsFor: uniformVariable type) , ';'.
	uniformVariable codegenValue: prefix , name
]

{ #category : #'as yet unclassified' }
DASLGLSLCodegenVisitor >> initialize [
	super initialize.
	typeDictionary := Dictionary new.
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> mapSamplerType: type [
	^ SamplerTypeDictionary at: type
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> mapType: type [
	type isArrayType ifTrue: [
		^ self mapType: type baseType
	].
	typeDictionary at: type ifPresent: [ :mappedType | ^ mappedType ].
	^ TypeDictionary at: type
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> printCodeBlockPrototype: codeBlock [
	| first |
	self printTabs;
		printString: 'void ';
		printString: codeBlock name;
		printString: '('.
	first := true.

	codeBlock outputs ifNotNil: [ 
		codeBlock outputs keysAndValuesDo: [ :name :decl |
			first ifFalse: [ self printString: ', ' ].
			first := false.
			self
				printString: 'out '; 
				printString: (self mapType: decl type baseType);
				printString: ' ';
				printString: decl name.
			decl codegenValue: decl name.
		].
	].

	codeBlock inputs ifNotNil: [ 
		codeBlock inputs keysAndValuesDo: [ :name :decl |
			first ifFalse: [ self printString: ', ' ].
			first := false.
			self
				printString: 'in '; 
				printString: (self mapType: decl type);
				printString: ' ';
				printString: decl name.
			decl codegenValue: decl name.
		].
	].

	self printString: ')'.
]

{ #category : #visitor }
DASLGLSLCodegenVisitor >> visitFloat: floatLiteral [
	^ floatLiteral value printString
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> visitFunctionPrototype: prototype [
	| returnType functionType firstArg returnVarName |
	functionType := prototype functionType.
	returnType := functionType returnType.
	
	self printTabs.
	
	returnType isTupleType ifTrue: [ self printString: 'void' ] ifFalse: [ self printType: returnType ].
	self printString: ' ' , prototype name , ' ('.
	firstArg := true.
	prototype arguments do: [ :arg |
		firstArg ifFalse: [ self printString: ', ' ] ifTrue: [  firstArg := false ].
		arg codegenValue: arg name.
		self printString:  (self mapType: arg type) , ' ', arg name.
	].

	prototype codegenReturnVariables: #().
	returnType isTupleType ifTrue: [
		prototype codegenReturnVariables: OrderedCollection new.
		returnType types do: [ :retType |
			firstArg ifFalse: [ self printString: ', ' ] ifTrue: [  firstArg := false ].
			returnVarName := self gensym.
			self printString:  (self mapType: retType type) , ' ', returnVarName.
			prototype codegenReturnVariables add: returnVarName
		]
	].

	self printString: ')'.
	
]

{ #category : #visitor }
DASLGLSLCodegenVisitor >> visitInteger: integerLiteral [
	^ integerLiteral value printString
]
