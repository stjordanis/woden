binding
bindTexture: slot renderTarget: renderTarget startMiplevel: startMipLevel miplevels: mipLevels lodclamp: lodClamp
	self slotAt: slot + 1 put: [
		self validHandle bindTexture: slot texture: renderTarget currentFramebuffer colorAttachments first validHandle startMiplevel: startMipLevel miplevels: mipLevels lodclamp: lodClamp
	].