Class {
	#name : #DAIRValue,
	#superclass : #DASLObject,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #testing }
DAIRValue >> isConstant [
	^ false
]

{ #category : #accessing }
DAIRValue >> type [
	self subclassResponsibility
]
