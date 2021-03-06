Class {
	#name : #WDGSPhysicsCharacterControllerBehavior,
	#superclass : #WDGSBehavior,
	#instVars : [
		'angle',
		'linearVelocity',
		'linearAcceleration',
		'angularVelocity',
		'angularAcceleration',
		'movingInGrounding',
		'collisionShape',
		'ghostObject',
		'physicsCharacterController'
	],
	#category : #'WodenEngine-GameSystem-Player'
}

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> angularAcceleration [
	^ angularAcceleration
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> angularAcceleration: anObject [
	angularAcceleration := anObject
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> angularVelocity [
	^ angularVelocity
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> angularVelocity: anObject [
	angularVelocity := anObject
]

{ #category : #actions }
WDGSPhysicsCharacterControllerBehavior >> canJump [
	^ physicsCharacterController canJump
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> characterGroundGravity [
	^ -9.8
]

{ #category : #'map events' }
WDGSPhysicsCharacterControllerBehavior >> createCharacterController [
	physicsCharacterController := WDPhyCharacterController new
		ghostObject: ghostObject;
		shape: collisionShape;
		yourself.
	self validDynamicsWorld addCharacterController: physicsCharacterController
]

{ #category : #'map events' }
WDGSPhysicsCharacterControllerBehavior >> createCollisionShape [
	collisionShape := WDPhyCapsuleYCollisionShape new height: 1.6; radius: 0.30; yourself
]

{ #category : #wrappers }
WDGSPhysicsCharacterControllerBehavior >> createGhostObject [
	ghostObject := WDPhyGhostObjectWithPairCache new.
	ghostObject shape: collisionShape;
		position: entity spatialDescription transform translation asWMVector3F.

	self validDynamicsWorld addGhostObject: ghostObject
]

{ #category : #actions }
WDGSPhysicsCharacterControllerBehavior >> crouch [
	self flag: 'TODO: Implement myself'.
]

{ #category : #initialization }
WDGSPhysicsCharacterControllerBehavior >> initialize [
	super initialize.
	angle := WMVector3D new.
	angularVelocity := WMVector3D new.
	angularAcceleration := WMVector3D new.
	linearVelocity := WMVector3D new.
	linearAcceleration := WMVector3D new.
	movingInGrounding := true.
]

{ #category : #actions }
WDGSPhysicsCharacterControllerBehavior >> jump [
	^ physicsCharacterController jump
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> linearAcceleration [
	^ linearAcceleration
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> linearAcceleration: anObject [
	linearAcceleration := anObject
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> linearVelocity [
	^ linearVelocity
]

{ #category : #accessing }
WDGSPhysicsCharacterControllerBehavior >> linearVelocity: anObject [
	linearVelocity := anObject
]

{ #category : #'map events' }
WDGSPhysicsCharacterControllerBehavior >> simulatePrePhysicsTime: delta [
	| orientation spatialDesc |
	linearVelocity := linearAcceleration * delta + linearVelocity.
	angularVelocity := angularAcceleration * delta + angularVelocity.

	angle := angle + (angularVelocity * delta).
	movingInGrounding ifTrue: [
		orientation := (WMMatrix3D yrot: angle y).
	] ifFalse: [
		orientation := (WMMatrix3D yrot: angle y) * (WMMatrix3D xrot: angle x).
	].

	physicsCharacterController
		gravity: (movingInGrounding ifTrue: [ self characterGroundGravity ] ifFalse: [0.0]);
		linearVelocity: (orientation transformVector3: linearVelocity) asWMVector3F.
	
	spatialDesc := entity spatialDescription.
	spatialDesc transform
			orthonormal: orientation.
	spatialDesc changed.
]

{ #category : #'map events' }
WDGSPhysicsCharacterControllerBehavior >> simulateTime: delta [
	| spatialDesc |
	spatialDesc := entity spatialDescription.
	spatialDesc transform
			translation: ghostObject position asWMVector3D.
	spatialDesc changed.
]

{ #category : #'map events' }
WDGSPhysicsCharacterControllerBehavior >> spawn [
	self
		subscribeToPrePhysicsTimeEvents;
		subscribeToTimeEvents;
		createCollisionShape;
		createGhostObject;
		createCharacterController.
]
