package com.lios
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * Splash screen shown before the game is loaded and initialized.
	 */
	public class Splash extends MovieClip
	{
		[Embed(source="/../../assets/embedded/splash.png")]
		public static const SplashBitmap:Class;
		
		private var image:Bitmap;
		private var background:Shape;
		
		public function Splash()
		{	
			background = new Shape();
			addChild(background);
			image = new SplashBitmap() as Bitmap;
			addChild(image);
			addEventListener(flash.events.Event.ADDED_TO_STAGE, hasStage);
		}
		
		private function hasStage(event:Event):void
		{
			resize_handler(null);
			
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, hasStage);
			addEventListener(flash.events.Event.RESIZE, resize_handler, false, 0, true);
		}
		
		protected function resize_handler(event:Event):void
		{
			var screenWidth:Number;
			var screenHeight:Number;
			if (stage.fullScreenWidth > stage.fullScreenHeight)
			{
				screenWidth = stage.fullScreenWidth;
				screenHeight = stage.fullScreenHeight;
			}
			else
			{
				screenWidth = stage.fullScreenHeight;
				screenHeight = stage.fullScreenWidth;
			}
			
			background.graphics.beginFill(stage.color);
			background.graphics.drawRect(0, 0, screenWidth, screenHeight);
			background.graphics.endFill();
			image.x = (screenWidth - image.width) * 0.5;
			image.y = (screenHeight - image.height) * 0.5;
		}
	}
}