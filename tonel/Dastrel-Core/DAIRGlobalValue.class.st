Class {
	#name : #DAIRGlobalValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'name',
		'properties'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #properties }
DAIRGlobalValue >> hasProperty: aSymbol [
	^ properties includesKey: aSymbol
]

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

{ #category : #properties }
DAIRGlobalValue >> properties [
	^ properties
]

{ #category : #properties }
DAIRGlobalValue >> propertyAt: aSymbol [ 
	^ properties at: aSymbol
]

{ #category : #properties }
DAIRGlobalValue >> propertyAt: aSymbol ifAbsent: aBlock [
	^ properties at: aSymbol ifAbsent: aBlock
]

{ #category : #properties }
DAIRGlobalValue >> propertyAt: aSymbol ifAbsentPut: aBlock [
	^ properties at: aSymbol ifAbsentPut: aBlock
]

{ #category : #properties }
DAIRGlobalValue >> propertyAt: aSymbol ifPresent: aBlock [
	^ properties at: aSymbol ifPresent: aBlock
]

{ #category : #properties }
DAIRGlobalValue >> propertyAt: aSymbol put: anObject [
	^ properties at: aSymbol put: anObject
]
