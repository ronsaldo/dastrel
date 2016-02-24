Class {
	#name : #DASLParser,
	#superclass : #DASLGrammar,
	#category : #'Dastrel-Core'
}

{ #category : #grammar }
DASLParser >> asignmentExpression [
	^ super asignmentExpression ==> [ :expr | expr second ifNil: [ expr first ] ifNotNil: [ 
				DASLAssignmentExpression new
					setPositionFromToken: expr second first;
					operation: expr second first inputValue asSymbol;
					reference: expr first;
					value: expr second second;
					yourself
			]  
		]
]

{ #category : #grammar }
DASLParser >> blockVariable [
	^ super blockVariable ==> [:var | DASLFieldDefinition new
			position: var second position;
			flow: var first;
			type: var second;
			name: var third value;
			yourself]
]

{ #category : #grammar }
DASLParser >> codeBlock [
	^ super codeBlock ==> [ :block | DASLCodeBlock new
			setPositionFromToken: block first;
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> conditionalExpression [
	^ super conditionalExpression ==> [ :expr | expr second ifNil: [ expr first ] ifNotNil: [ 
				DASLConditionalExpression new
				setPositionFromToken: expr second first;
				condition: expr first;
				trueValue: expr second second;
				falseValue: expr second fourth;
				yourself
			] ]
]

{ #category : #grammar }
DASLParser >> discardStatement [
	^ super discardStatement ==> [ :tokens | DASLDiscardStatement new
			setPositionFromToken: tokens first;
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
	^ super float ==> [ :token | DASLFloat token: token ]
]

{ #category : #tokens }
DASLParser >> identifier [
	^ super identifier ==> [ :token | DASLIdentifier token: token ]
]

{ #category : #tokens }
DASLParser >> integer [
	^ super integer ==> [ :token | DASLInteger token: token ]
]

{ #category : #grammar }
DASLParser >> interface [
	^ super interface ==> [ :iface | DASLInterface new
			setPositionFromToken: iface first;
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
DASLParser >> memberExpression [
	^ super memberExpression ==> [ :expr | DASLMemberAccessExpression new
			setPositionFromToken: expr first;
			memberName: expr second value;
			yourself ]
]

{ #category : #grammar }
DASLParser >> operate: left with: right do: operation [
	^ DASLBinaryOperation new
		setPositionFromToken: operation;
		operation: operation inputValue asSymbol;
		left: left;
		right: right;
		yourself
		
]

{ #category : #grammar }
DASLParser >> postfix: operation operate: operand [
	^ DASLPostfixUnaryOperation new
		setPositionFromToken: operation;
		operation: operation inputValue asSymbol;
		operand: operand;
		yourself
]

{ #category : #grammar }
DASLParser >> prefix: operation operate: operand [
	^ DASLPrefixUnaryOperation new
		setPositionFromToken: operation;
		operation: operation inputValue asSymbol;
		operand: operand;
		yourself
]

{ #category : #grammar }
DASLParser >> semantic [
	^ super semantic ==> [ :block | DASLSemanticBlock new
			setPositionFromToken: block first;
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> subscriptExpression [
	^ super memberExpression ==> [ :expr | DASLSubscriptExpression new
			setPositionFromToken: expr first;
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
DASLParser >> uniform [
	^ super uniform ==> [ :block | DASLUniformBlock new
			setPositionFromToken: block first;
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> usingStatement [
	^ super usingStatement ==> [ :tokens | DASLUsingStatement new
			setPositionFromToken: tokens first;
			identifier: tokens second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowDirection [
	^ super varFlowDirection ==> [ :flow | DASLConnectionFlowType new
			setPositionFromToken: flow first;
			direction: flow first inputValue asSymbol;
			location: flow second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowLocation [
	^ super varFlowLocation ==> [ :location | location second value ]
]
