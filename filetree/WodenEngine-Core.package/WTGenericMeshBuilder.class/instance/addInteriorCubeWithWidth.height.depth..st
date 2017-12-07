adding
addInteriorCubeWithWidth: width height: height depth: depth
	| px py pz nx ny nz |
	self beginTriangles.
	
	px := width * 0.5.
	py := height * 0.5.
	pz := depth * 0.5.
	nx := width * -0.5.
	ny := height * -0.5.
	nz := depth * -0.5.
	
	"Back Face"
	self addP: (WMVector3F x: px y: py z: nz)  N: (WMVector3F x: 0.0 y: 0.0 z: -1.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: px y: ny z: nz)  N: (WMVector3F x: 0.0 y: 0.0 z: -1.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: nx y: ny z: nz)  N: (WMVector3F x: 0.0 y: 0.0 z: -1.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: nx y: py z: nz)  N: (WMVector3F x: 0.0 y: 0.0 z: -1.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 3 i2: 2 i3: 1.
	self addI1: 1 i2: 4 i3: 3.
	
	"Front Face"
	self addP: (WMVector3F x: px y: py z: pz)  N: (WMVector3F x: 0.0 y: 0.0 z: 1.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: nx y: py z: pz)  N: (WMVector3F x: 0.0 y: 0.0 z: 1.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: nx y: ny z: pz)  N: (WMVector3F x: 0.0 y: 0.0 z: 1.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: px y: ny z: pz)  N: (WMVector3F x: 0.0 y: 0.0 z: 1.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 7 i2: 6 i3: 5.
	self addI1: 5 i2: 8 i3: 7.

	"Top Face"
	self addP: (WMVector3F x: px y: py z: pz)  N: (WMVector3F x: 0.0 y: 1.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: px y: py z: nz)  N: (WMVector3F x: 0.0 y: 1.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: nx y: py z: nz)  N: (WMVector3F x: 0.0 y: 1.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: nx y: py z: pz)  N: (WMVector3F x: 0.0 y: 1.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 11 i2: 10 i3: 9.
	self addI1: 9 i2: 12 i3: 11.
	
	"Bottom Face"
	self addP: (WMVector3F x: px y: ny z: pz)  N: (WMVector3F x: 0.0 y: -1.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: nx y: ny z: pz)  N: (WMVector3F x: 0.0 y: -1.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: nx y: ny z: nz)  N: (WMVector3F x: 0.0 y: -1.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: px y: ny z: nz)  N: (WMVector3F x: 0.0 y: -1.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 15 i2: 14 i3: 13.
	self addI1: 13 i2: 16 i3: 15.

	"Left Face"
	self addP: (WMVector3F x: nx y: ny z: pz)  N: (WMVector3F x: -1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: nx y: py z: pz)  N: (WMVector3F x: -1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: nx y: py z: nz)  N: (WMVector3F x: -1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: nx y: ny z: nz)  N: (WMVector3F x: -1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 19 i2: 18 i3: 17.
	self addI1: 17 i2: 20 i3: 19.

	"Right Face"
	self addP: (WMVector3F x: px y: py z: pz)  N: (WMVector3F x: 1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 1.0).
	self addP: (WMVector3F x: px y: ny z: pz)  N: (WMVector3F x: 1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 1.0).
	self addP: (WMVector3F x: px y: ny z: nz)  N: (WMVector3F x: 1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 1.0 y: 0.0).
	self addP: (WMVector3F x: px y: py z: nz)  N: (WMVector3F x: 1.0 y: 0.0 z: 0.0 ) TC: (WMVector2F x: 0.0 y: 0.0).
	self addI1: 23 i2: 22 i3: 21.
	self addI1: 21 i2: 24 i3: 23.