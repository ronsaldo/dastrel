Class {
	#name : #DAIRValue,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRValue >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #adding }
DAIRValue >> addInstructionReference: anInstruction [
	"By default, do nothing"
]

{ #category : #printing }
DAIRValue >> fullPrintOn: aStream [
	self printOn: aStream
]

{ #category : #printing }
DAIRValue >> fullPrintString [
	^ ByteString streamContents: [ :out | self fullPrintOn: out ]
]

{ #category : #testing }
DAIRValue >> isConstant [
	^ false
]

{ #category : #testing }
DAIRValue >> isConstantBuiltInFunction [
	^ false
]

{ #category : #testing }
DAIRValue >> isConstantValue [
	^ false
]

{ #category : #testing }
DAIRValue >> isInstruction [
	^ false
]

{ #category : #testing }
DAIRValue >> isSSAValue [
	^ true
]

{ #category : #accessing }
DAIRValue >> type [
	self subclassResponsibility
]
