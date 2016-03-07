Class {
	#name : #DAIRModule,
	#superclass : #DASLObject,
	#instVars : [
		'globalValues'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #initialization }
DAIRModule >> initialize [
	globalValues := IdentityDictionary new
]
