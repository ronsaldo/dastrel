Class {
	#name : #DASLBlockSemanticVisitor,
	#superclass : #DASLSemanticVisitor,
	#instVars : [
		'currentFunction'
	],
	#category : #'Dastrel-Core-Semantic'
}

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

{ #category : #'as yet unclassified' }
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
	| referencedType member |
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
			^ self
		].
	
		self error: 'cannot access member of non global connection block.' at: memberAccess.
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
	operation operand accept: self.
	"TODO: Check the types of the operands and compute the result types."
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
