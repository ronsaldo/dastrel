Class {
	#name : #DASLBuildItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'sources',
		'targets',
		'dependencies',
		'isUpToDateCache'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #adding }
DASLBuildItem >> addDependencies: aCollectionOfItems [
	dependencies addAll: aCollectionOfItems
]

{ #category : #adding }
DASLBuildItem >> addDependency: anItem [
	dependencies add: anItem
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> asDASLBuildItem [
	^ self
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> build [
	"Here goes the actual item building."
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> buildReportPercentage: percentage [
	self 
		reportPercentage: percentage;
		build
]

{ #category : #accessing }
DASLBuildItem >> dependencies [
	^ dependencies
]

{ #category : #accessing }
DASLBuildItem >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #initialization }
DASLBuildItem >> initialize [
	super initialize.
	dependencies := OrderedCollection new.
	sources := #().
	targets := #().
	isUpToDateCache := nil.
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> isUpToDate [
	isUpToDateCache ifNotNil: [ ^ isUpToDateCache ].
	isUpToDateCache := true.
	targets ifNotEmpty: [
		targets detect: [ :target | target exists not ] ifFound: [ ^ isUpToDateCache := false ].
		isUpToDateCache := self lastTargetModificationTime >= self lastSourceModificationTime.
	].

	isUpToDateCache ifFalse: [ ^ isUpToDateCache ].
	dependencies do: [ :dep |
		dep isUpToDate ifFalse: [
			isUpToDateCache := false.
			^ false.
		]
	].

	^ isUpToDateCache
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> lastSourceModificationTime [
	| result |
	result := DateAndTime epoch.
	sources do: [ :source | result := result max: source modificationTime ].
	^ result
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> lastTargetModificationTime [
	| result |
	result := DateAndTime epoch.
	targets do: [ :target | result := result max: target modificationTime ].
	^ result
]

{ #category : #accessing }
DASLBuildItem >> name [
	^ name
]

{ #category : #accessing }
DASLBuildItem >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> needsBuilding [
	^ self isUpToDate not
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> printOn: aStream [
	super printOn: aStream.
	aStream space; print: self name
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> relativePathToString: aRelativePath [
	self assert: aRelativePath class == RelativePath.
	^ ByteString streamContents: [:out |
		out nextPutAll: (aRelativePath at: 1).
		2 to: aRelativePath size do: [ :i | out nextPut: $/; nextPutAll: (aRelativePath at: i) ]
	]
]

{ #category : #'as yet unclassified' }
DASLBuildItem >> reportPercentage: percentage [
	| message |
	message := '{1}%: {2}' format: { (percentage * 100) asInteger . self name}.
	Transcript show: message; cr.
	FileStream stdout nextPutAll: message; lf.
]

{ #category : #accessing }
DASLBuildItem >> sources [
	^ sources
]

{ #category : #accessing }
DASLBuildItem >> sources: aCollection [
	sources := aCollection collect: #asDASLBuildItem.
	self addDependencies: sources.
]

{ #category : #accessing }
DASLBuildItem >> targets [
	^ targets
]

{ #category : #accessing }
DASLBuildItem >> targets: anObject [
	targets := anObject
]
