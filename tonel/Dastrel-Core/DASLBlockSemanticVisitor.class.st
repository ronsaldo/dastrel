Class {
	#name : #DASLBlockSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#instVars : [
		'currentFunction',
		'samplerBuiltIns'
	],
	#classVars : [
		'SwizzleComponentIndices'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #'as yet unclassified' }
DASLBlockSemanticVisitor class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	SwizzleComponentIndices := Dictionary newFromPairs: #(
		$x 0
		$y 1
		$z 2
		$w 3
		
		$r 0
		$g 1
		$b 2
		$a 3
		
		$s 0
		$t 1
		$p 2
		$q 3
	)
]

{ #category : #'overload lookup' }
DASLBlockSemanticVisitor >> findIn: functionGroup bestMatchingType: checkTypes at: position [
	"Find an exact match first, removing reference types"
	functionGroup alternatives do: [ :alternative |
			(self compareAlmostExactTypes: alternative functionType arguments with: checkTypes) ifTrue: [
			^ alternative
		]
	].

	self halt.
	self error: 'Failed to find suitable function overload for "',  functionGroup ,'".' name at: position.
]

{ #category : #initialization }
DASLBlockSemanticVisitor >> initialize [
	super initialize.
	samplerBuiltIns := DASLBuiltInFunctions builtInSamplerFunctions.

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitAssignment: assignment [
	| referenceType |
	assignment reference accept: self.
	assignment value accept: self.

	referenceType := assignment reference type.
	referenceType isReferenceType ifFalse: [ self error: 'a variable reference is required to perform the assignment.' at: assignment ].
	
	assignment type: referenceType.
	
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitBinaryOperation: operation [
	| functionGroup matchingFunction |
	operation left accept: self.
	operation right accept: self.

	functionGroup := self lookOperationFunctionGroup: operation operation at: operation.
	matchingFunction := self findIn: functionGroup bestMatchingType: { operation left type . operation right type} at: operation.
	operation builtInFunction: matchingFunction.
	operation coercionType: matchingFunction coercionType.
	operation type: matchingFunction functionType returnType
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCallExpression: expression [
	| functionType functionGroup argumentTypes matchingFunction castType |
	expression reference accept: self.
	expression arguments do: [ :arg | arg accept: self ].
	
	argumentTypes := expression arguments collect: #type.
	functionType := expression reference type.
		
	"Overloaded function"
	functionType isFunctionGroupType ifTrue: [
		functionGroup := functionType functionGroup.
		matchingFunction := self findIn: functionGroup bestMatchingType: argumentTypes at: expression.
		expression solvedFunction: matchingFunction.
		expression type: matchingFunction functionType returnType.
		^ self.
	].

	"Construction or cast"
	functionType isTypeWrapper ifTrue: [
		"TODO: Perform type checking with the constructors"
		castType := functionType wrapped.
		expression type: castType.
		^ self
	].

	self error: 'Cannot call object of type "', functionType printString , '".' at: expression.

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitCodeBlock: codeBlock [
	self withScope: codeBlock scope do: [
		codeBlock body do: [ :el | el accept: self. ]
	]
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitExpressionStatement: expressionStatement [
	expressionStatement expression accept: self
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitFunction: function [
	currentFunction := function.
	self withScope: function scope do: [
		function body do: [ :el | el accept: self. ]
	].
	currentFunction := nil
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitImportStatement: importStatement [
	"Nothing to do"
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitInterface: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitLocalDeclaration: declaration [
	declaration initialValue ifNotNil: [ 
		declaration initialValue accept: self.
	].

	self resolveTypeOf: declaration inferWith: declaration initialValue.
	
	declaration initialValue ifNotNil: [
		(self hasImplicitCoercion: declaration initialValue type to: declaration type) ifFalse: [ 
			self error: 'cannot convert implicitly value of type "', declaration initialValue type printString, '" into type "' , declaration type printString , '".'at: declaration.
		]
	].
	
	currentScope at: declaration name put: declaration ifPresent: [ 
		self error: 'local variable overrides an existing variable in the same lexical scope.' at: declaration.
	].

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitMemberAccessExpression: memberAccess [
	| referencedType member baseType samplerFunction index |
	memberAccess reference accept: self.
	
	referencedType := memberAccess reference type.
	referencedType isBlockType ifTrue: [ 
		| block |
		block := referencedType block.
		block isGlobalConnectionBlock ifTrue: [
			member := block scope lookSymbol: memberAccess memberName.
			member ifNil: [ self error: 'failed to find member "' ,  memberAccess memberName , '" in block "' , block name, '".' at:  memberAccess ].
			memberAccess memberIndex: member fieldIndex.
			memberAccess type: member referenceType.
			memberAccess globalReferenceValue: member.
			memberAccess accessKind: #global.
			^ self
		].
	
		self error: 'cannot access member of non global connection block.' at: memberAccess.
	].

	baseType := referencedType.
	referencedType isReferenceType ifTrue: [ baseType := referencedType baseType ].
	baseType isSamplerType ifTrue: [
		samplerFunction := samplerBuiltIns at: memberAccess memberName ifAbsent: [ 
			self error: 'failed to find sampler member named ' , memberAccess memberName at: memberAccess.
		]. 
		memberAccess type: samplerFunction referenceType.
		memberAccess accessKind: #sampling.
		^ self
	].

	baseType isVectorType ifTrue: [
		memberAccess memberIndex: (memberAccess memberName collect: [:c |
			index := SwizzleComponentIndices at: c ifAbsent: [
				self error: 'invalid swizzle component ' , c asString at: memberAccess.
			].
			index >= baseType elements ifTrue: [ 
				self error: 'swizzle component ' , c asString at , ' is out of bounds.' at: memberAccess.
			].
			index
		] as: Array).
		memberAccess accessKind: #swizzle.
		memberAccess memberIndex size > 4 ifTrue: [ 
			self error: 'invalid swizzle with more than for components.' at: memberAccess.
		].
		memberAccess memberIndex size > 1 ifTrue: [
			memberAccess type: (DASLVectorType baseType: baseType baseType elements: memberAccess memberIndex size)
		] ifFalse: [
			memberAccess type: baseType baseType.
		].
		^ self
	].

	self halt.
	"TODO: Check the referenced type. Ensure the member exist."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPostfixUnaryOperation: operation [
	operation operand accept: self.
	"TODO: Check the types of the operands and compute the result types."
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitPrefixUnaryOperation: operation [
	| functionGroup matchingFunction |
	operation operand accept: self.
	
	functionGroup := self lookOperationFunctionGroup: (#pre , operation operation) asSymbol at: operation.
	matchingFunction := self findIn: functionGroup bestMatchingType: { operation operand type} at: operation.
	operation builtInFunction: matchingFunction.
	operation coercionType: matchingFunction coercionType.
	operation type: matchingFunction functionType returnType
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitReturnStatement: returnStatement [
	| expectedReturnType returnType |
	currentFunction ifNil: [ self error: 'return only can be used inside of functions' at: returnStatement ].
	
	returnStatement value do: [ :val | val accept: self ].
	
	expectedReturnType := currentFunction functionType returnType.
	returnType := self arrayOfTypesToTuple: (returnStatement value collect: #type).
	(self hasImplicitCoercion: returnType to: expectedReturnType) ifFalse: [ 
		self error: 'cannot return value of type "',  returnType printString ,'" in a function whose returning type is "', expectedReturnType printString , '".' at: returnStatement.
	]

]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitSemanticBlock: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitTranslationUnit: translationUnit [
	self withScope: translationUnit package do: [
		translationUnit modules do: [ :module | module accept: self ]
	].
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUniformBlock: interface [
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUniformGlobal: uniformGlobal [
	"Nothing to do"
]

{ #category : #visitor }
DASLBlockSemanticVisitor >> visitUsingStatement: usingStatement [
	| usedType identifier useScope |
	usingStatement expression accept: self.
	identifier := usingStatement identifier.
	identifier ifNotNil: [
		"TODO: Implement this"
		self halt.
	].

	usedType := usingStatement expression type.
	useScope := usedType useScope.
	useScope ifNil: [ self error: 'cannot be used.' at: usingStatement ].
	
	currentScope addUseScope: useScope.
]
