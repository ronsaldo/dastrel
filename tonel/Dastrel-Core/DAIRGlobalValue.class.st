Class {
	#name : #DAIRGlobalValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'name',
		'properties'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #initialization }
DAIRGlobalValue >> initialize [
	super initialize.
	properties := IdentityDictionary new.
]

{ #category : #testing }
DAIRGlobalValue >> isFunction [
	^ false
]

{ #category : #testing }
DAIRGlobalValue >> isGlobalVariable [
	^ false
]

{ #category : #accessing }
DAIRGlobalValue >> name [
	^ name
]

{ #category : #accessing }
DAIRGlobalValue >> name: anObject [
	name := anObject
]

{ #category : #printing }
DAIRGlobalValue >> printOn: aStream [
	aStream nextPut: $@; print: name.
]

{ #category : #printing }
DAIRGlobalValue >> printPropertiesOn: aStream [
	properties ifEmpty: [ ^ self ].
	aStream nextPut: ${.
	properties associations doWithIndex: [ :assoc :index |
		index > 1 ifTrue: [ aStream nextPutAll: ', ' ].
		aStream print: assoc.
	].
	aStream nextPut: $}.
]

{ #category : #accessing }
DAIRGlobalValue >> properties [
	^ properties
]

{ #category : #accessing }
DAIRGlobalValue >> propertyAt: aSymbol [ 
	^ properties at: aSymbol
]

{ #category : #accessing }
DAIRGlobalValue >> propertyAt: aSymbol ifAbsent: aBlock [
	^ properties at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
DAIRGlobalValue >> propertyAt: aSymbol ifAbsentPut: aBlock [
	^ properties at: aSymbol ifAbsentPut: aBlock
]

{ #category : #accessing }
DAIRGlobalValue >> propertyAt: aSymbol put: anObject [
	^ properties at: aSymbol put: anObject
]
