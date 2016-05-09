Class {
	#name : #DAIRValue,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #adding }
DAIRValue >> addInstructionReference: anInstruction [
	"By default, do nothing"
]

{ #category : #testing }
DAIRValue >> isConstant [
	^ false
]

{ #category : #testing }
DAIRValue >> isInstruction [
	^ false
]

{ #category : #accessing }
DAIRValue >> type [
	self subclassResponsibility
]
