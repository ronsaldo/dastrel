"
I am a syntax highlighter for Dastrel source code.
"
Class {
	#name : #DASLSyntaxHighlighter,
	#superclass : #DASLGrammar,
	#instVars : [
		'commands'
	],
	#category : #'Dastrel-Phanide'
}

{ #category : #accessing }
DASLSyntaxHighlighter class >> ignoredNames [
	^ super ignoredNames, #(commands)
]

{ #category : #keywords }
DASLSyntaxHighlighter >> arrow [
	^ super arrow ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle keyword token: token)
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> assignmentOperator [
	^ super assignmentOperator ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle operator token: token).
		token
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> attributeKeyAndValue [
	^ super attributeKeyAndValue ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle annotation token: tokens first).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> blockVariable [
	^ super blockVariable ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle field token: tokens second)
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> buffer [
	^ super buffer ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens third).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> callExpression [
	^ super callExpression ==> [ :tokens |
		self commands
			add: (PhanideHighlightCommandStyle callBracket token: tokens first);
			add: (PhanideHighlightCommandStyle callBracket token: tokens last)
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> codeBlock [
	^ super codeBlock ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle method token: tokens third).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> colon [
	^ super colon ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle operator token: token)
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> commands [ 
	^ commands ifNil: [ commands := OrderedCollection new ]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> descriptorSet [
	^ super descriptorSet ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens third).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> descriptorSetElement [
	^ super descriptorSetElement ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle field token: token first).
		token
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> equalAssign [
	^ super assignmentOperator ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle operator token: token).
		token
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> float [
	^ super float ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle number token: token)
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> functionArgumentDecl [
	^ super functionArgumentDecl ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle parameterVariable token: tokens first).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> functionPrototype [
	^ super functionPrototype ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle method token: tokens second).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> identifier [
	^ super identifier ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle identifier token: token).
		token
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> integer [
	^ super integer ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle number token: token)
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> keywordElement [
	^ super keywordElement ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle methodHeaderSelector firstToken: tokens first lastToken: tokens second).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> keywordParser: aKeyword [
	^ (super keywordParser: aKeyword) ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle keyword token: token)
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> leftArrow [
	^ super leftArrow ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle methodHeaderSelector token: token)
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> localVariable [
	^ super localVariable ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle localDefinition token: tokens second).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> memberExpression [
	^ super memberExpression ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle field firstToken: tokens first lastToken: tokens second).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> multiLineComment [
	^ super multiLineComment token ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle commentStyle token: token).
		token
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> multiply [
	^ super multiply ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle operator token: token).
		token
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> operator: operatorValue [
	^ (super operator: operatorValue) ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle operator token: token).
		token
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> pushConstantSignature [
	^ super pushConstantSignature ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens third).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> semantic [
	^ super semantic ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens second).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> shaderSignature [
	^ super shaderSignature ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens second).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> singleLineComment [
	^ super singleLineComment token ==> [ :token |
		self commands add: (PhanideHighlightCommandStyle commentStyle token: token).
		token
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> struct [
	^ super struct ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens third).
		tokens
	]
]

{ #category : #keywords }
DASLSyntaxHighlighter >> type [
	^ super type ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle typeExpression token: tokens first).
		tokens
	]
]

{ #category : #accessing }
DASLSyntaxHighlighter >> uniform [
	^ super uniform ==> [ :tokens |
		self commands add: (PhanideHighlightCommandStyle classStyle token: tokens third).
		tokens
	]
]
