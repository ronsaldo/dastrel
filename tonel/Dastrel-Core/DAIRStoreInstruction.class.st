Class {
	#name : #DAIRStoreInstruction,
	#superclass : #DAIRInstruction,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRStoreInstruction class >> value: value variable: variable [
	^ self new value: value variable: variable
]

{ #category : #printing }
DAIRStoreInstruction >> mnemonic [
	^ 'store'
]

{ #category : #accessing }
DAIRStoreInstruction >> type [
	^ DASLType voidType
]

{ #category : #accessing }
DAIRStoreInstruction >> value [
	^ parameters first
]

{ #category : #construction }
DAIRStoreInstruction >> value: value variable: variable [
	self parameters: { value . variable }
]

{ #category : #accessing }
DAIRStoreInstruction >> variable [
	^ parameters second
]
