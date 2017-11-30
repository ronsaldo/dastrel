Extension { #name : #PhanideStyler }

{ #category : #'*Dastrel-Phanide' }
PhanideStyler classSide >> dastrel [
	<styler>
	^ self styler: 'Dastrel' extensions: #(dastrel) commandHighlighter: DASLSyntaxHighlighter
]
