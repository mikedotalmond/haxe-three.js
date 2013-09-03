package js.three;

interface Renderer {
	
    public var domElement : js.html.Element;
	
    function setSize(w:Int, h:Int) : Void;
		
	 @:overload(function (scene:Scene, camera:Camera, ?renderTarget:WebGLRenderTarget, ?forceClear:Bool):Void{})
     public function render(scene:Scene, camera:Camera) : Void;
}
