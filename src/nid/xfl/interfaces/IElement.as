package nid.xfl.interfaces 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.tags.IDefinitionTag;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.data.display.Color;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public interface IElement
	{
		function get type():uint;
		function get characterId():uint;
		function set characterId(value:uint):void;		
		function get matrix():Matrix;
		function set matrix(value:Matrix):void;		
		function get color():Color;
		function set color(value:Color):void;
		function get instanceName():String;
		function set instanceName(value:String):void;
		function get libraryItemName():String;
		function set libraryItemName(value:String):void;
		function publish(tags:Vector.<ITag>, property:Object):void;
		function createDisplay():DisplayObject;
		function save():void;
		function export(data:String):void;
		
	}
	
}