Class {
	#name : #DASLSSACodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'ssaModule',
		'currentFunction',
		'builder',
		'entryBlock',
		'allocaBuilder'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #coercing }
DASLSSACodegenVisitor >> coerce: value into: targetType [
	| valueType |
	self flag: 'TODO: Implement this properly.'.
	valueType := value type.
	valueType = targetType ifTrue: [ ^ value ].
	targetType isReferenceType ifTrue: [ self error: 'invalid implicit conversion between reference types.' ].
	valueType isReferenceType ifTrue: [ ^ self coerce: (builder load: value) into: targetType ].
	self halt.
]

{ #category : #coercing }
DASLSSACodegenVisitor >> constructVector: type arguments: arguments [
	| baseType expandedArguments coercedValues |
	baseType := type baseType.
	expandedArguments := OrderedCollection new.
	arguments do: [ :arg | self extractImplicitVectorElements: arg into: expandedArguments].
	self assert: expandedArguments size = type elements.
	coercedValues := expandedArguments collect: [ :arg | self coerce: arg into: baseType ].
	^ builder makeVector: type arguments: coercedValues asArray
]

{ #category : #coercing }
DASLSSACodegenVisitor >> extractImplicitVectorElements: vectorOrScalar into: expandedArguments [
	self flag: 'Perform the proper expansion that is needed'.
	expandedArguments add: vectorOrScalar
]

{ #category : #coercing }
DASLSSACodegenVisitor >> generateCastOrConstructionOf: type arguments: argumentValues [
	type isVectorType ifTrue: [ ^ self constructVector: type arguments: argumentValues ].
	self halt.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlock: aCodeBlock [
	| contentBlock |
	currentFunction := aCodeBlock codegenValue.
	builder := DAIRBuilder on: currentFunction.

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := DAIRBuilder on: currentFunction.
	allocaBuilder currentBlock: entryBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		aCodeBlock body do: [ :statement |
			builder isLastTerminator ifFalse: [ statement accept: self ]
		].
		
		builder isLastTerminator ifFalse: [ builder returnVoid ]
	].

	allocaBuilder jump: entryBlock

]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlockPrototype: aCodeBlock [
	"TODO: Generate the proper function type."
	| functionType |
	functionType := DASLFunctionType arguments: #() returnType: DASLType voidType.
	aCodeBlock codegenValue: (DAIRFunction name: aCodeBlock name functionType: functionType).
	ssaModule add: aCodeBlock codegenValue.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlockPrototypes: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlockPrototype: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateCodeBlocks: translationUnit [
	translationUnit modules select: #isCodeBlock thenDo: [ :block | self generateCodeBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunction: aFunctionNode [
	| contentBlock |
	currentFunction := ssaModule globalNamed: aFunctionNode mangledName.
	builder := DAIRBuilder on: currentFunction.

	entryBlock := builder newBasicBlock: #entry.
	allocaBuilder := DAIRBuilder on: currentFunction.
	allocaBuilder currentBlock: entryBlock.

	contentBlock := builder newBasicBlock: #content.
	builder withBasicBlock: contentBlock do: [
		builder isLastTerminator ifFalse: [ builder returnVoid ]
	].

	allocaBuilder jump: entryBlock
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctionPrototype: aFunctionNode [
	| functionType function |
	functionType := aFunctionNode functionType.
	function := DAIRFunction name: aFunctionNode mangledName functionType: functionType.
	aFunctionNode codegenValue: function.
	ssaModule add: function.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctions: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunction: block ]		
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateFunctionsPrototypes: translationUnit [
	translationUnit modules select: #isFunction thenDo: [ :block | self generateFunctionPrototype: block ]		
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateGraphBlockPrototypes: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlockPrototype: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateGraphBlocks: translationUnit [
	translationUnit modules select: #isGraphBlock thenDo: [ :block | self generateGraphBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticBlock: semanticBlock [
	| prefix |
	prefix := semanticBlock name , '.'.
	semanticBlock body do: [ :var | self generateSemanticVar: var prefix: prefix].
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticBlocks: translationUnit [
	translationUnit modules select: #isSemanticBlock thenDo: [ :block | self generateSemanticBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateSemanticVar: aVariable prefix: namePrefix [
	| fullName globalVar |
	fullName := namePrefix , aVariable name.
	globalVar := DAIRGlobalVariable name: fullName valueType: aVariable type.
	aVariable codegenValue: globalVar.
	globalVar propertyAt: #flowDirection put: aVariable flow direction.
	globalVar propertyAt: #flowLocation put: aVariable flow location.
	ssaModule add: globalVar.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlock: uniformBlock [
	| elementTypes blockType globalVar |
	elementTypes := uniformBlock body collect: #type.
	blockType := DASLStructureType types: elementTypes.
	globalVar := DAIRGlobalVariable name: uniformBlock name valueType: blockType.
	ssaModule add: globalVar.
	
	"TODO: Assign a const value to the fields of the uniform block"
]

{ #category : #visitor }
DASLSSACodegenVisitor >> generateUniformBlocks: translationUnit [
	translationUnit modules select: #isUniformBlock thenDo: [ :block | self generateUniformBlock: block ]
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitAssignment: assignment [
	| value variable coercedValued |
	value := assignment value accept: self.
	variable := assignment reference accept: self.
	self assert: variable type isReferenceType.
	coercedValued := self coerce: value into: variable type baseType.
	builder store: coercedValued in: variable.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitCallExpression: callExpression [
	| function arguments functionRefType functionType expectedArgumentTypes coercedArguments |
	function := callExpression solvedFunction ifNotNil: [
		 callExpression solvedFunction codegenValue
	] ifNil: [
		callExpression reference accept: self.
	].

	arguments := callExpression arguments collect: [ :arg | arg accept: self ].
	function isType ifTrue: [ ^ self generateCastOrConstructionOf: function arguments: arguments ].
	
	functionRefType := function type.
	self assert: functionRefType isReferenceType.
	functionType := functionRefType baseType.
	self assert: functionType isFunctionType.
	
	expectedArgumentTypes := functionType arguments.
	coercedArguments := arguments collectWithIndex: [ :argValue :index |
		self coerce: argValue into: (expectedArgumentTypes at: index)
	].

	^ builder call: function arguments: coercedArguments
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitFloat: literal [
	^ DAIRConstantValue type: literal type value: literal value
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitIdentifier: identifier [
	| binding |
	binding := identifier binding.
	^ binding isType ifTrue: [ binding ] ifFalse: [ binding codegenValue ].
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitLocalDeclaration: localDeclaration [
	| valueType variable initialValue coercedInitialValue |
	valueType := localDeclaration type.
	variable := allocaBuilder alloca: valueType name: localDeclaration name.
	localDeclaration codegenValue: variable.
	localDeclaration initialValue ifNotNil: [ 
		initialValue := localDeclaration initialValue accept: self.
		coercedInitialValue := self coerce: initialValue into: valueType.
		builder store: coercedInitialValue in: variable
	].

]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitMemberAccessExpression: memberAccess [
	| globalRefValue baseReference |
	globalRefValue := memberAccess globalReferenceValue.
	globalRefValue ifNotNil: [
		globalRefValue codegenValue ifNotNil: [ ^ globalRefValue codegenValue]
	].
	
	self halt.
	baseReference := memberAccess reference accept: self.
	^ builder getReference: baseReference element: memberAccess name.
]

{ #category : #visitor }
DASLSSACodegenVisitor >> visitTranslationUnit: translationUnit [
	ssaModule := DAIRModule new.
	
	self
		generateUniformBlocks: translationUnit;
		generateSemanticBlocks: translationUnit;
		generateFunctionsPrototypes: translationUnit;
		generateCodeBlockPrototypes: translationUnit;
		generateGraphBlockPrototypes: translationUnit;
		generateFunctions: translationUnit;
		generateCodeBlocks: translationUnit;
		generateGraphBlocks: translationUnit.
		
	^ ssaModule.
]
