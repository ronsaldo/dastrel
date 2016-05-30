Class {
	#name : #DAIRFunction,
	#superclass : #DAIRGlobalValue,
	#instVars : [
		'basicBlocks',
		'functionType',
		'type',
		'arguments',
		'gensymCount',
		'postOrder',
		'preOrder',
		'haveDominance'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRFunction class >> name: aString functionType: aFunctionType [
	^ self new name: aString; functionType: aFunctionType; yourself
]

{ #category : #visitor }
DAIRFunction >> accept: aVisitor [
	^ aVisitor visitFunction: self
]

{ #category : #adding }
DAIRFunction >> addBasicBlock: aBasicBlock [
	basicBlocks add: aBasicBlock.
	aBasicBlock index: basicBlocks size.
	aBasicBlock function: self.
	self invalidateControlFlowCaches
]

{ #category : #accessing }
DAIRFunction >> arguments [
	^ arguments
]

{ #category : #accessing }
DAIRFunction >> basicBlocks [
	^ basicBlocks
]

{ #category : #'control flow' }
DAIRFunction >> computeDominance [
	"
	Dominance algorithm taken from paper 'A Simple, Fast Dominance Algorithm' by Cooper et al.
	"
	| reversePostOrder entryNode doms changed nodeIndex newIdom firstNewIdom block |
	(basicBlocks isEmpty or: [haveDominance]) ifTrue: [ ^ self ].
	
	reversePostOrder := self postOrder allButLast reversed.
	entryNode := basicBlocks first.
	doms := Array new: postOrder size withAll: -1.
	doms at: entryNode postOrderIndex put: entryNode postOrderIndex.
	changed := true.
	[ changed ] whileTrue: [
		changed := false.
		reversePostOrder do: [ :node |
			nodeIndex := node postOrderIndex.
			
			newIdom := (node predecessors detect: [ :pred | (doms at: pred postOrderIndex) >= 0]) postOrderIndex.
			self assert: newIdom isNotNil.
			
			firstNewIdom := newIdom.
			node predecessors do: [ :pred |
				(pred postOrderIndex ~= firstNewIdom and: [ (doms at: pred postOrderIndex) >= 0 ]) ifTrue: [ 
					newIdom := self dominances: doms intersect: pred postOrderIndex with: newIdom.
				] 
			].
			
			(doms at: nodeIndex) ~= newIdom ifTrue: [
				changed := true.
				doms at: nodeIndex put: newIdom
			]
		]
	].

	1 to: doms size do: [ :i |
		block := postOrder at: i.
		block immediateDominator: (postOrder at: (doms at: i)).
		block immediateDominator == block ifTrue: [ 
			block immediateDominator: nil
		]
	].

	self computeDominanceFrontiers.
	haveDominance := true.
]

{ #category : #'control flow' }
DAIRFunction >> computeDominanceFrontiers [
	| position end |
	
	"Reset the dominace frontiers."
	basicBlocks do: [ :bb | bb dominanceFrontier: Set new ].
	
	"Propagate up to the immediate dominator."
	basicBlocks do: [ :bb |
		bb predecessors size >= 2 ifTrue: [
			bb predecessors do: [ :pred |
				position := pred.
				end := bb immediateDominator.
				[ position ~~ end ] whileTrue: [
					position dominanceFrontier add: bb.
					position := position immediateDominator
				]
			]
		]
	].
	
]

{ #category : #'control flow' }
DAIRFunction >> computePostOrderFor: basicBlock visited: visitedArray [
	(visitedArray at: basicBlock index) ifTrue: [ ^ self ].
	visitedArray at: basicBlock index put: true.
	basicBlock successors do: [ :succ |
		self computePostOrderFor: succ visited: visitedArray.
	].

	postOrder add: basicBlock.
	basicBlock postOrderIndex: postOrder size.
]

{ #category : #'control flow' }
DAIRFunction >> computePreOrderFor: basicBlock visited: visitedArray [ 
	(visitedArray at: basicBlock index) ifTrue: [ ^ self ].
	visitedArray at: basicBlock index put: true.
	preOrder add: basicBlock.
	basicBlock preOrderIndex: preOrder size.
	
	basicBlock successors do: [ :succ |
		self computePreOrderFor: succ visited: visitedArray.
	].


]

{ #category : #'control flow' }
DAIRFunction >> dominances: doms intersect: n1 with: n2 [
	| finger1 finger2 |
	finger1 := n1.
	finger2 := n2.
	[ finger1 ~= finger2 ] whileTrue: [
		[ finger1 < finger2 ] whileTrue: [
			finger1 := doms at: finger1.
		].
		[ finger2 < finger1 ] whileTrue: [
			finger2 := doms at: finger2.
		]
	].

	^ finger1
]

{ #category : #printing }
DAIRFunction >> fullPrintOn: aStream [
	aStream nextPut: $@; print: name; space; print: type; cr.
	aStream nextPutAll: '{'; cr.
	basicBlocks do: [ :bb | bb fullPrintOn: aStream ].
	aStream nextPutAll: '}'; cr.
]

{ #category : #accessing }
DAIRFunction >> functionType [
	^ functionType
]

{ #category : #accessing }
DAIRFunction >> functionType: anObject [
	functionType := anObject.
	type := DASLReferenceType baseType: functionType storage: DASLType genericStorage.
	self makeArguments.
]

{ #category : #private }
DAIRFunction >> generateSymbol [
	gensymCount := gensymCount + 1.
	^ (#g , gensymCount printString) asSymbol
]

{ #category : #initialization }
DAIRFunction >> initialize [
	super initialize.
	basicBlocks := OrderedCollection new.
	arguments := #().
	gensymCount := 0.
	haveDominance := false.
]

{ #category : #'control flow' }
DAIRFunction >> invalidateControlFlowCaches [
	preOrder := nil.
	postOrder := nil.
	hasDominance := false.
]

{ #category : #testing }
DAIRFunction >> isFunction [
	^ true
]

{ #category : #private }
DAIRFunction >> makeArguments [
	arguments := functionType arguments collectWithIndex: [ :argType :index |
		DAIRFunctionArgument new
			type: argType;
			index: index;
			name: (#arg , index printString) asSymbol;
			yourself
	]
]

{ #category : #optimizations }
DAIRFunction >> performBasicOptimizations [
	DAIROptPromoteAllocas passOnFunction: self.
]

{ #category : #'control flow' }
DAIRFunction >> postOrder [
	| visited |
	postOrder ifNotNil: [ ^ postOrder ].
	visited := Array new: basicBlocks size withAll: false.
	postOrder := OrderedCollection new.
	self computePostOrderFor: basicBlocks first visited: visited.
	^ postOrder
]

{ #category : #'control flow' }
DAIRFunction >> preOrder [
	| visited |
	preOrder ifNotNil: [ ^ preOrder ].
	visited := Array new: basicBlocks size withAll: false.
	preOrder := OrderedCollection new.
	self computePreOrderFor: basicBlocks first visited: visited.
	^ preOrder
]

{ #category : #accessing }
DAIRFunction >> type [
	^ type
]
