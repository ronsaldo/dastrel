Class {
	#name : #DASLGLSLCodegenVisitor,
	#superclass : #DASLHighLevelCodegenVisitor,
	#classVars : [
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
	).
	
	TypeDictionary := Dictionary new.
	builtInTypes := DASLType builtInTypes.
	TypeMapping pairsDo: [ :myName :mappedName |
		TypeDictionary at: (builtInTypes at: myName) put: mappedName
	]
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
DASLGLSLCodegenVisitor >> generatePrologue: translationUnit [
	self printLine: '#version 450';
		newline
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
	varString := ByteString streamContents: [ :out |
		flow location >= 0 ifTrue: [ 
			out nextPutAll: 'layout(location = ';
				nextPutAll: flow location asString;
				nextPutAll: ') '.
		].

		glslType := self mapType: semanticVar type.
		name := semanticVar name.
		semanticVar codegenValue: prefix , name.
			
		out nextPutAll: flow direction; space;
			 nextPutAll: glslType; space;
			 nextPutAll: semanticVar codegenValue;
			 nextPut: $;.
	].

	self printLine: varString.
	
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> generateUniformBlock: uniformBlock [
	| prefix instanceName layoutString |
	instanceName := uniformBlock name , '_dastrel_singleton_'.
	prefix := instanceName , '.'.
	layoutString := 'layout('.
	layoutString := layoutString , 'std140) '.
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
DASLGLSLCodegenVisitor >> generateUniformVar: uniformVariable prefix: prefix [
	| glslType name |
	glslType := self mapType: uniformVariable type.
	name := uniformVariable name.
	self printLine: glslType , ' ' , name , ';'.
	uniformVariable codegenValue: prefix , name
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> mapType: type [
	^ TypeDictionary at: type
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> printCodeBlockPrototype: codeBlock [
	self printTabs;
		printString: 'void ';
		printString: codeBlock name;
		printString: '()'
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DASLGLSLCodegenVisitor >> visitInteger: integerLiteral [
	^ integerLiteral value printString
]

{ #category : #'code generation' }
DASLGLSLCodegenVisitor >> visitUsingStatement: usingStatement [
]
