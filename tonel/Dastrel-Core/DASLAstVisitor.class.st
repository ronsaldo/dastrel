Class {
	#name : #DASLAstVisitor,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-AST'
}

{ #category : #compilation }
DASLAstVisitor class >> passOn: ast [
	^ self new passOn: ast
]

{ #category : #compilation }
DASLAstVisitor >> passOn: ast [
	^ ast accept: self.
]

{ #category : #visitor }
DASLAstVisitor >> visitAssignment: assignment [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitBinaryOperation: binaryOperation [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitBuiltInFunction: builtInFunction [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitCallBlockStatement: callExpression [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitCallExpression: callExpression [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitCharacter: character [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitCodeBlock: codeBlock [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitConditionalExpression: conditionalExpression [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitConnectionFlowType: connectionFlowType [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitDiscardStatement: discardStatement [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitExpressionStatement: expressionStatement [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFieldDefinition: fieldDefinition [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFloat: float [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFunction: function [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFunctionArgument: functionArgument [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFunctionGroup: functionGroup [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitFunctionPrototype: functionPrototype [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitGraphBlock: graphBlock [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitIdentifier: identifier [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitImportStatement: usingStatement [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitInteger: integer [
	^ SLVMConstant
		type: (integer type asSlovimType: self compilationTarget)
		value: integer value
]

{ #category : #visitor }
DASLAstVisitor >> visitInterface: interface [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitLocalDeclaration: localDeclaration [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitMemberAccessExpression: memberAccessExpression [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitPostfixUnaryOperation: postfixUnaryOperation [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitPrefixUnaryOperation: prefixUnaryOperation [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitReturnStatement: returnStatement [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitSemanticBlock: semanticBlock [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitString: string [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitSubscriptExpression: subscriptExpression [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitTranslationUnit: translationUnit [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitUniformBlock: uniformBlock [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitUniformGlobal: uniformGlobal [
	self subclassResponsibility
]

{ #category : #visitor }
DASLAstVisitor >> visitUsingStatement: usingStatement [
	self subclassResponsibility
]
