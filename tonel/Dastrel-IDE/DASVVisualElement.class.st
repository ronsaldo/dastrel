Class {
	#name : #DASVVisualElement,
	#superclass : #Object,
	#category : #'Dastrel-IDE'
}

{ #category : #'athens shapes' }
DASVVisualElement >> createShapeOn: aCanvas rectangle: aRectangle [
	^ aRectangle
]

{ #category : #'athens shapes' }
DASVVisualElement >> createShapeOn: aCanvas rectangleShape: aRectangle radius: radius [
	| w h |
	w := aRectangle width.
	h := aRectangle height.
	^ aCanvas createPath: [ :path |
		path
			absolute;
			moveTo: radius@0;
			lineTo: (w-radius) @0;
			cwArcTo: w@radius angle: Float halfPi;
			
			lineTo: w@(h - radius);
			cwArcTo: (w - radius) @ h angle: Float halfPi;
			
			lineTo: radius@h;
			cwArcTo: 0 @ (h - radius) angle: Float halfPi;
			
			lineTo: 0@radius;
			cwArcTo: radius @ 0 angle: Float halfPi.
	]
]
