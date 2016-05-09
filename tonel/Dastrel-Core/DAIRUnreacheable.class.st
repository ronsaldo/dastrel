Class {
	#name : #DAIRUnreacheable,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #testing }
DAIRUnreacheable >> isTerminator [
	^ true
]

{ #category : #testing }
DAIRUnreacheable >> isUnreachable [
	^ true
]

{ #category : #accessing }
DAIRUnreacheable >> type [
	^ DASLType voidType
]
