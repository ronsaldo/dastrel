Extension { #name : #PhanideStyler }

{ #category : #'*Dastrel-Phanide' }
PhanideStyler class >> dastrel [
	<styler>
	^ self styler: 'Dastrel' extensions: #(dastrel) commandHighlighter: DASLSyntaxHighlighter
]
