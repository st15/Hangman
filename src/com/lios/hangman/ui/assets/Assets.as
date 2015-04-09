package com.lios.hangman.ui.assets 
{
	import flash.filesystem.File;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Assets
	{
		public static const assetManager:AssetManager = new AssetManager();
		
		public static function getTexture(name:String):Texture
		{
			return assetManager.getTexture(name);
		}
		
		public static function playSound(name:String):SoundChannel
		{
			return assetManager.playSound(name, 0, 0, SoundMixer.soundTransform);
		}
		
		/**
		 * Loads the assets and when all are loaded dispatches Event.COMPLETE
		 */
		public static function loadAssets():void
		{
			EmbeddedAssets.init();
			
			assetManager.verbose = false;
			var appDir:File = File.applicationDirectory;
			assetManager.enqueue(appDir.resolvePath("assets/loaded"));
			assetManager.scaleFactor = 1;
			
			// -> now load all the enqueued assets. When "ratio" equals "1", we are finished.
			assetManager.loadQueue(function (ratio:Number):void {
				if (ratio == 1.0)
				{
					assetManager.dispatchEventWith(Event.COMPLETE);
				}
			});
		}
	}
}
import flash.text.Font;

class EmbeddedAssets
{   
	[Embed(source="/../../../../../assets/embedded/Flow_B.otf",
			fontName="HandWritingFont", 	//		unicodeRange="U+0030-U+0039",
			fontWeight="Bold",
			advancedAntiAliasing = "true",
			embedAsCFF="false",
			mimeType = "application/x-font")]         
	public static const HandWritingFont:Class;    
	
	public static function init():void
	{
		Font.registerFont(HandWritingFont);
	}
}