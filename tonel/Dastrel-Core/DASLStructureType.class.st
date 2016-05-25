Class {
	#name : #DASLStructureType,
	#superclass : #DASLType,
	#instVars : [
		'types',
		'kind',
		'name',
		'names',
		'alignment',
		'size',
		'offsets'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'as yet unclassified' }
DASLStructureType class >> blockKind [
	^ #block
]

{ #category : #'as yet unclassified' }
DASLStructureType class >> bufferBlockKind [
	^ #bufferBlock
]

{ #category : #'as yet unclassified' }
DASLStructureType class >> genericKind [
	^ #generic
]

{ #category : #construction }
DASLStructureType class >> name: structureName types: typeList kind: structureKind names: fieldNames [
	^ self new name: structureName; types: typeList; kind: structureKind; names: fieldNames; yourself
]

{ #category : #comparing }
DASLStructureType >> = other [
	^ self class == other class and: [ kind = other kind and: [ types = other types ] ]
]

{ #category : #visitor }
DASLStructureType >> accept: aVisitor [
	^ aVisitor visitStructureType: self
]

{ #category : #accessing }
DASLStructureType >> alignment [
	^ alignment
]

{ #category : #private }
DASLStructureType >> computeLayout [
	| currentOffset offset |
	currentOffset := 0.
	alignment := 1.
	offsets := types collect: [ :type |
		currentOffset := currentOffset alignedTo: type alignment.
		offset := currentOffset.
		currentOffset := currentOffset + type size.
		alignment := alignment max: type alignment.
		offset.
	].
	size := currentOffset alignedTo: alignment.
]

{ #category : #comparing }
DASLStructureType >> hash [
	^ self class hash bitXor: types hash
]

{ #category : #testing }
DASLStructureType >> isStructureType [
	^ true
]

{ #category : #accessing }
DASLStructureType >> kind [
	^ kind
]

{ #category : #accessing }
DASLStructureType >> kind: anObject [
	kind := anObject
]

{ #category : #accessing }
DASLStructureType >> memberAt: constantValue [
	self assert: constantValue isConstant.
	^ types at: constantValue value + 1
]

{ #category : #accessing }
DASLStructureType >> name [
	^ name
]

{ #category : #accessing }
DASLStructureType >> name: aName [
	name := aName
]

{ #category : #accessing }
DASLStructureType >> names [
	^ names
]

{ #category : #accessing }
DASLStructureType >> names: anObject [
	names := anObject
]

{ #category : #accessing }
DASLStructureType >> offsets [
	^ offsets
]

{ #category : #printing }
DASLStructureType >> printOn: aStream [
	aStream nextPutAll: 'struct {'.
	types doWithIndex: [ :type :index |
		index > 1 ifTrue: [ aStream nextPutAll: ', ' ].
		aStream print: type
	].
	aStream nextPutAll: '}'.
	
]

{ #category : #accessing }
DASLStructureType >> size [
	^ size
]

{ #category : #accessing }
DASLStructureType >> types [
	^ types
]

{ #category : #accessing }
DASLStructureType >> types: anObject [
	types := anObject.
	self computeLayout.
]
