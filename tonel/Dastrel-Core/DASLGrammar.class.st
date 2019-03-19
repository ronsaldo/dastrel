Class {
	#name : #DASLGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'identStart',
		'newline',
		'singleLineComment',
		'multiLineComment',
		'ignorable',
		'identifier',
		'integer',
		'floatExponent',
		'floatDotted',
		'floatScientfic',
		'float',
		'number',
		'numberSign',
		'kwInterface',
		'leftCBracket',
		'interfaceBody',
		'rightCBracket',
		'blockVariable',
		'varFlowDirection',
		'type',
		'kwIn',
		'kwOut',
		'leftParent',
		'rightParent',
		'semicolon',
		'interface',
		'kwUniform',
		'kwSemantic',
		'kwImplements',
		'comma',
		'interfaceImplementations',
		'uniform',
		'semantic',
		'semanticBody',
		'uniformBody',
		'varFlowLocation',
		'kwCodeBlock',
		'codeBody',
		'usingStatement',
		'discardStatement',
		'kwUsing',
		'kwDiscard',
		'codeBlock',
		'keywordEnd',
		'codeStatement',
		'binaryExpression',
		'unaryExpression',
		'literalExpression',
		'parentExpression',
		'expression',
		'expressionStatement',
		'assignmentOperator',
		'conditionalExpression',
		'questionMark',
		'colon',
		'kwSizeOf',
		'kwAlignOf',
		'memberExpression',
		'termExpression',
		'dot',
		'nullaryExpression',
		'accessExpression',
		'subscriptExpression',
		'leftBracket',
		'rightBracket',
		'function',
		'kwFunction',
		'functionArgumentDecl',
		'arrow',
		'functionReturnTypes',
		'functionPrototype',
		'callExpression',
		'callArguments',
		'returnStatement',
		'equalAssign',
		'localVariable',
		'functionArgumentsDecl',
		'kwReturn',
		'varInitialValue',
		'usingAliasStatement',
		'usingExpressionStatement',
		'blockAttributes',
		'attributeKeyAndValue',
		'attributeKeyAndValues',
		'kwLet',
		'optionalType',
		'inOutVariable',
		'globalBlock',
		'kwImport',
		'import',
		'uniformGlobal',
		'ifStatement',
		'switchStatement',
		'whileStatement',
		'doWhileStatement',
		'forStatement',
		'breakStatement',
		'continueStatement',
		'kwContinue',
		'kwBreak',
		'kwIf',
		'kwElse',
		'kwWhile',
		'kwDo',
		'kwFor',
		'kwSwitch',
		'switchCases',
		'switchCase',
		'kwCase',
		'blockStatement',
		'struct',
		'kwStruct',
		'structBody',
		'callBlockStatement',
		'keywordList',
		'keywordElement',
		'leftArrow',
		'typeArraySubscript',
		'kwBuffer',
		'buffer',
		'kwShaderSignature',
		'shaderSignature',
		'shaderSignatureElement',
		'descriptorSet',
		'kwDescriptorSet',
		'descriptorSetElement',
		'shaderSignatureElementType',
		'shaderSignatureElementKeywordType',
		'multiply',
		'pushConstantSignature',
		'kwPushConstant',
		'boolean',
		'kwTrue',
		'kwFalse',
		'trueLiteral',
		'falseLiteral',
		'assignmentExpression',
		'importModuleLocation',
		'constantGlobal',
		'kwConstant',
		'initializationLiteral',
		'blockInitializationLiteral',
		'blockInitializationLiteralContent',
		'kwShared',
		'sharedGlobal',
		'pragma',
		'pragmas'
	],
	#classVars : [
		'Keywords'
	],
	#category : #'Dastrel-Core-Parser'
}

{ #category : #'class initialization' }
DASLGrammar class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	Keywords := Set newFrom: #(
		in out inout
		let constant
		uniform buffer shared
		interface semantic implements struct
		sizeof alignof
		function code_block graph_block
		using discard return
		import
		case
		if else for do while switch break continue
		shader_signature descriptor_set
		#true #false
	).
]

{ #category : #grammar }
DASLGrammar >> accessExpression [
	^ memberExpression / subscriptExpression / callExpression
]

{ #category : #tokens }
DASLGrammar >> arrow [
	^ '->' asParser token trim: ignorable
]

{ #category : #accessing }
DASLGrammar >> assignmentExpression [
	^ conditionalExpression , (assignmentOperator , assignmentExpression) optional
]

{ #category : #tokens }
DASLGrammar >> assignmentOperator [
	^ (($+ asParser / $- asParser /
		$* asParser / $/ asParser / $% asParser /
		'<<' asParser / '>>' asParser /
		$& asParser / $^ asParser / $| asParser) optional, $= asParser) token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> attributeKeyAndValue [
	^ identifier , (equalAssign , expression) optional
]

{ #category : #grammar }
DASLGrammar >> attributeKeyAndValues [
	^ attributeKeyAndValue , (comma , attributeKeyAndValue) star
]

{ #category : #grammar }
DASLGrammar >> binaryExpression [
	| binExpr binOpDo prefixOpDo postfixOpDo |
	binExpr := PPExpressionParser new.
	binExpr term: unaryExpression.
	binOpDo := [ :left :operation :right | self operate: left with: right do: operation. ].
	prefixOpDo := [ :operation :operand | self prefix: operation operate: operand ].
	postfixOpDo := [ :operand :operation | self postfix: operation operate: operand ].
	
	binExpr
		group: [ :g |
			g postfix: (self operator: '++') do: postfixOpDo.
			g postfix: (self operator: '--') do: postfixOpDo.
			];
		group: [ :g |
			g prefix: (self operator: '++') do: prefixOpDo.
			g prefix: (self operator: '--') do: prefixOpDo.
			g prefix: (self operator: $+) do: prefixOpDo.
			g prefix: (self operator: $-) do: prefixOpDo.
			g prefix: (self operator: $!) do: prefixOpDo.
			g prefix: (self operator: $~) do: prefixOpDo.
			g prefix: kwSizeOf do: prefixOpDo.
			g prefix: kwAlignOf do: prefixOpDo.
			];
		group: [ :g |
			g left: (self operator: $*) do: binOpDo. 
			g left: (self operator: $/) do: binOpDo. 
			g left: (self operator: $%) do: binOpDo.];
		group: [ :g |
			g left: (self operator: $+) do: binOpDo.
			g left: (self operator: $-) do: binOpDo. ];
		group: [ :g |
			g left: (self operator: '<<') do: binOpDo.
			g left: (self operator: '>>') do: binOpDo. ];
		group: [ :g |
			g left: (self operator: '<=') do: binOpDo.
			g left: (self operator: '>=') do: binOpDo.
			g left: (self operator: $<) do: binOpDo.
			g left: (self operator: $>) do: binOpDo. ];
		group: [ :g |
			g left: (self operator: '==') do: binOpDo.
			g left: (self operator: '!=') do: binOpDo. ];
		group: [ :g |
			g left: (self operator: $&) do: binOpDo. ];
		group: [ :g |
			g left: (self operator: $^) do: binOpDo. ];
		group: [ :g |
			g left: (self operator: $|) do: binOpDo. ];
		group: [ :g |
			g left: (self operator: '&&') do: binOpDo. ];
		group: [ :g |
			g left: (self operator: '||') do: binOpDo. ].
	^ binExpr
]

{ #category : #grammar }
DASLGrammar >> blockAttributes [
	^ leftParent , attributeKeyAndValues , rightParent
]

{ #category : #grammar }
DASLGrammar >> blockInitializationLiteral [
	^ leftCBracket , blockInitializationLiteralContent optional , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> blockInitializationLiteralContent [
	^ initializationLiteral , (comma , initializationLiteral) star , comma optional
]

{ #category : #grammar }
DASLGrammar >> blockStatement [
	^ leftCBracket , pragmas, codeStatement star , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> blockVariable [
	^ varFlowDirection optional , identifier , colon , type , semicolon
]

{ #category : #grammar }
DASLGrammar >> boolean [
	^ trueLiteral / falseLiteral
]

{ #category : #grammar }
DASLGrammar >> breakStatement [
	^ kwBreak , semicolon
]

{ #category : #grammar }
DASLGrammar >> buffer [
	^ kwBuffer , blockAttributes optional , identifier , interfaceImplementations optional, leftCBracket, uniformBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> callArguments [
	^ expression , (comma , expression) star
]

{ #category : #grammar }
DASLGrammar >> callBlockStatement [
	^ (keywordList , leftArrow) optional , expression , keywordList, semicolon
]

{ #category : #grammar }
DASLGrammar >> callExpression [
	^ leftParent , callArguments optional, rightParent
]

{ #category : #grammar }
DASLGrammar >> codeBlock [
	^ kwCodeBlock , blockAttributes optional , identifier , interfaceImplementations optional, leftCBracket, codeBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> codeBody [
	^ codeStatement star
]

{ #category : #grammar }
DASLGrammar >> codeStatement [
	^ usingStatement / localVariable / inOutVariable / discardStatement / returnStatement / ifStatement / switchStatement / whileStatement / doWhileStatement / forStatement / breakStatement / continueStatement / blockStatement / callBlockStatement / expressionStatement
]

{ #category : #tokens }
DASLGrammar >> colon [
	^ $: asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> comma [
	^ $, asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> conditionalExpression [
	^ binaryExpression , (questionMark , binaryExpression , colon , binaryExpression ) optional
]

{ #category : #grammar }
DASLGrammar >> constantGlobal [
	^ kwConstant , identifier , colon , type, equalAssign , initializationLiteral,  semicolon
]

{ #category : #grammar }
DASLGrammar >> continueStatement [
	^ kwContinue , semicolon
]

{ #category : #grammar }
DASLGrammar >> descriptorSet [
	^ kwDescriptorSet , blockAttributes optional , identifier , leftCBracket , descriptorSetElement star , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> descriptorSetElement [
	^ identifier , colon , shaderSignatureElementType , (leftBracket , integer , rightBracket) optional , (multiply , integer) optional, semicolon
]

{ #category : #grammar }
DASLGrammar >> discardStatement [
	^ kwDiscard , semicolon
]

{ #category : #grammar }
DASLGrammar >> doWhileStatement [
	^ kwDo , codeStatement , kwWhile, leftParent , expression , rightParent , semicolon
]

{ #category : #tokens }
DASLGrammar >> dot [
	^ $. asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> equalAssign [
	^ $= asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> expression [
	^ assignmentExpression
]

{ #category : #grammar }
DASLGrammar >> expressionStatement [
	^ expression , semicolon
]

{ #category : #grammar }
DASLGrammar >> falseLiteral [
	^ kwFalse
]

{ #category : #tokens }
DASLGrammar >> float [
	^ floatDotted / floatScientfic
]

{ #category : #tokens }
DASLGrammar >> floatDotted [
	^ (numberSign optional , #digit asParser plus , $. asParser, #digit asParser star , floatExponent optional , #letter asParser star) token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> floatExponent [
	^ ($e asParser / $E asParser) , numberSign optional, #digit asParser plus
]

{ #category : #tokens }
DASLGrammar >> floatScientfic [
	^ (numberSign optional , #digit asParser plus , floatExponent , #letter asParser star) token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> forStatement [
	^ kwFor , leftParent , codeStatement , expression optional, semicolon , expression optional, rightParent , codeStatement
]

{ #category : #grammar }
DASLGrammar >> function [
	^ functionPrototype , leftCBracket , pragmas, codeBody  , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> functionArgumentDecl [
	^ identifier , colon , type
]

{ #category : #grammar }
DASLGrammar >> functionArgumentsDecl [
	^ functionArgumentDecl, (comma, functionArgumentDecl) star
]

{ #category : #grammar }
DASLGrammar >> functionPrototype [
	^ kwFunction , identifier , leftParent , functionArgumentsDecl optional , rightParent , arrow , functionReturnTypes
]

{ #category : #grammar }
DASLGrammar >> functionReturnTypes [
	^ type , (comma , type) star
]

{ #category : #grammar }
DASLGrammar >> globalBlock [
	^ import / shaderSignature / interface / constantGlobal / sharedGlobal / uniformGlobal / struct / uniform / buffer / semantic / codeBlock / function
]

{ #category : #tokens }
DASLGrammar >> identStart [
	^ #letter asParser / $_ asParser
]

{ #category : #tokens }
DASLGrammar >> identifier [
	^ ((identStart , (identStart / #digit asParser) star) token trim: ignorable) >=> [ :context :aBlock |
		| parseResult |
		
		parseResult := aBlock value.
		parseResult isPetitFailure ifFalse: [
			(Keywords includes: parseResult inputValue) ifTrue: [
				PPFailure message: 'keyword matched' context: context
			] ifFalse: [
				parseResult
			].
		] ifTrue: [
			parseResult
		]
	]
]

{ #category : #grammar }
DASLGrammar >> ifStatement [
	^ kwIf , leftParent , expression , rightParent , codeStatement , (kwElse , codeStatement) optional
]

{ #category : #ignorables }
DASLGrammar >> ignorable [
	^ singleLineComment / multiLineComment / #space asParser
]

{ #category : #grammar }
DASLGrammar >> import [
	^ kwImport , importModuleLocation , semicolon
]

{ #category : #grammar }
DASLGrammar >> importModuleLocation [
	^ identifier , (dot , identifier) star
]

{ #category : #grammar }
DASLGrammar >> inOutVariable [
	^ varFlowDirection , identifier , optionalType , varInitialValue optional, semicolon
]

{ #category : #grammar }
DASLGrammar >> initializationLiteral [
	^ literalExpression / blockInitializationLiteral
]

{ #category : #tokens }
DASLGrammar >> integer [
	^ (numberSign optional , #digit asParser plus , #letter asParser star) token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> interface [
	^ kwInterface , identifier , interfaceImplementations optional , leftCBracket, interfaceBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> interfaceBody [
	^ blockVariable star
]

{ #category : #grammar }
DASLGrammar >> interfaceImplementations [
	^ kwImplements , identifier , (comma , identifier) star
]

{ #category : #grammar }
DASLGrammar >> keywordElement [
	^ identifier , colon , expression
]

{ #category : #tokens }
DASLGrammar >> keywordEnd [
	^ (identStart / #digit asParser ) not
]

{ #category : #grammar }
DASLGrammar >> keywordList [
	^ keywordElement plus
]

{ #category : #keywords }
DASLGrammar >> keywordParser: aKeyword [
	^ (aKeyword asParser , keywordEnd) token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwAlignOf [
	^ self keywordParser: 'alignof'
]

{ #category : #keywords }
DASLGrammar >> kwBreak [
	^ self keywordParser: 'break'
]

{ #category : #keywords }
DASLGrammar >> kwBuffer [
	^ self keywordParser: 'buffer'
]

{ #category : #keywords }
DASLGrammar >> kwCase [
	^ self keywordParser: 'case'
]

{ #category : #keywords }
DASLGrammar >> kwCodeBlock [
	^ self keywordParser: 'code_block'
]

{ #category : #keywords }
DASLGrammar >> kwConstant [
	^ self keywordParser: 'constant'
]

{ #category : #keywords }
DASLGrammar >> kwContinue [
	^ self keywordParser: 'continue'
]

{ #category : #keywords }
DASLGrammar >> kwDescriptorSet [
	^ self keywordParser: 'descriptor_set'
]

{ #category : #keywords }
DASLGrammar >> kwDiscard [
	^ self keywordParser: 'discard'
]

{ #category : #keywords }
DASLGrammar >> kwDo [
	^ self keywordParser: 'do'
]

{ #category : #keywords }
DASLGrammar >> kwElse [
	^ self keywordParser: 'else'
]

{ #category : #keywords }
DASLGrammar >> kwFalse [
	^ self keywordParser: 'false'
]

{ #category : #keywords }
DASLGrammar >> kwFor [
	^ self keywordParser: 'for'
]

{ #category : #keywords }
DASLGrammar >> kwFunction [
	^ self keywordParser: 'function'
]

{ #category : #keywords }
DASLGrammar >> kwGraphBlock [
	^ self keywordParser: 'graph_block'
]

{ #category : #keywords }
DASLGrammar >> kwIf [
	^ self keywordParser: 'if'
]

{ #category : #keywords }
DASLGrammar >> kwImplements [
	^ self keywordParser: 'implements'
]

{ #category : #keywords }
DASLGrammar >> kwImport [
	^ self keywordParser: 'import'
]

{ #category : #keywords }
DASLGrammar >> kwIn [
	^ self keywordParser: 'in'
]

{ #category : #keywords }
DASLGrammar >> kwInterface [
	^ self keywordParser: 'interface'
]

{ #category : #keywords }
DASLGrammar >> kwLet [
	^ self keywordParser: 'let'
]

{ #category : #keywords }
DASLGrammar >> kwOut [
	^ self keywordParser: 'out'
]

{ #category : #keywords }
DASLGrammar >> kwPushConstant [
	^ self keywordParser: 'push_constant'
]

{ #category : #keywords }
DASLGrammar >> kwReturn [
	^ self keywordParser: 'return'
]

{ #category : #keywords }
DASLGrammar >> kwSemantic [
	^ self keywordParser: 'semantic'
]

{ #category : #keywords }
DASLGrammar >> kwShaderSignature [
	^ self keywordParser: 'shader_signature'
]

{ #category : #keywords }
DASLGrammar >> kwShared [
	^ self keywordParser: 'shared'
]

{ #category : #keywords }
DASLGrammar >> kwSizeOf [
	^ self keywordParser: 'sizeof'
]

{ #category : #keywords }
DASLGrammar >> kwStorage [
	^ self keywordParser: 'storage'
]

{ #category : #keywords }
DASLGrammar >> kwStruct [
	^ self keywordParser: 'struct'
]

{ #category : #keywords }
DASLGrammar >> kwSwitch [
	^ self keywordParser: 'switch'
]

{ #category : #keywords }
DASLGrammar >> kwTrue [
	^ self keywordParser: 'true'
]

{ #category : #keywords }
DASLGrammar >> kwUniform [
	^ self keywordParser: 'uniform'
]

{ #category : #keywords }
DASLGrammar >> kwUsing [
	^ self keywordParser: 'using'
]

{ #category : #keywords }
DASLGrammar >> kwWhile [
	^ self keywordParser: 'while'
]

{ #category : #grammar }
DASLGrammar >> leftArrow [
	^ '<==' asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftBracket [
	^ $[ asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftCBracket [
	^ ${ asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftParent [
	^ $( asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> literalExpression [
	^ number / boolean
]

{ #category : #grammar }
DASLGrammar >> localVariable [
	^ kwLet , identifier , optionalType , varInitialValue optional, semicolon
]

{ #category : #grammar }
DASLGrammar >> memberExpression [
	^ dot , identifier
]

{ #category : #ignorables }
DASLGrammar >> multiLineComment [
	^ '/*' asParser ,
		( ($* asParser negate) /
			($* asParser , $/ asParser negate)
		) star ,
	'*/' asParser
]

{ #category : #tokens }
DASLGrammar >> multiply [
	^ $* asParser token trim: ignorable
]

{ #category : #ignorables }
DASLGrammar >> newline [
	^ String crlf asParser / String cr asParser / String lf asParser
]

{ #category : #grammar }
DASLGrammar >> nullaryExpression [
	^ literalExpression / identifier / parentExpression 
]

{ #category : #grammar }
DASLGrammar >> number [
	^ float / integer
]

{ #category : #tokens }
DASLGrammar >> numberSign [
	^ $+ asParser / $- asParser
]

{ #category : #grammar }
DASLGrammar >> operate: left with: right do: operation [
	^ { operation . left . right }
]

{ #category : #tokens }
DASLGrammar >> operator: operatorValue [
	^ operatorValue asParser token trim: ignorable
]

{ #category : #accessing }
DASLGrammar >> optionalType [
	^ (colon , type) optional
]

{ #category : #grammar }
DASLGrammar >> parentExpression [
	^ leftParent , expression , rightParent 
]

{ #category : #grammar }
DASLGrammar >> postfix: operation operate: operand [
	^ { operation . operand }
]

{ #category : #grammar }
DASLGrammar >> pragma [
	^ leftBracket, leftBracket, identifier , rightBracket , rightBracket
]

{ #category : #grammar }
DASLGrammar >> pragmas [
	^ pragma star
]

{ #category : #grammar }
DASLGrammar >> prefix: operation operate: operand [
	^ { operation . operand }
]

{ #category : #grammar }
DASLGrammar >> pushConstantSignature [
	^ kwPushConstant , blockAttributes optional , identifier , (multiply , integer) optional, semicolon
]

{ #category : #tokens }
DASLGrammar >> questionMark [
	^ $? asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> returnStatement [
	^ kwReturn , callArguments optional , semicolon
]

{ #category : #tokens }
DASLGrammar >> rightBracket [
	^ $] asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> rightCBracket [
	^ $} asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> rightParent [
	^ $) asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> semantic [
	^ kwSemantic , identifier , interfaceImplementations optional , leftCBracket, semanticBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> semanticBody [
	^ blockVariable star
]

{ #category : #tokens }
DASLGrammar >> semicolon [
	^ $; asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> shaderSignature [
	^ kwShaderSignature , identifier , leftCBracket , shaderSignatureElement star , rightCBracket 
]

{ #category : #grammar }
DASLGrammar >> shaderSignatureElement [
	^ descriptorSet / pushConstantSignature
]

{ #category : #grammar }
DASLGrammar >> shaderSignatureElementKeywordType [
	^ kwBuffer / kwUniform
]

{ #category : #grammar }
DASLGrammar >> shaderSignatureElementType [
	^ shaderSignatureElementKeywordType  / identifier
]

{ #category : #grammar }
DASLGrammar >> sharedGlobal [
	^ kwShared , identifier , colon , type, semicolon
]

{ #category : #ignorables }
DASLGrammar >> singleLineComment [
	^ '//' asParser, newline negate star, newline
]

{ #category : #grammar }
DASLGrammar >> start [
	^ globalBlock star end
]

{ #category : #grammar }
DASLGrammar >> struct [
	^ kwStruct , blockAttributes optional , identifier , interfaceImplementations optional, leftCBracket, structBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> structBody [
	^ blockVariable star
]

{ #category : #grammar }
DASLGrammar >> subscriptExpression [
	^ leftBracket , expression , rightBracket
]

{ #category : #grammar }
DASLGrammar >> switchCase [
	^ kwCase , expression, colon, codeStatement star
]

{ #category : #grammar }
DASLGrammar >> switchCases [
	^ switchCase star
]

{ #category : #grammar }
DASLGrammar >> switchStatement [
	^ kwSwitch , leftParent , expression , rightParent , leftCBracket , switchCases , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> termExpression [
	^ nullaryExpression , accessExpression star
]

{ #category : #grammar }
DASLGrammar >> trueLiteral [
	^ kwTrue
]

{ #category : #grammar }
DASLGrammar >> type [
	^ identifier , memberExpression star , typeArraySubscript star
]

{ #category : #grammar }
DASLGrammar >> typeArraySubscript [
	^ leftBracket , integer optional , rightBracket
]

{ #category : #grammar }
DASLGrammar >> unaryExpression [
	^ termExpression
]

{ #category : #grammar }
DASLGrammar >> uniform [
	^ kwUniform , blockAttributes optional , identifier , interfaceImplementations optional, leftCBracket, uniformBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> uniformBody [
	^ blockVariable star
]

{ #category : #grammar }
DASLGrammar >> uniformGlobal [
	^ kwUniform , blockAttributes optional , identifier , colon , type, semicolon
]

{ #category : #grammar }
DASLGrammar >> usingAliasStatement [
	^ kwUsing , identifier , equalAssign , expression , semicolon
]

{ #category : #grammar }
DASLGrammar >> usingExpressionStatement [
	^ kwUsing , expression , semicolon
]

{ #category : #grammar }
DASLGrammar >> usingStatement [
	^ usingAliasStatement / usingExpressionStatement
]

{ #category : #grammar }
DASLGrammar >> varFlowDirection [
	^ kwIn / kwOut , varFlowLocation optional
]

{ #category : #grammar }
DASLGrammar >> varFlowLocation [
	^ leftParent , integer , rightParent
]

{ #category : #grammar }
DASLGrammar >> varInitialValue [
	^ equalAssign , expression
]

{ #category : #grammar }
DASLGrammar >> whileStatement [
	^ kwWhile , leftParent , expression , rightParent , codeStatement
]
