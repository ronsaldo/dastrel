Class {
	#name : #DAIRUnreacheable,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #visitor }
DAIRUnreacheable >> accept: aVisitor [
	^ aVisitor visitUnreachable: self
]

{ #category : #testing }
DAIRUnreacheable >> isTerminator [
	^ true
]

{ #category : #testing }
DAIRUnreacheable >> isUnreachable [
	^ true
]

{ #category : #printing }
DAIRUnreacheable >> mnemonic [
	^ 'unreachable'
]

{ #category : #accessing }
DAIRUnreacheable >> type [
	^ DASLType voidType
]
