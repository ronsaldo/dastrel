Class {
	#name : #DASLReferenceType,
	#superclass : #DASLType,
	#instVars : [
		'baseType'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #accessing }
DASLReferenceType class >> baseType: aBaseType [
	^ self new baseType: aBaseType
]

{ #category : #comparing }
DASLReferenceType >> = other [
	^ self class == other class and: [ baseType = other baseType ]
]

{ #category : #accessing }
DASLReferenceType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLReferenceType >> baseType: anObject [
	baseType := anObject
]

{ #category : #comparing }
DASLReferenceType >> hash [
	^ self class hash bitXor: baseType hash
]

{ #category : #testing }
DASLReferenceType >> isReferenceType [
	^ true
]
