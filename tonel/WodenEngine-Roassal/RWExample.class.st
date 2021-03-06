Class {
	#name : #RWExample,
	#superclass : #RWObject,
	#category : 'WodenEngine-Roassal-Examples'
}

{ #category : #'as yet unclassified' }
RWExample >> allClasses [
	<script: 'self new allClasses open'>
	| view els elementClass |
	view := RWView new.
	els := RWCube elementsOn: Object withAllSubclasses.
	els do: [ :el |
		el when: RWMouseButtonDown do: [ :ev |
			elementClass := ev element model.
			self inform: 'Class ' , elementClass name.
			elementClass inspect.
			ev element  shape color: Color darkGray.
			ev element changed.
		]
	].
	view addAll: els.
	RWCubeLayout on: view elements.
	view @ RWMouseKeyControl.
	^ view
]

{ #category : #layout }
RWExample >> circleLayout [
	<script: 'self new circleLayout open'>
	| v  |
	v := RWView new.
	1 to: 10 do: [ :i |
		v add: RWCube element.
	].

	RWCircleLayout on: v elements.

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> classBars [
	<script: 'self new classBars open'>
	| v shape elements |
	v := RWView new.
	shape := RWCube new height: [ :cls | cls numberOfMethods sqrt + 0.1 ].
	elements := shape elementsOn: Collection withAllSubclasses.

	v addAll: elements.

	RWXZGridLayout on: elements.
	RWAlign elements: elements abovePoint: WMVector3F zero.

	elements do: [ :el |
		el
			addInteraction: RWHighlightable;
			addInteraction: RWPopup.

		(v elementFromModel: el model superclass) ifNotNil: [ :parentElement |
			v add: (RWLine blue edgeFrom: el topAnchorPoint to: parentElement topAnchorPoint )
		]
	].

	v addInteraction: RWOrbitController.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> clickAddAbove [
	<script: 'self new clickAddAbove open'>
	| v e cube position action |
	cube := RWCube new.
	v := RWView new.
	
	action := [ :ev |
			position := ev element position.
			position y: position y + 1.05. 
			e := cube element.
			e translateTo: position;
				when: RWMouseButtonDown do: action.
			v add: e
	].
	
	1 to: 1024 do: [ :i |
		e := cube element.
		e when: RWMouseButtonDown do: action.
		v add: e.
	].
	(RWXZGridLayout gap: 0.05) on: v elements.
	v addInteraction: RWMouseKeyControl.
	v camera position: (WMVector3F x: 0.0 y: 3.0 z: 0.0).
	^ v

]

{ #category : #'as yet unclassified' }
RWExample >> clickGreen [
	<script: 'self new clickGreen open'>
	| v e |
	v := RWView new.

	1 to: 100 do: [ :i |
		e := RWCube element.
		e when: RWMouseButtonDown do: [ :ev |
			ev element shape color: Color green.
			ev element changed.
		].
		v add: e.
	].
	RWXZGridLayout on: v elements.
	v addInteraction: RWMouseKeyControl.
	v camera position: (WMVector3F x: 0.0 y: 1.0 z: 3.0).
	^ v

]

{ #category : #'as yet unclassified' }
RWExample >> clickLeds [
	<script: 'self new clickLeds open'>
	| v e colors cube |
	colors := {  Color gray . Color red . Color green . Color blue . Color yellow . Color white}.
	cube := RWCube new.
	cube color: [ :val | colors at: val ].
	
	v := RWView new.
	
	1 to: 1024 do: [ :i |
		e := cube elementOn: 1.
		e when: RWMouseButtonDown do: [ :ev |
			ev element model: ev element model + 1.
			ev element model > colors size ifTrue: [ ev element model: 1 ].
			ev element changed.
		].
		e when: RWMouseButtonUp do: [ :ev |
			ev element model: ev element model + 1.
			ev element model > colors size ifTrue: [ ev element model: 1 ].
			ev element changed.
		].

		v add: e.
	].
	(RWXZGridLayout gap: 0.05) on: v elements.
	v addInteraction: RWMouseKeyControl.
	v camera position: (WMVector3F x: 0.0 y: 3.0 z: 0.0).
	^ v

]

{ #category : #trees }
RWExample >> collectionSubclassesTree [
	<script: 'self new collectionSubclassesTree open'>
	| view  objects associations elements assocWithElements shape |
	view := RWView new.
	objects := Collection withAllSubclasses.
	associations := objects collect: [:o | o -> o superclass ].
	
	shape := RWCube new.
	elements := shape elementsOn: objects.
	elements addInteraction: RWPopup.
	elements addInteraction: RWHighlightable.
	view addAll: elements.
	
	assocWithElements := associations collect: [ :a | (view elementFromModel: a key) -> (view elementFromModel: a value)]
		thenSelect: [:a | a key isNotNil and: [a value isNotNil ]].
	view addAll: (RWEdge linesFor: assocWithElements).
	
	RWGridTreeLayout on: view elements.
	view addInteraction: RWOrbitController.
	^ view
]

{ #category : #'as yet unclassified' }
RWExample >> cubeLayout [
	<script: 'self new cubeLayout open'>
	| v  |
	v := RWView new.
	1 to: 1000 do: [ :i |
		v add: RWCube element.
	].

	v camera position: (WMVector3F x: 0.0 y: 0.0 z: 3.0). 
	RWCubeLayout on: v elements.

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #trees }
RWExample >> differentShapes [
	<script: 'self new differentShapes open'>
	| view  |
	view := RWView new.
	view addAll: ( RWCylinder elementsOn: (1 to: 4)).
	view addAll: ( RWCube elementsOn: (1 to: 4)).
	view addAll: ( RWUVSphere elementsOn: (1 to: 4)).
	view addAll: ( RWPyramid elementsOn: (1 to: 4)).

	RWXZGridLayout on: view elements.
	view @ RWMouseKeyControl .
	^ view.
]

{ #category : #'as yet unclassified' }
RWExample >> edges [
	<script: 'self new edges open'>

	| v el1 el2 |
	v := RWView new.

	el1 := RWCube element.
	el2 := RWCube element.

	v addAll: { el1 . el2 }.

	RWXZGridLayout on: v elements.

	v add: (RWLine green edgeFrom: el1 to: el2 ).

	v addInteraction: RWMouseKeyControl.
	^ v 
]

{ #category : #'as yet unclassified' }
RWExample >> eventHandling [
	<script: 'self new eventHandling open'>

	| v cube |
	v := RWView new.
	cube := RWCube element.
	v add: cube.

	cube when: RWMouseEnter do: [ :evt |
		evt element color: Color blue.
		evt signalUpdate.
	].

	cube when: RWMouseLeave do: [ :evt |
		evt element color: Color gray.
		evt signalUpdate.
	].

	cube when: RWMouseButtonDown do: [ :evt |
		evt element color: Color random.
		evt signalUpdate.
	].

	v addInteraction: RWOrbitController new.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> fallingCubeLayout [
	<script: 'self new fallingCubeLayout open'>
	| v floor |
	v := RWView new.
	1 to: 300 do: [ :i |
		v add: (RWCube element mass: 1.0).
	].

	v camera translateByZ: 6.0.
	RWCubeLayout on: v elements.

	floor := RWCube new width: 10.0; depth: 5.0; height: 0.1; element.
	floor wall;
		translateByY: -10.0.
	v add: floor.

	v addInteraction: RWMouseKeyControl.
	v withPhysics.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> fallingLineLayout [
	<script: 'self new fallingLineLayout open'>
	| v floor |
	v := RWView new.
	1 to: 1000 do: [ :i |
		v add: (RWCube element mass: 1.0).
	].

	v camera translateByZ: 3.0. 
	RWYLineLayout on: v elements.

	floor := RWCube new width: 10.0; depth: 5.0; height: 0.1; element.
	floor wall;
		translateByY: -10.0.
	v add: floor.

	v addInteraction: RWMouseKeyControl.
	v withPhysics.
	^ v
]

{ #category : #layout }
RWExample >> gridLayout [
	<script: 'self new gridLayout open'>
	| v  |
	v := RWView new.
	1 to: 1000 do: [ :i |
		v add: RWCube element.
	].

	v camera position: (WMVector3F x: 0.0 y: 0.0 z: 3.0). 
	RWXZGridLayout on: v elements.

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #mesh }
RWExample >> gridMesh [
	<script: 'self new gridMesh open'>
	| view shape elements |
	view := RWView new.
	view
		backgroundColor: Color black.

	shape := RWMeshShape xzLineGridWithWidth: 10.0 height: 10.0 subdivisions: 32 for: view.
	shape color: #yourself.

	elements := shape elementsOn: {Color red. Color blue . Color green . Color white}.

	RWXZGridLayout nogap on: elements.

	view addAll: elements.
	view addInteraction: RWMouseKeyControl.
	^ view
]

{ #category : #'as yet unclassified' }
RWExample >> growingCubes [
	<script: 'self new growingCubes open'>
	| v shape es |
	v := RWView new.
	shape := RWCube new size: #yourself.
	es := shape elementsOn: (1 to: 3 by: 0.5).
	v addAll: es.
	v addInteraction: RWMouseKeyControl.
	v camera position: (WMVector3F x: 5.0 y: 0.0 z: 10.0). 
	RWXLineLayout on: es.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> highlighting [
	<script: 'self new highlighting open'>
	| v es |
	v := RWView new.
	es := ((RWCube new size: 1)) elementsOn: (1 to: 16).

	es addInteraction: (RWHighlightable highlight: [ :vv | 
		{
			vv - 1.
			vv.
			vv + 1.
			vv - 4.
			vv + 4
		}
	]).

	RWXYGridLayout on: es.
	v addAll: es.
	^	 v
]

{ #category : #'as yet unclassified' }
RWExample >> manyCubeLayout [
	<script: 'self new manyCubeLayout open'>
	| v  |
	v := RWView new.
	1 to: 100000 do: [ :i |
		v add: RWCube element.
	].

	v camera position: (WMVector3F x: 0.0 y: 0.0 z: 3.0). 
	RWCubeLayout on: v elements.

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> mediumCubeLayout [
	<script: 'self new mediumCubeLayout open'>
	| v  |
	v := RWView new.
	1 to: 9261 do: [ :i |
		v add: RWCube element.
	].

	v camera position: (WMVector3F x: 0.0 y: 0.0 z: 3.0). 
	RWCubeLayout on: v elements.

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #shapes }
RWExample >> oneCone [
	<script: 'self new oneCone open'>
	| v |
	v := RWView new.
	v add: RWCone element.
	v camera translateByZ: 3.0. 
	v  @ RWMouseKeyControl.
	^ v
]

{ #category : #shapes }
RWExample >> oneCube [
	<script: 'self new oneCube open'>
	| v |
	v := RWView new.
	v add: RWCube element.
	^ v
]

{ #category : #shapes }
RWExample >> oneCylinder [
	<script: 'self new oneCylinder open'>
	| v |
	v := RWView new.
	v add: RWCylinder element.
	v  @ RWMouseKeyControl.
	^ v
]

{ #category : #shapes }
RWExample >> onePyramid [
	<script: 'self new onePyramid open'>
	| v |
	v := RWView new.
	v add: RWPyramid element.
	v  @ RWMouseKeyControl.
	^ v open
]

{ #category : #shapes }
RWExample >> oneRedCube [
	<script: 'self new oneRedCube open'>
	| v |
	v := RWView new.
	v add: RWCube red element.
	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #shapes }
RWExample >> oneUVSphere [
	<script: 'self new onUVSphere open'>
	| v |
	v := RWView new.
	v add: RWUVSphere element.
	v  @ RWMouseKeyControl.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> someEdges [
	<script: 'self new someEdges open'>
	| v els |
	v := RWView new.

	els := RWCube blue elementsOn: (1 to: 10).
	v addAll: els.

	RWXZGridLayout on: els.

	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			i ~~ j ifTrue: [ v add: (RWLine green edgeFrom: (els at: i) to: (els at: j))]
		].
	].

	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #trees }
RWExample >> spheroids [
	<script: 'self new spheroids open'>
	| view shape |
	view := RWView new.
	shape := RWUVSphere new .
	shape width: [ :v | (v log + 1) ];
		height: [ :v | (v log + 2)];
		depth: [ :v | (v log + 3) ].

	view addAll: ( shape elementsOn: (1 to: 1000)).

	RWCubeLayout on: view elements.
	view @ RWMouseKeyControl .
	^ view
]

{ #category : #shapes }
RWExample >> threeCubes [
	<script: 'self new threeCubes open'>
	| v |
	v := RWView new.
	v add: (RWCube element).
	v add: (RWCube element).
	v add: (RWCube element).
	RWXLineLayout on: v elements.
	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> threeCubesAndLight [
	<script: 'self new threeCubesAndLight open'>
	| v |
	v := RWView new.
	v blackBackground.
	v add: (RWCube element).
	v add: (RWPointLight new color: Color red).
	v add: (RWCube element).
	v add: (RWCube element).
	RWXLineLayout on: v elements.
	v addInteraction: RWMouseKeyControl.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> threeCubesAndLightWithShadows [
	<script: 'self new threeCubesAndLightWithShadows open'>
	| v floor light|
	v := RWView new.
	v blackBackground.
	v add: (RWCube element).
	v add: (RWCube element).
	v add: (RWCube element).
	RWXLineLayout on: v elements.
	
	floor := RWCube new width: 10.0; depth: 5.0; height: 0.1; element.
	floor translateByY: -0.6.
	v add: floor.
	
	light := RWSpotLight new.
	light lookDown;
		color: Color lightGray;
		translateByX: 2.0 y: 3.0 z: 0.0;
		influenceRadius: 10.0;
		castShadows: true.
	v add: light.
	v addInteraction: RWMouseKeyControl.
	v withShadows.
	^ v
]

{ #category : #'as yet unclassified' }
RWExample >> threeCubesAndLightWithShadowsAndPhysics [
	<script: 'self new threeCubesAndLightWithShadowsAndPhysics open'>
	| v floor light|
	v := RWView new.
	v blackBackground.
	v add: (RWCube element mass: 1.0).
	v add: (RWCube element mass: 1.0).
	v add: (RWCube element mass: 1.0).
	RWXLineLayout on: v elements.

	v add: (RWCube element mass: 1.0; translateByY: 2.0; translateByX: 0.7).
		
	floor := RWCube new width: 10.0; depth: 5.0; height: 0.1; element.
	floor wall;
		translateByY: -1.0.
	v add: floor.
	
	light := RWSpotLight new.
	light lookDown;
		color: Color lightGray;
		translateByX: 2.0 y: 3.0 z: 0.0;
		influenceRadius: 10.0;
		castShadows: true.
	v add: light.
	v addInteraction: RWMouseKeyControl.
	v withShadows;
		withPhysics.
	^ v
]

{ #category : #trees }
RWExample >> translucentAlphaOverShape [
	<script: 'self new translucentAlphaOver open'>
	| view translucentShape opaqueShape elements |
	view := RWView new.

	translucentShape := 
		RWCube new
			color: (Color blue alpha: 0.8);
			alphaOverTranslucent.
	opaqueShape := RWCube red.

	elements := (translucentShape elementsOn: (1 to: 30)) , (opaqueShape elementsOn: (1 to: 30)).

	RWCubeLayout on: elements.
	view addAll: elements.
	view addInteraction: RWMouseKeyControl.
	^ view
]

{ #category : #trees }
RWExample >> translucentShape [
	<script: 'self new translucentShape open'>
	| view translucentShape opaqueShape elements |
	view := RWView new.

	"This requires a black background"
	view blackBackground.

	translucentShape := RWCube blue translucent.
	opaqueShape := RWCube red.

	elements := (translucentShape elementsOn: (1 to: 30)) , (opaqueShape elementsOn: (1 to: 30)).

	RWCubeLayout on: elements.
	view addAll: elements.
	view addInteraction: RWMouseKeyControl.
	^ view
]

{ #category : #trees }
RWExample >> treeSimple [
	<script: 'self new treeSimple open'>
	| view  objects associations elements assocWithElements|
	view := RWView new.
	objects := { 1 . 2 . 3 . 4 }.
	associations := { 1 -> 2 . 2 -> 3 . 2 -> 4 }.
	
	elements := RWCube elementsOn: objects.
	elements addInteraction: RWPopup.
	elements addInteraction: RWHighlightable.
	view addAll: elements.
	
	assocWithElements := associations collect: [ :a | (view elementFromModel: a key) -> (view elementFromModel: a value)].
	view addAll: (RWEdge linesFor: assocWithElements).
	
	RWGridTreeLayout on: view elements.
	view addInteraction: RWOrbitController.
	^ view
]
