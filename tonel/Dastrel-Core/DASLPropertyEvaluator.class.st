Class {
	#name : #DASLPropertyEvaluator,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'compilationContext'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #accessing }
DASLPropertyEvaluator >> compilationContext [
	^ compilationContext
]

{ #category : #accessing }
DASLPropertyEvaluator >> compilationContext: anObject [
	compilationContext := anObject
]

{ #category : #'as yet unclassified' }
DASLPropertyEvaluator >> evaluateProperties: properties [
	| result |
	result := Dictionary new.
	properties keysAndValuesDo: [ :key :value |
		result at: key value put: (value ifNotNil: [value accept: self])
	].
	^ result
]

{ #category : #'as yet unclassified' }
DASLPropertyEvaluator >> lowerNonLiteralProperties: properties for: result [
	| nonLiteralProperties |
	nonLiteralProperties := (properties associationsSelect: [ :assoc | assoc value isLiteral not ]).
	nonLiteralProperties associationsDo: [ :property | property value lowerProperty: property for: result on: properties]
]

{ #category : #'as yet unclassified' }
DASLPropertyEvaluator >> validateBufferBlockProperties: bufferBlock [
	| result |
	result := self evaluateProperties: bufferBlock attributes.
	self lowerNonLiteralProperties: result for: bufferBlock.
	bufferBlock attributes: result.
]

{ #category : #'as yet unclassified' }
DASLPropertyEvaluator >> validateUniformBlockProperties: uniformBlock [
	| result |
	result := self evaluateProperties: uniformBlock attributes.
	self lowerNonLiteralProperties: result for: uniformBlock.
	uniformBlock attributes: result.
]

{ #category : #'as yet unclassified' }
DASLPropertyEvaluator >> validateUniformGlobalProperties: uniformGlobal [
	| result |
	result := self evaluateProperties: uniformGlobal attributes.
	self lowerNonLiteralProperties: result for: uniformGlobal.
	uniformGlobal attributes: result
]

{ #category : #visiting }
DASLPropertyEvaluator >> visitBinaryOperation: operation [
	| leftValue rightValue |
	leftValue := operation left accept: self.
	rightValue := operation right accept: self.
	
	^ leftValue perform: operation operation with: rightValue
]

{ #category : #visiting }
DASLPropertyEvaluator >> visitIdentifier: identifier [
	| shaderSignature |
	self flag: 'Support multiple shader signatures.'.
	shaderSignature := compilationContext shaderSignatures anyOne.
	^ shaderSignature memberAt: identifier value ifAbsent: [
		self error: 'Unknown shader signature descriptor set.' at: identifier
	]
]

{ #category : #visiting }
DASLPropertyEvaluator >> visitInteger: integerConstant [
	^ integerConstant value
]

{ #category : #visiting }
DASLPropertyEvaluator >> visitMemberAccessExpression: memberAccess [
	| reference |
	reference := memberAccess reference accept: self.
	^ reference memberAt: memberAccess memberName ifAbsent: [
		self error: 'Failed to find member.' at: memberAccess
	]
]
