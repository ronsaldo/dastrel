Class {
	#name : #DASLFunctionPrototype,
	#superclass : #DASLModule,
	#instVars : [
		'arguments',
		'returnType',
		'functionType',
		'codegenValue',
		'codegenReturnVariables'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunctionPrototype >> accept: aVisitor [
	^ aVisitor visitFunctionPrototype: self
]

{ #category : #accessing }
DASLFunctionPrototype >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLFunctionPrototype >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> codegenReturnVariables [
	^ codegenReturnVariables
]

{ #category : #accessing }
DASLFunctionPrototype >> codegenReturnVariables: anObject [
	codegenReturnVariables := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLFunctionPrototype >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> functionType [
	^ functionType
]

{ #category : #accessing }
DASLFunctionPrototype >> functionType: anObject [
	functionType := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> mangledName [
	^ name , ' ' , self functionType printString
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType: anObject [
	returnType := anObject
]
