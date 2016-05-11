Class {
	#name : #DASLReferenceType,
	#superclass : #DASLType,
	#instVars : [
		'baseType',
		'storage'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLReferenceType class >> baseType: aBaseType storage: storage [
	^ self new baseType: aBaseType; storage: storage; yourself
]

{ #category : #'class initialization' }
DASLReferenceType class >> initialize [
	"
	self initialize
	"
	super initialize.

	UniformConstantStorage := #uniform.
	UniformStorage := 	#uniform.
	InputStorage := #input.
	OutputStorage := #output.
	GenericStorage := #generic.
	WorkgroupStorage := #workgroup.
	CrossWorkgroupStorage := #crossWorkgroup.
	PrivateStorage := #private.
	FunctionStorage := #function.
	GenericStorage := #generic.
	
]

{ #category : #comparing }
DASLReferenceType >> = other [
	^ self class == other class and: [ baseType = other baseType and: [ storage = other storage ] ] 
]

{ #category : #visitor }
DASLReferenceType >> accept: aVisitor [
	^ aVisitor visitReferenceType: self
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
	^ (self class hash bitXor: baseType hash) bitXor: storage hash
]

{ #category : #testing }
DASLReferenceType >> isReferenceType [
	^ true
]

{ #category : #printing }
DASLReferenceType >> printOn: aStream [
	aStream print: baseType;
		nextPutAll: ' ref '; print: storage
]

{ #category : #accessing }
DASLReferenceType >> storage [
	^ storage
]

{ #category : #accessing }
DASLReferenceType >> storage: aSymbol [
	self assert: aSymbol isSymbol.
	storage := aSymbol
]
