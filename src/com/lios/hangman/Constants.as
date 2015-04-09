package com.lios.hangman
{
	import flash.filters.DropShadowFilter;

	public class Constants
	{
		// game dimensions
		public static const GAME_WIDTH:Number = 960;
		public static const GAME_HEIGHT:Number = 640;
		public static const BASE_BG_WIDTH:Number = 1280;
		public static const BASE_BG_HEIGHT:Number = 800;
		public static const TABLET_4_3_BASE_WIDTH:Number = 1024;
		
		// game settings
		public static const MAX_MISTAKES:uint = 8;
		public static const TIME:int = 60;
		
		// ads settings
		public static const INTERSTITIAL_SHOW_RATE:Number = 0.25; // percent of games to show interstitial
		public static const INTERSTITIAL_SHOW_RATE_MORE:Number = 0.4;
		
		// google play settings
		public static const GOOGLE_PLAY_URL:String = "market://details?id=air.com.lios.hangman";
		
		// sounds
		public static const SOUND_BUTTON:String = "chalkboard";
		public static const SOUND_MISTAKE:String = "chalkboard";
		public static const SOUND_GAME_OVER:String = "shortbell";
		public static const SOUND_WIN:String = "kids_shout";
		public static const SOUND_ROLL_SCREEN:String = "poster_unroll_002";
		public static const SOUND_CORRECT:String = "click";
		
		// text filters
		public static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 45, 0x333300, 0.5, 8, 8, 1);
		
		// font names
		public static const CHALK_FONT_NAME:String = "chalkCyrillic";
		public static const FONT_HANDWRITTEN:String = "HandWritingFont";
		
		// font sizes
		public static const FONT_SIZE:uint = 43;
		public static const TIMER_FONT_SIZE:uint = 65; 
		public static const BUTTON_FONT_SIZE:uint = 38;
		public static const MEDIUM_FONT_SIZE:uint = 38;
		public static const FONT_SIZE_LARGE:uint = 46;
		
		// colors
		public static const COLOR_GREEN:uint = 0x669933;
		public static const COLOR_TIMER_FONT:uint = 0xFFE87C;
		public static const COLOR_YELLOW_CHALK:uint = 0xFFE87C;
		public static const COLOR_YELLOW_FONT:uint = 0xFFE87C;
		public static const COLOR_DARK_FONT:uint = 0x594255;
		public static const COLOR_LIGHT_FONT:uint = 0x8C4A62;
		public static const COLOR_RED_FONT:uint = 0xFF714e;
		public static const COLOR_DARK:uint = 0x333333;
		public static const COLOR_DARK_GREEN:uint = 0x24534F;
		public static const COLOR_WORD_LOSE:uint = 0xF4694C; 
		public static const COLOR_WHITE:uint = 0xffffff;
	}
}