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

{ #category : #adding }
DAIRValue >> fullPrintOn: aStream [
	self printOn: aStream
]

{ #category : #testing }
DAIRValue >> isConstant [
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
