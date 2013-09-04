package js;

import js.Browser;
import js.html.Element;

/**
 * @author alteredq / http://alteredqualia.com/
 * @author mr.doob / http://mrdoob.com/
 */

/**
 * Ported from Detector.js - https://github.com/mrdoob/three.js/tree/master/examples/js/
 *
 * Usage:
 * if (!Detector.webgl) Detector.addGetWebGLMessage();
 */

 typedef MessageParameters = {
	parent	:Element,
	id		:String,
 }

class Detector {

	public static var webgl		(get_webgl, null):Bool;
	public static var canvas	(get_canvas, null):Bool;
	public static var workers	(get_workers, null):Bool;
	public static var fileapi	(get_fileapi, null):Bool;
	
	static function get_fileapi():Bool {
		return untyped __js__("window.File && window.FileReader && window.FileList && window.Blob");
	}
	
	static function get_workers():Bool {
		return untyped __js__("!!window.Worker");
	}
	
	static inline function get_canvas():Bool {
		return untyped __js__("!!window.CanvasRenderingContext2D");
	}
	
	static function get_webgl():Bool {
		var gl = false;
		try { gl = untyped __js__("!!window.WebGLRenderingContext && !!document.createElement('canvas').getContext('experimental-webgl')");
		} catch ( e:Dynamic ) { gl = false; }
		return gl;
	}
	
	
	public static function addWebGLErrorMessage ( ?parameters:MessageParameters = null ) {

		var parent:Element, id:String, element:Element;

		parameters = parameters==null ? {id:null, parent:null} : parameters;
		
		parent 	= parameters.parent != null ? parameters.parent : Browser.document.body;
		id 		= parameters.id 	!= null ? parameters.id 	: 'oldie';
		
		element 	= Detector.getWebGLErrorMessage();
		element.id 	= id;
		
		parent.appendChild( element );
	}
	
	
	static function getWebGLErrorMessage():Element {
		
		var element = Browser.document.createElement( 'div' );
		element.id = 'webgl-error-message';
		element.style.fontFamily = 'monospace';
		element.style.fontSize = '13px';
		element.style.fontWeight = 'normal';
		element.style.textAlign = 'center';
		element.style.background = '#fff';
		element.style.color = '#000';
		element.style.padding = '1.5em';
		element.style.width = '400px';
		element.style.margin = '5em auto 0';
		
		if (!Detector.webgl) {
			element.innerHTML = untyped __js__("window.WebGLRenderingContext") ? [
				'Your graphics card does not seem to support <a href="http://khronos.org/webgl/wiki/Getting_a_WebGL_Implementation" style="color:#000">WebGL</a>.<br />',
				'Find out how to get it <a href="http://get.webgl.org/" style="color:#000">here</a>.'
			].join( '\n' ) : [
				'Your browser does not seem to support <a href="http://khronos.org/webgl/wiki/Getting_a_WebGL_Implementation" style="color:#000">WebGL</a>.<br/>',
				'Find out how to get it <a href="http://get.webgl.org/" style="color:#000">here</a>.'
			].join( '\n' );
		}

		return element;
	}
}