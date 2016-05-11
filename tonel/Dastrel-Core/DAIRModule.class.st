Class {
	#name : #DAIRModule,
	#superclass : #DASLObject,
	#instVars : [
		'globalValues'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #adding }
DAIRModule >> add: aGlobalValue [
	globalValues at: aGlobalValue name put: aGlobalValue
]

{ #category : #adding }
DAIRModule >> globalNamed: aSymbol [
	^ globalValues at: aSymbol
]

{ #category : #accessing }
DAIRModule >> globalValues [
	^ globalValues
]

{ #category : #initialization }
DAIRModule >> initialize [
	globalValues := OrderedDictionary new
]

{ #category : #printing }
DAIRModule >> printOn: aStream [
	globalValues values do: [ :val | val fullPrintOn: aStream ].

]
