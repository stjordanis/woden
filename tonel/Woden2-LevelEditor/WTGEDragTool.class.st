Class {
	#name : #WTGEDragTool,
	#superclass : #WTGEToolController,
	#category : 'Woden2-LevelEditor'
}

{ #category : #'as yet unclassified' }
WTGEDragTool >> needsMouseCapture [
	^ true
]

{ #category : #events }
WTGEDragTool >> onDragEndEvent: anEvent [
	view toolControllerFinished
]