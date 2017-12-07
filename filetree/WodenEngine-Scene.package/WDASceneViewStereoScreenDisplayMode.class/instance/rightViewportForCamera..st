multi eye rendering
rightViewportForCamera: camera
	| cameraState |
	cameraState := WTCameraState new.
	cameraState
		projectionMatrix: rightProjectionMatrix.
	
	^ WTSViewport new
		camera: camera;
		cameraState: cameraState;
		renderTarget: rightRenderTarget;
		resolveRenderTarget: rightResolveRenderTarget;
		bounds: rightRenderTarget bounds;
		cameraTransformFunction: [ :ct | ct transformTransform: self rightCameraTransform ];
		submode: #full