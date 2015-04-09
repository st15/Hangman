package com.lios.hangman.game.views.board
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.ui.assets.Assets;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;

	public class HangingManView extends ComponentView
	{
		private static function emtpyTextureFactory():Texture
		{
			return Texture.empty(225, 178)
		}
		
		private var hangmanMistakesTextures:Vector.<String> = 
			new <String>["hangman1", "hangman2", "hangman3", "hangman4",
				"hangman5", "hangman6", "hangman7", "hangman8"];
		
		private var hangman:Image;
		
		public function HangingManView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			// hanging man
			hangman = new Image(emtpyTextureFactory());
			
			var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
			colorFilter.tint(Constants.COLOR_YELLOW_CHALK, 1);
			hangman.filter = colorFilter;
			
			this.addChild(hangman);
		}
		
		override public function update(event:Event = null):void
		{
			// get data from model and update view
			var mistakes:uint = GameModel(model).mistakesCount;
			
			trace("mistakes: " + mistakes);
			
			if (mistakes != 0 && mistakes <= hangmanMistakesTextures.length)
			{
				hangman.texture = Assets.getTexture( hangmanMistakesTextures[ mistakes - 1 ] );
			}
			else
			{
				hangman.texture = emtpyTextureFactory();
			}
			
			hangman.readjustSize();
		}
	}
}