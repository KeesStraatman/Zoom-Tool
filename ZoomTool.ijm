// Macro tool for flexible zoom.
// Left mouse click zooms in; right mouse click zooms out.
// Continues zoom by keeping mouse button down.
// Save file in subfolder macros/tools and install via Plugins > Macros > Install..

// Kees Straatman, University of Leicester, 13 August 2021

var Z = 10; // Zoom increase/decrease

macro "Zoom Tool -C000T3e18Z"{
	// Need to disable right mouse click popup menu. Not sure how to check if
	// this is active but at the end of the macro this is enabled again, also when
	// originally this was not active.
	
	setOption("DisablePopupMenu", true);
	
	width = getWidth; 
	height = getHeight;
	M = getZoom(); 
	Mag = M*100;

	leftButton=16;
	rightButton=4;

	title1 = getTitle();
	
	x2=-1; y2=-1; z2=-1; flags2=-1;
	getCursorLoc(x, y, z, flags); 
	
	// Check that the Zoom Tool is still active otherwise zoom will still work when
	// another tool is selected
	while(IJ.getToolName()=="Zoom Tool"){ 
		getCursorLoc(x, y, z, flags);
		wait(100);
		if (x!=x2 || y!=y2 || z!=z2 || flags!=flags2) {
			// Left mouse click zoom in
			if (flags&leftButton!=0){
				Mag = Mag + Z; 
				run("Set... ", "zoom="+Mag+" x="+width/2+" y="+height/2);	
				
			}
			// Right mouse click zoom out
			if (flags&rightButton!=0){ 
				Mag = Mag - Z;
				run("Set... ", "zoom="+Mag+" x="+width/2+" y="+height/2);
				
			}
			
			// Collect settings new zoomed image if the image is still open
			if (isOpen(title1)){
				width = getWidth; 
				height = getHeight;
			}

			// Check if there is still an image open and it is still the same image.
			// If not get the zoom of the new image in focus and disable the Popup menu
			if (nImages==0) exit;
			else	title2 = getTitle();
				if (title1 != title2){
					M = getZoom(); 
					Mag = M*100;
					setOption("DisablePopupMenu", true);
					title2 = title1;
				
			}
			
		}
	}
	
}

macro "Zoom Tool Options"{
	Z = getNumber("Increase zoom by" ,Z);
}
