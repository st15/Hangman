package com.lios.hangman.ui
{
	import com.lios.hangman.Constants;
	
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.utils.VAlign;
	import com.lios.hangman.ui.assets.Assets;
	
	public class LetterButton extends Button
	{
		public function LetterButton(letter:String="")
		{
			const size:Number = 60;
			
			var upState:Texture = Texture.empty(size, size);
			var downState:Texture = Assets.getTexture("buttonLetter"); //Texture.fromColor(size, size, 0x44ffffff);
			
			super(upState, letter, downState);
			
			this.fontSize = Constants.FONT_SIZE;
			this.fontColor = 0xffffff;
			this.textVAlign = VAlign.TOP;
			this.fontName = Constants.CHALK_FONT_NAME;
		}
	}
}