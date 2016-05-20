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
		'globalBlocks',
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
		'asignmentExpression',
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
		'attributeKeyAndValues'
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
	
	Keywords := #(
		in out inout
		uniform
		interface semantic implements
		sizeof alignof
		function code_block graph_block
		using discard return
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

{ #category : #grammar }
DASLGrammar >> asignmentExpression [
	^ conditionalExpression , (assignmentOperator , asignmentExpression) optional
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
	^ identifier , (equalAssign , literalExpression) optional
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
			g postfix: ('++' asParser token trim: ignorable) do: postfixOpDo.
			g postfix: ('--' asParser token trim: ignorable) do: postfixOpDo.
			];
		group: [ :g |
			g prefix: ('++' asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ('--' asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($+ asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($- asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($! asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($~ asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($* asParser token trim: ignorable) do: prefixOpDo.
			g prefix: ($& asParser token trim: ignorable) do: prefixOpDo.
			g prefix: kwSizeOf do: prefixOpDo.
			g prefix: kwAlignOf do: prefixOpDo.
			];
		group: [ :g |
			g left: ($* asParser token trim: ignorable) do: binOpDo. 
			g left: ($/ asParser token trim: ignorable) do: binOpDo. 
			g left: ($% asParser token trim: ignorable) do: binOpDo.];
		group: [ :g |
			g left: ($+ asParser token trim: ignorable) do: binOpDo.
			g left: ($- asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ('<<' asParser token trim: ignorable) do: binOpDo.
			g left: ('>>' asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ($< asParser token trim: ignorable) do: binOpDo.
			g left: ($> asParser token trim: ignorable) do: binOpDo.
			g left: ('<=' asParser token trim: ignorable) do: binOpDo.
			g left: ('>=' asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ('==' asParser token trim: ignorable) do: binOpDo.
			g left: ('!=' asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ($& asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ($^ asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ($| asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ('&&' asParser token trim: ignorable) do: binOpDo. ];
		group: [ :g |
			g left: ('||' asParser token trim: ignorable) do: binOpDo. ].
	^ binExpr
]

{ #category : #grammar }
DASLGrammar >> blockAttributes [
	^ leftParent , attributeKeyAndValues , rightParent
]

{ #category : #grammar }
DASLGrammar >> blockVariable [
	^ varFlowDirection optional , type , identifier , semicolon
]

{ #category : #grammar }
DASLGrammar >> callArguments [
	^ expression , (comma , expression) star
]

{ #category : #grammar }
DASLGrammar >> callExpression [
	^ leftParent , callArguments , rightParent
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
	^ usingStatement / discardStatement / returnStatement / localVariable / expressionStatement
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
DASLGrammar >> discardStatement [
	^ kwDiscard , semicolon
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
	^ asignmentExpression
]

{ #category : #grammar }
DASLGrammar >> expressionStatement [
	^ expression , semicolon
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
DASLGrammar >> function [
	^ functionPrototype , leftCBracket , codeBody  , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> functionArgumentDecl [
	^ type , identifier
]

{ #category : #grammar }
DASLGrammar >> functionArgumentsDecl [
	^ functionArgumentDecl, (comma, functionArgumentDecl) star
]

{ #category : #grammar }
DASLGrammar >> functionPrototype [
	^ kwFunction , identifier , leftParent , functionArgumentsDecl , rightParent , arrow , functionReturnTypes
]

{ #category : #grammar }
DASLGrammar >> functionReturnTypes [
	^ type , (comma , type) star
]

{ #category : #grammar }
DASLGrammar >> globalBlocks [
	^ interface / uniform / semantic / codeBlock / function
]

{ #category : #tokens }
DASLGrammar >> identStart [
	^ #letter asParser / $_ asParser
]

{ #category : #tokens }
DASLGrammar >> identifier [
	^ (identStart , (identStart / #digit asParser) star) token trim: ignorable.
]

{ #category : #ignorables }
DASLGrammar >> ignorable [
	^ singleLineComment / #space asParser
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

{ #category : #tokens }
DASLGrammar >> keywordEnd [
	^ (identStart / #digit asParser ) not
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
DASLGrammar >> kwCodeBlock [
	^ self keywordParser: 'code_block'
]

{ #category : #keywords }
DASLGrammar >> kwDiscard [
	^ self keywordParser: 'discard'
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
DASLGrammar >> kwImplements [
	^ self keywordParser: 'implements'
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
DASLGrammar >> kwOut [
	^ self keywordParser: 'out'
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
DASLGrammar >> kwSizeOf [
	^ self keywordParser: 'sizeof'
]

{ #category : #keywords }
DASLGrammar >> kwUniform [
	^ self keywordParser: 'uniform'
]

{ #category : #keywords }
DASLGrammar >> kwUsing [
	^ self keywordParser: 'using'
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
	^ number
]

{ #category : #grammar }
DASLGrammar >> localVariable [
	^ varFlowDirection optional , type , identifier , varInitialValue optional, semicolon
]

{ #category : #grammar }
DASLGrammar >> memberExpression [
	^ dot , identifier
]

{ #category : #ignorables }
DASLGrammar >> multiLineComment [
	^ '/*' asParser , '*/' asParser negate star , '*/' asParser
]

{ #category : #ignorables }
DASLGrammar >> newline [
	^ String crlf asParser / String cr asParser / String lf asParser
]

{ #category : #grammar }
DASLGrammar >> nullaryExpression [
	^ identifier / literalExpression / parentExpression 
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

{ #category : #grammar }
DASLGrammar >> parentExpression [
	^ leftParent , expression , rightParent 
]

{ #category : #grammar }
DASLGrammar >> postfix: operation operate: operand [
	^ { operation . operand }
]

{ #category : #grammar }
DASLGrammar >> prefix: operation operate: operand [
	^ { operation . operand }
]

{ #category : #tokens }
DASLGrammar >> questionMark [
	^ $? asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> returnStatement [
	^ kwReturn , callArguments , semicolon
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

{ #category : #ignorables }
DASLGrammar >> singleLineComment [
	^ '//' asParser, newline negate star, newline
]

{ #category : #grammar }
DASLGrammar >> start [
	^ globalBlocks star end
]

{ #category : #grammar }
DASLGrammar >> subscriptExpression [
	^ leftBracket , expression , rightBracket
]

{ #category : #grammar }
DASLGrammar >> termExpression [
	^ nullaryExpression , accessExpression star
]

{ #category : #grammar }
DASLGrammar >> type [
	^ identifier
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
DASLGrammar >> usingAliasStatement [
	^ kwUsing , identifier , assignmentOperator , expression , semicolon
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
