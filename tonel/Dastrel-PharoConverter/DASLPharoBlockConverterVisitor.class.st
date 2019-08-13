Class {
	#name : #DASLPharoBlockConverterVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'context',
		'currentScope',
		'typeAnnotations',
		'codeConverter'
	],
	#classVars : [
		'MessageMaps',
		'OptimizedMessages',
		'SpecialOperators'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> arithmetic [
	<messageMaps>
	self
		mapVectorScalarMessage: #+ toBinaryOperator: #+;
		mapVectorScalarMessage: #- toBinaryOperator: #-;
		mapVectorScalarMessage: #* toBinaryOperator: #*;
		mapVectorScalarMessage: #/ toBinaryOperator: #/;
		
		mapMessage: #= toBinaryOperator: #== returnType: #bool;
		mapMessage: #== toBinaryOperator: #== returnType: #bool;
		mapMessage: #~= toBinaryOperator: #!= returnType: #bool;
		mapMessage: #~~ toBinaryOperator: #!= returnType: #bool;
		mapMessage: #< toBinaryOperator: #< returnType: #bool;
		mapMessage: #<= toBinaryOperator: #<= returnType: #bool;
		mapMessage: #> toBinaryOperator: #> returnType: #bool;
		mapMessage: #>= toBinaryOperator: #>= returnType: #bool;
		yourself

]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> commonMath [
	<messageMaps>
	self
		mapVectorMessage: #sqrt toFunction: #sqrt;
		mapVectorMessage: #exp toFunction: #exp;
		mapVectorMessage: #cos toFunction: #cos;
		mapVectorMessage: #sin toFunction: #sin;
		mapVectorMessage: #tan toFunction: #tan;
		mapVectorMessage: #abs toFunction: #fabs;
		mapVectorMessage: #raisedTo: toFunction: #pow;

		mapVectorMessage: #floor toFunction: #floor;
		mapVectorMessage: #floorFract toFunction: #fract;
		mapVectorMessage: #ceil toFunction: #ceil;
		mapVectorMessage: #min: toFunction: #min;
		mapVectorMessage: #max: toFunction: #max;
		mapVectorMessage: #interpolateTo:at: toFunction: #mix;
		mapVectorMessage: #stepEdge: toFunction: #step arguments: #(2 1);
		mapVectorMessage: #smoothStepFrom:to: toFunction: #smoothstep arguments: #(2 3 1);

		mapVectorMessage: #normalized toFunction: #normalize;
		mapMessage: #dot: toFunction: #dot returnType: #float;
		mapMessage: #cross: toFunction: #cross returnType: #float3;

		mapMessage: #radius toFunction: #vector2Radius returnType: #float;
		mapMessage: #theta toFunction: #vector2Angle returnType: #float;

		yourself

]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> initialize [
	"OCASTTranslator initialize"
	
	super initialize.
	
	OptimizedMessages := { 
	#ifFalse: -> #emitIfFalse: .
	#ifFalse:ifTrue: -> #emitIfFalseIfTrue: .
	#ifNil: -> #emitIfNil: .
	#ifNil:ifNotNil: -> #emitIfNilIfNotNil: .
	#ifNotNil: -> #emitIfNotNil: .
	#ifNotNil:ifNil: -> #emitIfNotNilIfNil: .
	#ifTrue: -> #emitIfTrue: .
	#ifTrue:ifFalse: -> #emitIfTrueIfFalse: .
	#or: -> #emitOr: .
	#and: -> #emitAnd: .
	#timesRepeat: -> #emitTimesRepeat: .
	#repeat -> #emitRepeat: .
	#to:by:do: -> #emitToByDo: .
	#to:do: -> #emitToDo: .
	#whileFalse: -> #emitWhileFalse: .
	#whileTrue: -> #emitWhileTrue: .
	#whileFalse -> #emitWhileFalse: .
	#whileTrue -> #emitWhileTrue:
	 } asDictionary.
	
	SpecialOperators := { 
		#@ -> #emitConstructVector: .
	} asDictionary.
	
	self initializeMessageMaps.
	
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> initializeMessageMaps [
	MessageMaps := Dictionary new.
	self class methodDict valuesDo: [ :method |
		(method hasPragmaNamed: #messageMaps) ifTrue: [
			self perform: method selector
		]
	]
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapMessage: selector toBinaryOperator: operatorName returnType: returnType [
	MessageMaps at: selector
		put: (DASLPharoBlockConverterMessageBinaryOperatorMap new
			selector: selector;
			operatorName: operatorName;
			returnType: returnType;
			yourself)
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapMessage: selector toFunction: functionName arguments: arguments returnType: returnType [
	MessageMaps at: selector
		put: (DASLPharoBlockConverterMessageFunctionMap new
			selector: selector;
			functionName: functionName;
			swizzleIndices: arguments;
			returnType: returnType;
			yourself)
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapMessage: selector toFunction: functionName returnType: returnType [
	MessageMaps at: selector
		put: (DASLPharoBlockConverterMessageFunctionMap new
			selector: selector;
			functionName: functionName;
			returnType: returnType;
			yourself)
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapVectorMessage: selector toBinaryOperator: functionName [
	^ self mapMessage: selector toBinaryOperator: functionName returnType: self vectorFunctionTypeInference
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapVectorMessage: selector toFunction: functionName [
	^ self mapMessage: selector toFunction: functionName returnType: self vectorFunctionTypeInference
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapVectorMessage: selector toFunction: functionName arguments: arguments [
	^ self mapMessage: selector toFunction: functionName arguments: arguments returnType: self vectorFunctionTypeInference
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> mapVectorScalarMessage: selector toBinaryOperator: functionName [
	^ self mapMessage: selector toBinaryOperator: functionName returnType: self vectorScalarFunctionTypeInference
]

{ #category : #notifications }
DASLPharoBlockConverterVisitor class >> noteCompilationOf: aSelector meta: isMeta [
	isMeta ifTrue: [
		self class methodDict at: aSelector ifPresent: [:cm |
			(cm hasPragmaNamed: #messageMaps) ifTrue: [
				self initializeMessageMaps
			]
		]
	]
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> vectorFunctionTypeInference [
	^ [ :arguments :position |
		| expectedArgumentType |
		expectedArgumentType := arguments first.
		arguments do: [ :arg |
			(arg ~~ expectedArgumentType and: [ (expectedArgumentType isVectorType and: [arg == expectedArgumentType baseType]) not ]) ifTrue: [
				self halt.
			]
		].
	
		expectedArgumentType
	]
]

{ #category : #'class initialization' }
DASLPharoBlockConverterVisitor class >> vectorScalarFunctionTypeInference [
	| expectedArgumentType |
	^ [ :arguments :position |
		| scalarType vectorType |
		arguments do: [ :arg |
			arg isPrimitiveType ifTrue: [ 
				scalarType := arg
			] ifFalse: [ 
				arg isVectorType ifTrue: [
					vectorType := arg
				] ifFalse: [
					(arg ~~ expectedArgumentType and: [ (expectedArgumentType isVectorType and: [arg == expectedArgumentType baseType]) not ]) ifTrue: [
				self halt.
			]
				]
			]
		].
	
		vectorType ifNil: [ scalarType ]
	]
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> annotateNode: node withType: aType [
	aType ifNotNil: [
		typeAnnotations at: node put: (self evaluateType: aType)
	].

	^ node
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> annotatedNodeType: aNode [
	^ typeAnnotations at: aNode ifAbsent: [nil]
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> codeConverter [
	^ codeConverter
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> codeConverter: anObject [
	codeConverter := anObject
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> context [
	^ context
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> context: anObject [
	context := anObject
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> convertArgument: argument withIndex: index [
	| position |
	position := self convertNodePosition: argument.
	
	currentScope addSymbol: (
		DASLPharoBlockConverterArgumentVariable new
			position: position;
			name: argument name;
			type: (context argumentTypes at: index);
			yourself
	).
	
	^ DASLFunctionArgument new
		position: position;
		name: argument name;
		type: (context argumentTypeNodes at: index);
		yourself
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> convertArguments: arguments [
	^ arguments collectWithIndex: [ :arg :index | self convertArgument: arg withIndex: index ]
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> convertBlock: aBlockNode [
	| prototype capturedScope functionScope |
	self assert: aBlockNode isBlock.

	capturedScope := DASLPharoBlockConverterCapturedScope new.
	context capturedVariables do: [ :var |
		capturedScope addSymbol: var
	].
	
	functionScope := DASLPharoBlockConverterFunctionScope parent: capturedScope.
	self withScope: functionScope do: [ 
		aBlockNode arguments size ~= context argumentTypes size ifTrue: [
			self error: 'expected a block with {1} arguments.' format: {context argumentTypes size} at: aBlockNode
		].
	
		prototype := DASLFunctionPrototype new
			name: context functionName;
			arguments: (self convertArguments: aBlockNode arguments);
			returnType: context returnType;
			yourself.
		^ DASLFunction new
			name: context functionName;
			prototype: prototype;
			pragmas: #();
			body: {self convertFunctionBlockBody: aBlockNode body};
			yourself
	].

]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> convertFunctionBlockBody: blockBody [
	| sequence resultExpression returnStatement |
	sequence := self visitNode: blockBody.
	sequence statements ifNotEmpty: [ 
		sequence statements last isExpressionStatement ifTrue: [
			resultExpression := sequence statements last expression.
			returnStatement := DASLReturnStatement new
				position: resultExpression position;
				value: resultExpression;
				yourself.
				
			sequence statements: sequence statements allButLast , { returnStatement }
		].
	].

	^ sequence
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> convertNodePosition: aNode [
	^ aNode asDASLCodePositionWithCollection: context sourceCollection
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> convertTermporaryNode: temporaryNode [
	(currentScope lookSymbol: temporaryNode name) ifNotNil: [
		self error: 'Temporary name {1} is already used.' format: {temporaryNode name} at: temporaryNode
	].

	currentScope addSymbol: (DASLPharoBlockConverterTemporaryVariable new
		position: (self convertNodePosition: temporaryNode);
		name: temporaryNode name;
		yourself)
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> emitConstructVector: vectorNode [
	| firstPart secondPart firstPartType secondPartType firstBaseTypeAndSize secondBaseTypeAndSize vectorBase vectorSize constructionPosition resultTypeName |
	self assert: vectorNode arguments size = 1.
	firstPart := self visitNode: vectorNode receiver.
	secondPart := self visitNode: vectorNode arguments first.
	
	firstPartType := self annotatedNodeType: firstPart.
	secondPartType := self annotatedNodeType: secondPart.
	
	(firstPartType isType and: [ secondPartType isType ]) ifFalse: [
		self error: 'Cannot infer proper vector type to create.' at: vectorNode
	].
	
	firstBaseTypeAndSize := self extractVectorBaseAndSize: firstPartType at: vectorNode receiver.
	secondBaseTypeAndSize := self extractVectorBaseAndSize: secondPartType at: vectorNode arguments first.
	
	firstBaseTypeAndSize first ~~ secondBaseTypeAndSize first ifTrue: [ 
		self error: 'Cannot make vector with values of mixed types.' at: vectorNode
	].

	vectorBase := firstBaseTypeAndSize first.
	vectorSize := firstBaseTypeAndSize second + secondBaseTypeAndSize second.
	constructionPosition := self convertNodePosition: vectorNode.
	resultTypeName := DASLIdentifier new
		position: constructionPosition;
		value: (vectorBase name , vectorSize asString) asSymbol;
		yourself.
	
	^ self annotateNode: (DASLCallExpression new
		position: constructionPosition;
		reference: resultTypeName;
		arguments: { firstPart . secondPart };
		yourself) withType: resultTypeName
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> emitIfTrue: messageNode [
	| condition trueBranch |
	condition := self visitNode: messageNode receiver.
	trueBranch := self inlineBlock: messageNode arguments first withArguments: #().
	^ DASLIfStatement new
		position: (self convertNodePosition: messageNode);
		condition: condition;
		thenStatement: trueBranch;
		yourself
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> emitMessage: messageNode [
	| receiver receiverType |
	MessageMaps at: messageNode selector ifPresent: [ :map |
		^ self emitMessage: messageNode withMap: map
	].

	receiver := self visitNode: messageNode receiver.
	receiverType := self annotatedNodeType: receiver.
	receiverType isReferenceType ifTrue: [ receiverType := receiverType baseType ].
	^ receiverType emitPharoToDastrelMessage: messageNode receiver: receiver with: self
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> emitMessage: messageNode withMap: map [
	| receiver arguments allArguments |
	receiver := self visitNode: messageNode receiver.
	arguments := messageNode arguments collect: [ :arg | self visitNode: arg ].
	allArguments := {receiver} , arguments.
	^ map mapNode: messageNode withArguments: allArguments with: self
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> evaluateType: aType [
	| valueType |
	aType isSymbol ifTrue: [
		^ self evaluateTypeNamed: aType
	].

	aType isType ifTrue: [
		^ aType
	].

	aType isIdentifierReference ifTrue: [
		^ self evaluateTypeNamed: aType value
	].

	aType isArray ifTrue: [ 
		self halt
	].

	^ aType
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> evaluateTypeNamed: typeName [
	DASLType builtInTypes at: typeName ifPresent: [ :found | ^ found ].
	
	^ (Smalltalk globals at: typeName) asDastrelConversionTypeWith: codeConverter
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> extractVectorBaseAndSize: scalarOrVectorType at: aNode [
	scalarOrVectorType isPrimitiveType ifTrue: [
		^ {scalarOrVectorType . 1}
	].

	scalarOrVectorType isVectorType ifTrue: [
		^ {scalarOrVectorType baseType . scalarOrVectorType elements}
	].

	self error: 'Expected a value with a scalar or vector type'.
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> initialize [
	super initialize.
	typeAnnotations := IdentityDictionary new.
	
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> inlineBlock: blockOrValueNode withArguments: arguments [
	blockOrValueNode isBlock ifTrue: [
		self assert: blockOrValueNode arguments size = arguments size.
		blockOrValueNode arguments ifNotEmpty: [ 
			self halt
		].
	
		^ self visitNode: blockOrValueNode body
	].
	^ self visitNode: blockOrValueNode
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitArgumentNode: temporaryNode [
	^ self visitVariableNode: temporaryNode
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitArrayNode: anArrayNode [
	| elements |
	elements := anArrayNode children collect: [ :child | self visitNode: child ].
	^ DASLMakeTupleExpression new
			position: (self convertNodePosition: anArrayNode);
			elements: elements;
			yourself

]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitAssignmentNode: assignment [
	| assignmentValue variable inferredType |
	variable := currentScope lookSymbolRecursively: assignment variable name ifAbsent: [
		self error: 'Cannot find the variable to assign.' at: assignment variable
	].
	variable isTemporaryVariable ifFalse: [
		self error: 'Only assignments to temporary variables are allowed.' at: assignment
	].

	assignmentValue := self visitNode: assignment value.

	variable hasValidInferredType ifFalse: [
		variable type: 	(self annotatedNodeType: assignmentValue).
		variable type ifNil: [
			self halt
		]
	].

	^ DASLAssignmentExpression new
		operation: #=;
		reference: (variable asIdentifierReferenceAt: (self convertNodePosition: assignment variable));
		value: assignmentValue;
		yourself
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitBlockNode: node [
	self error: 'Unsupported closures here.' at: node
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitCascadeNode: aCascadeNode [
	| convertedStatement actions |
	actions := Array streamContents: [:out |
		aCascadeNode messages do: [:each |
			convertedStatement := self visitNode: each.
			convertedStatement isArray ifTrue: [
				out nextPutAll: (convertedStatement collect: #asStatement)
			] ifFalse: [
				out nextPut: convertedStatement asStatement
			]
		]
	].

	^ actions
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitLiteralNode: aLiteralNode [
	| value literalClass literalType |
	value := aLiteralNode value.
	literalClass := nil.
	value isInteger ifTrue: [
		literalClass := DASLInteger.
		literalType := #int.
	].
	value isFloat ifTrue: [ 
		literalClass := DASLFloat.
		literalType := #float.
	].
	(#(true false) includes: value) ifTrue: [ 
		literalClass := DASLBoolean.
		literalType := #bool.
	].

	literalClass ifNil: [
		self error: 'Unsupported literal value {1}.' format: { value printString } at: aLiteralNode
	].

	^ self annotateNode: (literalClass new
		position: (self convertNodePosition: aLiteralNode);
		value: value;
		type: (DASLType builtInTypes at: literalType); 
		yourself
	) withType: literalType
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitMessageNode: aMessageNode [
	(aMessageNode isInlined and: [OptimizedMessages includesKey: aMessageNode selector]) ifTrue: [
		^self 
			perform: (OptimizedMessages at: aMessageNode selector)
			with: aMessageNode
	].

	(SpecialOperators includesKey: aMessageNode selector) ifTrue: [
		^ self
			perform: (SpecialOperators at: aMessageNode selector)
			with: aMessageNode
	].

	^ self emitMessage: aMessageNode
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitSequenceNode: aSequenceNode [
	| convertedStatement actions declarations localsWithType |
	self withScope: (DASLPharoBlockConverterLexicalScope parent: currentScope) do: [ 
		aSequenceNode temporaries do: [ :temp | self convertTermporaryNode: temp ].
		
		actions := Array streamContents: [:out | aSequenceNode statements do: [:statement |
				convertedStatement := self visitNode: statement.
				convertedStatement isArray ifTrue: [
					out nextPutAll: (convertedStatement collect: #asStatement)
				] ifFalse: [
					out nextPut: convertedStatement asStatement
				]
		]].
		localsWithType := currentScope symbols values select: [:local | local type isNotNil ].
		declarations := localsWithType collect: [:local |
			DASLLocalDeclStatement new
				position: local position;
				name: local name;
				type: (DASLIdentifier new
					position: local position;
					value: local type name;
					yourself);
				yourself
		].
		
		^ DASLBlockStatement new
			position: (self convertNodePosition: aSequenceNode);
			statements: declarations , actions;
			yourself
	]

]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitTemporaryNode: temporaryNode [
	^ self visitVariableNode: temporaryNode
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterVisitor >> visitVariableNode: variableNode [
	| symbolDefinition |
	symbolDefinition := currentScope lookSymbolRecursively: variableNode name ifAbsent: [
		Smalltalk globals at: variableNode name ifPresent: [ :value |
			^ self annotateNode: (value asDastrelLiteralAt: (self convertNodePosition: variableNode) inContext: context for: nil)
				withType: (DASLPharoCodeWrapperMetaType new wrappedClass: value class)
		].
		self error: 'Failed to lookup symbol {1}.' format: {variableNode name} at: variableNode
	].

	symbolDefinition hasValidInferredType ifFalse: [ 
		self error: 'Cannot reference variable {1} before its type can be inferred.' format: { variableNode name } at: variableNode
	].

	^ self annotateNode: (symbolDefinition asIdentifierReferenceAt: (self convertNodePosition: variableNode))
		withType: symbolDefinition type
]

{ #category : #accessing }
DASLPharoBlockConverterVisitor >> withScope: newScope do: aBlock [
	| oldScope |
	oldScope := currentScope.
	currentScope := newScope.
	
	^ aBlock ensure: [ currentScope := oldScope ]
]
