package nid.xfl 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import nid.xfl.compiler.factory.ElementFactory;
	import nid.xfl.compiler.swf.data.consts.BitmapFormat;
	import nid.xfl.compiler.swf.data.consts.BitmapType;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagDefineBitsJPEG2;
	import nid.xfl.compiler.swf.tags.TagDefineBitsJPEG3;
	import nid.xfl.compiler.swf.tags.TagDefineBitsLossless2;
	import nid.xfl.dom.DOMBitmapItem;
	import nid.xfl.dom.DOMDocument;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Media 
	{
		static public var bitmapLibrary:Dictionary = new Dictionary();
		
		public var bitmaps:Dictionary
		public var doc:DOMDocument;
		
		public function Media(data:XML=null,refdoc:DOMDocument=null) 
		{
			doc = refdoc;
			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			bitmaps = null;
			bitmaps = new Dictionary();
			
			for ( var i:int = 0; i < data.DOMBitmapItem.length(); i++)
			{
				var bmp_item:DOMBitmapItem = new DOMBitmapItem(XML(data.DOMBitmapItem[i]), doc);
				bmp_item.id = i;
				bitmaps[String(data.DOMBitmapItem[i].@name)] = bmp_item;
			}
		}
		public function defineBitmap(value:String, tags:Vector.<ITag>, property:Object):int
		{
			if (bitmaps[value] != undefined)
			{
				var bitmapItem:DOMBitmapItem = bitmaps[value];
			}
			else return 0;
			
			var result:Object = isBitmapInLibrary(bitmapItem);
			
			if (result.exist)
			{
				return result.bitmap.characterId;
			}
			else if(bitmaps[value] != undefined) 
			{
				var characterId:int = property.characterId;
				
				if (bitmapItem.isJPEG)
				{
					var defineJPEG2:TagDefineBitsJPEG2 = new TagDefineBitsJPEG2();
					defineJPEG2.characterId = property.characterId;
					defineJPEG2.bitmapType	= BitmapType.JPEG;
					defineJPEG2.bitmapData 	= bitmapItem.bitmapData;
					tags.push(defineJPEG2);
				}
				else if (bitmapItem.compressionType == "lossless")
				{
					var defineBitsLossless2:TagDefineBitsLossless2 = new TagDefineBitsLossless2();
					defineBitsLossless2.characterId 	= property.characterId;
					defineBitsLossless2.bitmapFormat 	= BitmapFormat.BIT_32;
					defineBitsLossless2.bitmapWidth 	= bitmapItem.bitmap.width;
					defineBitsLossless2.bitmapHeight 	= bitmapItem.bitmap.height;
					defineBitsLossless2.zlibBitmapData 	= bitmapItem.bitmapData;
					defineBitsLossless2.bitmapColorTableSize 	= 0;
					tags.push(defineBitsLossless2);
				}
				else
				{
					var defineJPEG3:TagDefineBitsJPEG3 = new TagDefineBitsJPEG3();
					defineJPEG3.characterId 	= property.characterId;
					defineJPEG3.bitmapType		= BitmapType.PNG;
					defineJPEG3.bitmapData 		= bitmapItem.bitmapData;
					defineJPEG3.bitmapAlphaData = bitmapItem.bitmapAlphaData;
					tags.push(defineJPEG3);
				}
				
				bitmapLibrary[property.characterId] = bitmaps[value];
				
				property.characterId = ++XFLCompiler.characterId;
				
				return characterId;
			}
			return 0;
		}
		public function getBitmapId(value:String):int
		{
			return bitmaps[value].id;
		}
		public function getBitmapByName(value:String):Bitmap
		{
			return bitmaps[value] == undefined?null:bitmaps[value].bitmap;
		}
		public function getBitmapById(id:int):Bitmap
		{
			for each (var bmp:DOMBitmapItem in bitmaps)
			{
				if (bmp.id == id)
				{
					return bmp.bitmap;
				}
			}
			
			return null;
		}
		
		public function isBitmapInLibrary(bitmapItem:DOMBitmapItem):Object
		{
			for each(var _bitmap:DOMBitmapItem in bitmapLibrary)
			{
				if(_bitmap.name == bitmapItem.name)
				{
					return { exist:true, bitmap:_bitmap };
				}
			}
			return { exist:false };
		}
	}

}