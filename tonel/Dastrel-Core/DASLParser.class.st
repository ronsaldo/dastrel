Class {
	#name : #DASLParser,
	#superclass : #DASLGrammar,
	#category : #'Dastrel-Core-Parser'
}

{ #category : #parsing }
DASLParser class >> parseFromFileNamed: aFileName [
	^ self new parseFromFileNamed: aFileName
]

{ #category : #grammar }
DASLParser >> asignmentExpression [
	^ super asignmentExpression ==> [ :expr | expr second ifNil: [ expr first ] ifNotNil: [ 
				DASLAssignmentExpression new
					position: (self positionFromToken: expr second first);
					operation: expr second first inputValue asSymbol;
					reference: expr first;
					value: expr second second;
					yourself
			]  
		]
]

{ #category : #grammar }
DASLParser >> attributeKeyAndValue [
	^ super attributeKeyAndValue ==> [ :keyAndValue | keyAndValue first -> (keyAndValue second ifNotNil: [ keyAndValue second second ]) ]
]

{ #category : #grammar }
DASLParser >> attributeKeyAndValues [
	^ super attributeKeyAndValues ==> [ :keyAndValues | { keyAndValues first } , (keyAndValues second collect: #second)  ]
]

{ #category : #grammar }
DASLParser >> blockAttributes [
	^ super blockAttributes ==> [ :attributes | Dictionary newFrom: attributes second ]
]

{ #category : #grammar }
DASLParser >> blockStatement [
	^ super blockStatement ==> [ :statement |
		DASLBlockStatement new
			position: (self positionFromToken: statement first);
			statements: statement second
	]
]

{ #category : #grammar }
DASLParser >> blockVariable [
	^ super blockVariable ==> [:var | DASLFieldDefinition new
			position: var second position;
			flow: var first;
			type: var fourth;
			name: var second value;
			yourself]
]

{ #category : #grammar }
DASLParser >> breakStatement [
	^ super breakStatement ==> [ :tokens | DASLBreakStatement new
			position: (self positionFromToken: tokens first);
			yourself ]
]

{ #category : #grammar }
DASLParser >> buffer [
	^ super buffer ==> [ :block | DASLBufferBlock new
			position: (self positionFromToken: block first);
			attributes: block second;
			name: block third value;
			interfaceList: block fourth;
			body: block sixth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> callArguments [
	^ super callArguments ==> [ :args | { args first } , (args second collect: #second) ]
]

{ #category : #grammar }
DASLParser >> callBlockStatement [
	^ super callBlockStatement ==> [ :statement | DASLCallBlockStatement new
			position: statement second position;
			results: (statement first ifNotNil: [ statement first first ] ifNil: [ Dictionary new ]);
			arguments: statement third;
			blockReference: statement second;
			yourself
	]
]

{ #category : #grammar }
DASLParser >> callExpression [
	^ super callExpression ==> [ :expr | DASLCallExpression new
			position: (self positionFromToken: expr first);
			arguments: (expr second ifNil: [ #() ]);
			yourself ]
]

{ #category : #grammar }
DASLParser >> codeBlock [
	^ super codeBlock ==> [ :block | DASLCodeBlock new
			position: (self positionFromToken: block first);
			attributes: block second;
			name: block third value;
			interfaceList: block fourth;
			body: block sixth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> conditionalExpression [
	^ super conditionalExpression ==> [ :expr | expr second ifNil: [ expr first ] ifNotNil: [ 
				DASLConditionalExpression new
				position: (self positionFromToken: expr second first);
				condition: expr first;
				trueValue: expr second second;
				falseValue: expr second fourth;
				yourself
			] ]
]

{ #category : #grammar }
DASLParser >> continueStatement [
	^ super continueStatement ==> [ :tokens | DASLContinueStatement new
			position: (self positionFromToken: tokens first);
			yourself ]
]

{ #category : #grammar }
DASLParser >> descriptorSet [
	^ super descriptorSet ==> [ :tokens | DASLShaderSignatureDescriptorSet new
			position: (self positionFromToken: tokens first);
			properties: tokens second; 
			name: tokens third value;
			slots: tokens fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> descriptorSetElement [
	^ super descriptorSetElement ==> [ :tokens | DASLShaderSignatureDescriptorSlot new
			position: tokens first position;
			name: tokens first value;
			type: tokens third; 
			arraySize: (tokens fourth ifNotNil: [ :subscript | subscript second value ] ifNil: [0]);
			repetitionCount: (tokens fifth ifNotNil: [ :subscript | subscript second value ] ifNil: [1]);
			yourself ]
]

{ #category : #grammar }
DASLParser >> discardStatement [
	^ super discardStatement ==> [ :tokens | DASLDiscardStatement new
			position: (self positionFromToken: tokens first);
			yourself ]
]

{ #category : #grammar }
DASLParser >> expressionStatement [
	^ super expressionStatement ==> [ :expr | DASLExpressionStatement new
			position: expr first position;
			expression: expr first;
			yourself]
]

{ #category : #tokens }
DASLParser >> float [
	^ super float ==> [ :token | DASLFloat position: (self positionFromToken: token) token: token inputValue ]
]

{ #category : #grammar }
DASLParser >> forStatement [
	^ super forStatement ==> [ :statement |
		DASLForStatement new
			position: (self positionFromToken: statement first);
			initStatement: statement third;
			condition: statement fourth;
			increment: statement sixth;
			body: statement eighth
 	]
]

{ #category : #grammar }
DASLParser >> function [
	^ super function ==> [ :tokens | DASLFunction new
			position: tokens first position;
			prototype: tokens first;
			name: tokens first name;
			body: tokens third;
			yourself]
]

{ #category : #grammar }
DASLParser >> functionArgumentDecl [
	^ super functionArgumentDecl ==> [ :decl | DASLFunctionArgument new
			position: decl first position;
			type: decl third;
			name: decl first value;
			yourself ]
]

{ #category : #grammar }
DASLParser >> functionArgumentsDecl [
	^ super functionArgumentsDecl ==> [ :decls | {decls first } , (decls second collect: #second)]
]

{ #category : #grammar }
DASLParser >> functionPrototype [
	^ super functionPrototype ==> [ :tokens | DASLFunctionPrototype new
			position: (self positionFromToken: tokens first);
			name: tokens second value;
			arguments: (tokens fourth ifNil: [ #() ]);
			returnType: tokens seventh;
			yourself]
]

{ #category : #grammar }
DASLParser >> functionReturnTypes [
	^ super functionReturnTypes ==> [ :types | {types first } , types second ]
]

{ #category : #tokens }
DASLParser >> identifier [
	^ super identifier ==> [ :token | DASLIdentifier position: (self positionFromToken: token) token: token inputValue ]
]

{ #category : #grammar }
DASLParser >> ifStatement [
	^ super ifStatement ==> [ :statement |
		DASLIfStatement new
			position: (self positionFromToken: statement first);
			condition: statement third;
			thenStatement: statement fifth;
			elseStatement: (statement sixth ifNotNil: [ statement sixth second ])
	]
]

{ #category : #grammar }
DASLParser >> import [
	^ super import ==> [ :importExpr |
		DASLImportStatement new
			position: importExpr first;
			packageName: importExpr second value ]
]

{ #category : #grammar }
DASLParser >> inOutVariable [
	^ super inOutVariable ==> [ :local | DASLLocalDeclStatement new
			position: local first position;
			flow: local first;
			type: local third;
			name:  local second value;
			initialValue: local fourth;
			yourself]
]

{ #category : #initialization }
DASLParser >> initialize [
	super initialize.
	fileName := 'unknown'.
]

{ #category : #tokens }
DASLParser >> integer [
	^ super integer ==> [ :token | DASLInteger position: (self positionFromToken: token) token: token inputValue ]
]

{ #category : #grammar }
DASLParser >> interface [
	^ super interface ==> [ :iface | DASLInterface new
			position: (self positionFromToken: iface first);
			name: iface second value;
			interfaceList: iface third;
			body: iface fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> interfaceImplementations [
	^ super interfaceImplementations ==> [ :implements | { implements second } , (implements third collect: #second) ]
]

{ #category : #grammar }
DASLParser >> keywordElement [
	^ super keywordElement ==> [ :element | element first value -> element third ]
]

{ #category : #grammar }
DASLParser >> keywordList [
	^ super keywordList ==> [ :elements | Dictionary newFrom: elements ]
]

{ #category : #grammar }
DASLParser >> localVariable [
	^ super localVariable ==> [ :local | DASLLocalDeclStatement new
			position: (self positionFromToken: local first);
			type: local third;
			name:  local second value;
			initialValue: local fourth;
			yourself]
]

{ #category : #grammar }
DASLParser >> memberExpression [
	^ super memberExpression ==> [ :expr | DASLMemberAccessExpression new
			position: (self positionFromToken: expr first);
			memberName: expr second value;
			yourself ]
]

{ #category : #grammar }
DASLParser >> operate: left with: right do: operation [
	^ DASLBinaryOperation new
		position: (self positionFromToken: operation);
		operation: operation inputValue asSymbol;
		left: left;
		right: right;
		yourself
		
]

{ #category : #grammar }
DASLParser >> optionalType [
	^ super optionalType ==> [ :typeExpr |
		typeExpr ifNil: [ DASLLiteralType type: DASLType autoType ] ifNotNil: [ typeExpr second ]
	]
]

{ #category : #grammar }
DASLParser >> parentExpression [
	^ super parentExpression ==> [ :expr | expr second ]
]

{ #category : #parsing }
DASLParser >> parse: aCollection [
	^ super parse: aCollection asDastrelCollectionWithContext
]

{ #category : #parsing }
DASLParser >> parseFromFileNamed: aFileName [
	| fileRef contents |
	fileRef := aFileName asFileReference.
	contents := fileRef contents asDastrelCollectionWithContext.
	contents name: fileRef fullName.
	^ self parse: contents
]

{ #category : #utility }
DASLParser >> positionFromToken: aPPToken [
	^ aPPToken
]

{ #category : #grammar }
DASLParser >> postfix: operation operate: operand [
	^ DASLPostfixUnaryOperation new
		position: (self positionFromToken: operation);
		operation: operation inputValue asSymbol;
		operand: operand;
		yourself
]

{ #category : #grammar }
DASLParser >> prefix: operation operate: operand [
	^ DASLPrefixUnaryOperation new
		position: (self positionFromToken: operation);
		operation: operation inputValue asSymbol;
		operand: operand;
		yourself
]

{ #category : #grammar }
DASLParser >> pushConstantSignature [
	^ super pushConstantSignature ==> [ :tokens | DASLShaderSignaturePushConstant new
			position: (self positionFromToken: tokens first);
			properties: tokens second; 
			name: tokens third value;
			count: (tokens fourth ifNotNil: [ :count | count second value ] ifNil: [ 1 ] );
			yourself ]
]

{ #category : #grammar }
DASLParser >> returnStatement [
	^ super returnStatement ==> [ :tokens | DASLReturnStatement new
			position: (self positionFromToken: tokens first);
			value: tokens second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> semantic [
	^ super semantic ==> [ :block | DASLSemanticBlock new
			position: (self positionFromToken: block first);
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> shaderSignature [
	^ super shaderSignature ==> [ :tokens | DASLShaderSignature new
			position: (self positionFromToken: tokens first);
			name: tokens second value;
			elements: tokens fourth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> shaderSignatureElementKeywordType [
	^ super shaderSignatureElementKeywordType ==> [ :token | DASLIdentifier position: (self positionFromToken: token) token: token inputValue ]
]

{ #category : #grammar }
DASLParser >> start [
	^ super start ==> [ :modules | DASLTranslationUnit new modules: modules ]
]

{ #category : #grammar }
DASLParser >> struct [
	^ super struct ==> [ :block | DASLStructureBlock new
			position: (self positionFromToken: block first);
			attributes: block second;
			name: block third value;
			interfaceList: block fourth;
			body: block sixth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> subscriptExpression [
	^ super subscriptExpression ==> [ :expr | DASLSubscriptExpression new
			position: (self positionFromToken: expr first);
			index: expr second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> termExpression [
	^ super termExpression ==> [ :expr | |currentLeft |
		currentLeft := expr first.
		expr second do: [:access |
			access reference: currentLeft.
			currentLeft := access. ].
		currentLeft ]
]

{ #category : #grammar }
DASLParser >> type [
	| typeNode |
	^ super type ==> [ :typeExpr |
		typeNode := typeExpr first.
		typeExpr second do: [ :memberAccess |
			memberAccess reference: typeNode.
			typeNode := memberAccess
		].
	
		typeExpr third do: [ :arraySubscript |
			arraySubscript reference: typeNode.
			typeNode := arraySubscript
		].
	
		typeNode.
	]
]

{ #category : #grammar }
DASLParser >> typeArraySubscript [
	^ super typeArraySubscript ==> [ :expr |
		DASLTypeSubscriptExpression new
			position: (self positionFromToken: expr first);
			bounds: expr second value;
			yourself
	]
]

{ #category : #grammar }
DASLParser >> uniform [
	^ super uniform ==> [ :block | DASLUniformBlock new
			position: (self positionFromToken: block first);
			attributes: block second;
			name: block third value;
			interfaceList: block fourth;
			body: block sixth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> uniformGlobal [
	^ super uniformGlobal ==> [ :global | DASLUniformGlobal new
			position: (self positionFromToken: global first);
			attributes: global second;
			name: global third value;
			type: global fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> usingAliasStatement [
	^ super usingAliasStatement ==> [ :tokens | DASLUsingStatement new
			position: (self positionFromToken: tokens first);
			identifier: tokens second;
			expression: tokens fourth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> usingExpressionStatement [
	^ super usingExpressionStatement ==> [ :tokens | DASLUsingStatement new
			position: (self positionFromToken: tokens first);
			expression: tokens second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowDirection [
	^ super varFlowDirection ==> [ :flow | DASLConnectionFlowType new
			position: (self positionFromToken: flow first);
			direction: flow first inputValue asSymbol;
			location: flow second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowLocation [
	^ super varFlowLocation ==> [ :location | location second value ]
]

{ #category : #grammar }
DASLParser >> varInitialValue [
	^ super varInitialValue ==> [ :initialValue |  initialValue second ]
]

{ #category : #grammar }
DASLParser >> whileStatement [
	^ super whileStatement ==> [ :statement |
		DASLWhileStatement new
			position: (self positionFromToken: statement first);
			condition: statement third;
			body: statement fifth
	]
]
