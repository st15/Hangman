package com.lios.hangman.ui.themes
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.ui.assets.Assets;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.ToggleButton;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.core.PopUpManager;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.StyleNameFunctionTheme;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.Color;

	public class LightHangmanTheme extends StyleNameFunctionTheme
	{
		
		/**
		 * The name of the embedded font used by controls in this theme. Comes
		 * in normal and bold weights.
		 */
		public static const FONT_NAME:String = Constants.FONT_HANDWRITTEN;
		
		protected static const PRIMARY_BACKGROUND_COLOR:uint = Constants.COLOR_GREEN;
		protected static const LIGHT_TEXT_COLOR:uint = Color.WHITE; 
		protected static const YELLOW_TEXT_COLOR:uint = Constants.COLOR_YELLOW_FONT; 
		protected static const DARK_TEXT_COLOR:uint = Constants.COLOR_DARK_GREEN; 
		protected static const MODAL_OVERLAY_COLOR:uint = Color.BLACK; 
		protected static const MODAL_OVERLAY_ALPHA:Number = 0.4;
		
		/**
		 * The screen density of an iPhone with Retina display. The textures
		 * used by this theme are designed for this density and scale for other
		 * densities.
		 */
		public static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		
		/**
		 * The screen density of an iPad with Retina display. The textures used
		 * by this theme are designed for this density and scale for other
		 * densities.
		 */
		public static const ORIGINAL_DPI_IPAD_RETINA:int = 264;
		
		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
		protected static const TOGGLE_SCALE9_GRID:Rectangle = new Rectangle(15, 11, 45, 45);
		
		protected static const TOGGLE_TRACK_SCALE9_GRID:Rectangle = new Rectangle(50, 10, 50, 56);
		
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(10, 10, 40, 40);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 44, 44);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;
		
		
		/**
		 * @private
		 * The theme's custom style name for buttons in an Alert's button group.
		 */
		protected static const THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON:String = "hangman-mobile-alert-button-group-button";
		public static const THEME_STYLE_NAME_BLANK_ALERT:String = "hangman-mobile-blank-alert";
		public static const THEME_STYLE_NAME_TEXT_BUTTON:String = "hangman-mobile-text-button";
		public static const THEME_STYLE_NAME_SETTINGS_LAYOUT_GROUP:String = "hangman-mobile-settings-layout-group";
		public static const THEME_STYLE_NAME_SETTINGS_BUTTON:String = "hangman-mobile-settings-button";
		public static const THEME_STYLE_NAME_CLOSE_BUTTON:String = "hangman-mobile-close-button";
		public static const THEME_STYLE_NAME_FACEBOOK_BUTTON:String = "hangman-facebook-sound-button";
		public static const THEME_STYLE_NAME_SCALED_TO_DPI_PANEL:String = "hangman-mobile-scaled-to-dpi-panel";
		public static const THEME_STYLE_NAME_SCALED_TO_DPI_HEADER:String = "hangman-mobile-scaled-to-dpi-header";
		public static const THEME_STYLE_NAME_SCALED_TO_DPI_LABEL:String = "hangman-mobile-scaled-to-dpi-label";
		public static const THEME_STYLE_NAME_SCALED_TO_DPI_TOGGLE_SWITCH:String = "hangman-mobile-scaled-to-dpi-toggle-switch";
		
		/**
		 * @private
		 * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String = "hangman-mobile-horizontal-simple-scroll-bar-thumb";
		
		/**
		 * @private
		 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
		 */
		protected static const THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "hangman-mobile-vertical-simple-scroll-bar-thumb";
		
		/**
		 * The default global text renderer factory for this theme creates a
		 * TextBlockTextRenderer.
		 */
		protected static function textRendererFactory():ITextRenderer
		{
			var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.embedFonts = true;
			renderer.isHTML = true;
			renderer.snapToPixels = true;
			return renderer;
		}
		
		/**
		 * The default global text editor factory for this theme creates a
		 * StageTextTextEditor.
		 */
		protected static function textEditorFactory():StageTextTextEditor
		{
			return new StageTextTextEditor();
		}
		
		/**
		 * The text editor factory for a NumericStepper creates a
		 * TextBlockTextEditor.
		 */
		protected static function stepperTextEditorFactory():TextFieldTextEditor
		{
			//we're only using this text editor in the NumericStepper because
			//isEditable is false on the TextInput. this text editor is not
			//suitable for mobile use if the TextInput needs to be editable
			//because it can't use the soft keyboard or other mobile-friendly UI
			return new TextFieldTextEditor();
		}
		
		/**
		 * This theme's scroll bar type is SimpleScrollBar.
		 */
		protected static function scrollBarFactory():SimpleScrollBar
		{
			return new SimpleScrollBar();
		}
		
		protected static function popUpOverlayFactory():DisplayObject
		{
			var quad:Quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
			quad.alpha = MODAL_OVERLAY_ALPHA;
			return quad;
		}
		
		/**
		 * SmartDisplayObjectValueSelectors will use ImageLoader instead of
		 * Image so that we can use extra features like pixel snapping.
		 */
		protected static function textureValueTypeHandler(value:Texture, oldDisplayObject:DisplayObject = null):DisplayObject
		{
			var displayObject:ImageLoader = oldDisplayObject as ImageLoader;
			if(!displayObject)
			{
				displayObject = new ImageLoader();
			}
			
			displayObject.source = value;
			return displayObject;
		}
		
		/**
		 * Constructor.
		 */
		public function LightHangmanTheme()
		{
			this.initialize();
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		/**
		 * @private
		 */
		protected var _originalDPI:int;
		
		/**
		 * The original screen density used for scaling.
		 */
		public function get originalDPI():int
		{
			return this._originalDPI;
		}
		
		/**
		 * Some skins are scaled by a value based on the screen density on the
		 * content scale factor.
		 */
		protected var dpiScale:Number = 1;
		
		/**
		 * A smaller font size for details.
		 */
		protected var smallFontSize:int;
		
		/**
		 * A normal font size.
		 */
		protected var regularFontSize:int;
		
		/**
		 * An extra large font size.
		 */
		protected var largeFontSize:int;
		
		/**
		 * An extra extra large font size.
		 */
		protected var extraLargeFontSize:int;
		
		/**
		 * The size, in pixels, of major regions in the grid. Used for sizing
		 * containers and larger UI controls.
		 */
		protected var gridSize:int;
		
		/**
		 * The size, in pixels, of minor regions in the grid. Used for larger
		 * padding and gaps.
		 */
		protected var gutterSize:int;
		
		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var smallGutterSize:int;
		
		/**
		 * The width, in pixels, of UI controls that span across multiple grid regions.
		 */
		protected var wideControlSize:int;
		
		/**
		 * The size, in pixels, of a typical UI control.
		 */
		protected var controlSize:int;
		
		/**
		 * The size, in pixels, of smaller UI controls.
		 */
		protected var smallControlSize:int;
		
		protected var popUpFillHeight:int;
		protected var popUpFillWidth:int;
		protected var calloutBackgroundMinSize:int;
		protected var scrollBarGutterSize:int;
		
		/**
		 * ScrollText uses TextField instead of FTE, so it has a separate TextFormat.
		 */
		protected var scrollTextTextFormat:TextFormat;
		
		protected var headerTextFormat:TextFormat;
		protected var scaledHeaderTextFormat:TextFormat;
		protected var scaledTextFormat:TextFormat;
		protected var scaledLightUITextFormat:TextFormat;
		protected var textButtonTextFormat:TextFormat;
		
		protected var largeLightTextFormat:TextFormat;
		protected var darkTextFormat:TextFormat;
		protected var lightTextFormat:TextFormat;
		
		/**
		 * The texture atlas that contains skins for this theme. This base class
		 * does not initialize this member variable. Subclasses are expected to
		 * load the assets somehow and set the <code>atlas</code> member
		 * variable before calling <code>initialize()</code>.
		 */
		protected var atlas:TextureAtlas;
		
		protected var backgroundToggleSwitchOnSkinTextures:Scale9Textures;
		protected var backgroundToggleSwitchOffSkinTextures:Scale9Textures;
		protected var buttonToggleSwitchUpSkinTextures:Scale9Textures;
		protected var buttonToggleSwitchDownSkinTextures:Scale9Textures;
		protected var buttonFacebookSkinTexture:Texture;
		protected var buttonSettingsUpSkinTexture:Texture;
		protected var buttonSettingsDownSkinTexture:Texture;
		protected var buttonCloseUpSkinTexture:Texture;
		protected var buttonCloseDownSkinTexture:Texture;
		protected var headerBackgroundSkinTexture:Texture;
		
		protected var backgroundSkinTextures:Scale9Textures;
		protected var backgroundLayoutGroupSkinTextures:Scale9Textures;
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		
		protected var backgroundPopUpSkinTextures:Scale9Textures;
		protected var calloutTopArrowSkinTexture:Texture;
		protected var calloutRightArrowSkinTexture:Texture;
		protected var calloutBottomArrowSkinTexture:Texture;
		protected var calloutLeftArrowSkinTexture:Texture;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;
		protected var searchIconTexture:Texture;
		
		/**
		 * Disposes the atlas before calling super.dispose()
		 */
		override public function dispose():void
		{
			if(this.atlas)
			{
				this.atlas.dispose();
				this.atlas = null;
			}
			
			//don't forget to call super.dispose()!
			super.dispose();
		}
		
		/**
		 * Initializes the theme. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		protected function initialize():void
		{
			this.initializeScale();
			this.initializeDimensions();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();
			this.initializeStage();
			this.initializeStyleProviders();
		}
		
		/**
		 * Sets the stage background color.
		 */
		protected function initializeStage():void
		{
			Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
		}
		
		/**
		 * Initializes global variables (not including global style providers).
		 */
		protected function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;
			
			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePadding = this.smallGutterSize;
		}
		
		/**
		 * Initializes the scale value based on the screen density and content
		 * scale factor.
		 */
		protected function initializeScale():void
		{
			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;
			
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
			}
			else
			{
				this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
			}
			this.dpiScale = scaledDPI / this._originalDPI;
		}
		
		/**
		 * Initializes common values used for setting the dimensions of components.
		 */
		protected function initializeDimensions():void
		{
			this.gridSize = 88;
			this.smallGutterSize = 11;
			this.gutterSize = 30;
			this.controlSize = 58;
			this.smallControlSize = 22;
			this.popUpFillHeight = 572;
			this.popUpFillWidth = 652;
			this.calloutBackgroundMinSize = 11;
			this.scrollBarGutterSize = 4;
			this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
		}
		
		/**
		 * Initializes font sizes and formats.
		 */
		protected function initializeFonts():void
		{
			this.smallFontSize = 26;
			this.regularFontSize = 40;
			this.largeFontSize = 50;
			this.extraLargeFontSize = 130;
			
			//scaled 
			this.scaledTextFormat = new TextFormat(FONT_NAME, Math.round(this.largeFontSize * dpiScale), DARK_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.LEFT, 10, 10);
			this.scaledHeaderTextFormat = new TextFormat(FONT_NAME, Math.round(50 * dpiScale), DARK_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.LEFT, 10, 10);
			this.scaledLightUITextFormat = new TextFormat(FONT_NAME, Math.round(38 * dpiScale), LIGHT_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.LEFT, 10, 10);
			
			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat("_sans", this.smallFontSize, Color.GRAY);
			
			this.textButtonTextFormat = new TextFormat(FONT_NAME, this.extraLargeFontSize, YELLOW_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.CENTER, 4, 4);
			
			this.headerTextFormat = new TextFormat(FONT_NAME, this.largeFontSize, DARK_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.CENTER, 10, 10);
			
			this.darkTextFormat = new TextFormat(FONT_NAME, this.regularFontSize, DARK_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.CENTER, 10, 10);
			this.lightTextFormat = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.LEFT, 10, 10);
			
			this.largeLightTextFormat = new TextFormat(FONT_NAME, this.largeFontSize, LIGHT_TEXT_COLOR, null, null, null, null, null, TextFormatAlign.CENTER, 10, 10);
		}
		
		/**
		 * Initializes the textures by extracting them from the atlas and
		 * setting up any scaling grids that are needed.
		 */
		protected function initializeTextures():void
		{
			var backgroundSkinTexture:Texture = Assets.getTexture("background-skin");
			var backgroundlayoutGroupSkinTexture:Texture = Assets.getTexture("background-border-skin");
			var backgroundPopUpSkinTexture:Texture = Assets.getTexture("background-skin");
			
			this.backgroundSkinTextures = new Scale9Textures(backgroundSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundLayoutGroupSkinTextures = new Scale9Textures(backgroundlayoutGroupSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundPopUpSkinTextures = new Scale9Textures(backgroundPopUpSkinTexture, DEFAULT_SCALE9_GRID);
			
			this.buttonUpSkinTextures = new Scale9Textures(Assets.getTexture("normal"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(Assets.getTexture("pressed"), BUTTON_SCALE9_GRID);
			
			this.buttonFacebookSkinTexture = Assets.getTexture("facebook3");
			this.buttonSettingsUpSkinTexture = Assets.getTexture("settings-up");
			this.buttonSettingsDownSkinTexture = Assets.getTexture("settings-down");
			this.buttonCloseUpSkinTexture = Assets.getTexture("close-up");
			this.buttonCloseDownSkinTexture = Assets.getTexture("close-down");
			
			this.backgroundToggleSwitchOnSkinTextures = new Scale9Textures(Assets.getTexture("toggle-switch-track-on"), TOGGLE_TRACK_SCALE9_GRID);
			this.backgroundToggleSwitchOffSkinTextures = new Scale9Textures(Assets.getTexture("toggle-switch-track-off"), TOGGLE_TRACK_SCALE9_GRID);
			this.buttonToggleSwitchUpSkinTextures = new Scale9Textures(Assets.getTexture("toggle-switch-button"), TOGGLE_SCALE9_GRID);
			this.buttonToggleSwitchDownSkinTextures = new Scale9Textures(Assets.getTexture("toggle-switch-button"), TOGGLE_SCALE9_GRID);

			this.headerBackgroundSkinTexture = Assets.getTexture("header-background-skin");
			
			this.calloutTopArrowSkinTexture = Assets.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = Assets.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = Assets.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = Assets.getTexture("callout-arrow-left-skin");
			
			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(Assets.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(Assets.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);
		}
		
		/**
		 * Sets global style providers for all components.
		 */
		protected function initializeStyleProviders():void
		{
			//alert
			this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
			this.getStyleProviderForClass(Alert).setFunctionForStyleName(THEME_STYLE_NAME_BLANK_ALERT, this.setBlankAlertStyles);
			this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON, this.setAlertButtonGroupButtonStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setHeaderWithoutBackgroundStyles);
			this.getStyleProviderForClass(TextFieldTextRenderer).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE, this.setAlertMessageTextRendererStyles);
			this.getStyleProviderForClass(TextFieldTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SCALED_TO_DPI_PANEL, this.setScaledToDpiTextRendererStyles);
			
			//button
			this.getStyleProviderForClass(Button).defaultStyleFunction = this.setButtonStyles;
			
			//custom buttons
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_TEXT_BUTTON, this.setTextButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_CLOSE_BUTTON, this.setCloseButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_SETTINGS_BUTTON, this.setSettingsButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_FACEBOOK_BUTTON, this.setFacebookButtonStyles);
			
			//button group
			this.getStyleProviderForClass(ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
			
			//callout
			this.getStyleProviderForClass(Callout).defaultStyleFunction = this.setCalloutStyles;
			
			//header
			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;
			
			//labels
			this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_HEADING, this.setHeadingLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName(THEME_STYLE_NAME_SCALED_TO_DPI_LABEL, this.setScaledLabelStyles);
			
			//layout group
			this.getStyleProviderForClass(LayoutGroup).setFunctionForStyleName(LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR, setToolbarLayoutGroupStyles);
			this.getStyleProviderForClass(LayoutGroup).setFunctionForStyleName(THEME_STYLE_NAME_SETTINGS_LAYOUT_GROUP, setSettingsLayoutGroupStyles);
			
			//panel
			this.getStyleProviderForClass(Panel).defaultStyleFunction = this.setPanelStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Panel.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setHeaderWithoutBackgroundStyles);
			
			//panel screen
			this.getStyleProviderForClass(PanelScreen).defaultStyleFunction = this.setPanelStyles;
			this.getStyleProviderForClass(PanelScreen).setFunctionForStyleName(THEME_STYLE_NAME_SCALED_TO_DPI_PANEL, this.setScaledPanelScreenStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName(THEME_STYLE_NAME_SCALED_TO_DPI_HEADER, this.setScaledPanelScreenHeaderStyles);
			
			//scroll container
			this.getStyleProviderForClass(ScrollContainer).defaultStyleFunction = this.setScrollContainerStyles;
			this.getStyleProviderForClass(ScrollContainer).setFunctionForStyleName(ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR, this.setToolbarScrollContainerStyles);
			
			//scroll text
			this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;
			
			//simple scroll bar
			this.getStyleProviderForClass(SimpleScrollBar).defaultStyleFunction = this.setSimpleScrollBarStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB, this.setHorizontalSimpleScrollBarThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB, this.setVerticalSimpleScrollBarThumbStyles);
			
			//toggle switch
			this.getStyleProviderForClass(ToggleSwitch).defaultStyleFunction = this.setScaledToggleSwitchStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setScaledToggleSwitchButtonStyles);
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setScaledToggleSwitchButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK, this.setScaledToggleSwitchTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_OFF_TRACK, this.setScaledToggleSwitchOffTrackStyles);
		}
		
		protected function imageLoaderFactory():ImageLoader
		{
			var image:ImageLoader = new ImageLoader();
//			image.textureScale = this.scale;
			return image;
		}
		
		//-------------------------
		// Shared
		//-------------------------
		protected function setScrollerStyles(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = scrollBarFactory;
			scroller.verticalScrollBarFactory = scrollBarFactory;
		}
		
		protected function setSimpleButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = button.minTouchHeight = this.gridSize;
		}
		
		//-------------------------
		// Alert
		//-------------------------
		protected function setAlertStyles(alert:Alert):void
		{
			this.setScrollerStyles(alert);
			
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures);
			alert.backgroundSkin = backgroundSkin;
			
			alert.paddingTop = 0;
			alert.paddingRight = this.gutterSize;
			alert.paddingBottom = this.smallGutterSize;
			alert.paddingLeft = this.gutterSize;
			alert.gap = this.smallGutterSize;
			alert.maxWidth = this.popUpFillWidth;
			alert.maxHeight = this.popUpFillHeight;
		}
		
		protected function setBlankAlertStyles(alert:Alert):void
		{
			alert.backgroundSkin = null;
			
			alert.paddingTop = 0;
			alert.paddingRight = 0;
			alert.paddingBottom = 0;
			alert.paddingLeft = 0;
			alert.gap = 0;
		}
		//see Panel section for Header styles
		
		protected function setAlertButtonGroupStyles(group:ButtonGroup):void
		{
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = this.smallGutterSize;
			group.padding = this.smallGutterSize;
			group.customButtonStyleName = THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON;
		}
		
		protected function setAlertButtonGroupButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);
			button.minWidth = 2 * this.controlSize;
		}
		
		protected function setAlertMessageTextRendererStyles(renderer:TextFieldTextRenderer):void
		{
			renderer.wordWrap = true;
			renderer.textFormat = this.darkTextFormat;
		}
		
		protected function setScaledToDpiTextRendererStyles(renderer:TextFieldTextRenderer):void
		{
			renderer.wordWrap = true;
			renderer.textFormat = this.scaledTextFormat;
			renderer.embedFonts = false;
			renderer.isHTML = true;
		}
		
		//-------------------------
		// Button
		//-------------------------
		
		protected function setBaseButtonStyles(button:Button):void
		{
			button.defaultLabelProperties.textFormat = this.lightTextFormat;
			
			button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = this.gridSize;
			button.minTouchHeight = this.gridSize;
		}
		
		protected function setFacebookButtonStyles(button:Button):void
		{
			var defaultImage:Image = new Image(this.buttonFacebookSkinTexture);
			
			button.defaultSkin = defaultImage;
		}
		
		protected function setTextButtonStyles(button:Button):void
		{
			button.defaultLabelProperties.textFormat = this.textButtonTextFormat;
			
			button.paddingTop = 0;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.smallGutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = this.gridSize;
			button.minTouchHeight = this.gridSize;
		}
		
		protected function setButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}
		
		//-------------------------
		// ButtonGroup
		//-------------------------
		
		protected function setButtonGroupStyles(group:ButtonGroup):void
		{
			group.firstButtonFactory = function ():Button {
				var button:Button = new Button();
				button.labelOffsetX = -10;
				return button;
			};
			group.minWidth = this.popUpFillWidth;
			group.gap = this.gutterSize;
		}
		
		protected function setButtonGroupButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			
			button.defaultLabelProperties.nativeFilters = [Constants.DROP_SHADOW_FILTER];
			button.defaultLabelProperties.textFormat = this.lightTextFormat;
			
			button.paddingTop = this.gutterSize; //this.smallGutterSize;
			button.paddingBottom = this.gutterSize; // this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.gutterSize; //this.smallGutterSize;
			button.minGap = this.gutterSize; //this.smallGutterSize;
			button.minWidth = this.gridSize;
			button.minHeight = this.gridSize;
			button.minTouchWidth = this.gridSize;
			button.minTouchHeight = this.gridSize;
			
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		}
		
		//-------------------------
		// Callout
		//-------------------------
		
		protected function setCalloutStyles(callout:Callout):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures);
			backgroundSkin.width = this.calloutBackgroundMinSize;
			backgroundSkin.height = this.calloutBackgroundMinSize;
			callout.backgroundSkin = backgroundSkin;
			
			var topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
			callout.topArrowSkin = topArrowSkin;
			
			var rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
			callout.rightArrowSkin = rightArrowSkin;
			
			var bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
			callout.bottomArrowSkin = bottomArrowSkin;
			
			var leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
			callout.leftArrowSkin = leftArrowSkin;
			
			callout.padding = this.smallGutterSize;
		}
		
		//-------------------------
		// Header
		//-------------------------
		
		protected function setHeaderStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture);
			backgroundSkin.width = this.gridSize;
			backgroundSkin.height = this.gridSize;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.textFormat = this.headerTextFormat;
		}
		
		//-------------------------
		// Label
		//-------------------------
		
		protected function setLabelStyles(label:Label):void
		{
			label.textRendererProperties.textFormat = this.darkTextFormat;
		}
		
		protected function setHeadingLabelStyles(label:Label):void
		{
			label.textRendererProperties.nativeFilters = [Constants.DROP_SHADOW_FILTER];
			label.textRendererProperties.textFormat = this.largeLightTextFormat;
		}
		
		protected function setScaledLabelStyles(label:Label):void
		{
			label.textRendererProperties.textFormat = this.scaledTextFormat;
		}
		
		//-------------------------
		// LayoutGroup
		//-------------------------
		
		protected function setToolbarLayoutGroupStyles(group:LayoutGroup):void
		{
			if(!group.layout)
			{
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.padding = this.smallGutterSize;
				layout.gap = this.smallGutterSize;
				group.layout = layout;
			}
			group.minWidth = this.gridSize;
			group.minHeight = this.gridSize;
			
			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture);
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			group.backgroundSkin = backgroundSkin;
		}
		
		protected function setSettingsLayoutGroupStyles(group:LayoutGroup):void
		{
			if (!group.layout)
			{
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
				layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				layout.padding = this.gutterSize * dpiScale;
				layout.gap = this.smallGutterSize * dpiScale;
				group.layout = layout;
			}
			group.minWidth = this.gridSize * dpiScale;
			group.minHeight = this.gridSize * dpiScale;
			
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundLayoutGroupSkinTextures, this.dpiScale);
			backgroundSkin.width = this.gridSize * dpiScale;
			backgroundSkin.height = this.gridSize * dpiScale;
			group.backgroundSkin = backgroundSkin;
		}
		
		//-------------------------
		// Panel
		//-------------------------
		
		protected function setPanelStyles(panel:Panel):void
		{
			this.setScrollerStyles(panel);
			
			panel.backgroundSkin = new Scale9Image(this.backgroundPopUpSkinTextures);
			
			panel.paddingTop = this.smallGutterSize;
			panel.paddingRight = this.smallGutterSize;
			panel.paddingBottom = this.smallGutterSize;
			panel.paddingLeft = this.smallGutterSize;
			
			if(!panel.layout)
			{
				var layout:VerticalLayout = new VerticalLayout();
				layout.gap = this.smallGutterSize;
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
				panel.layout = layout;
			}
		}
		
		protected function setHeaderWithoutBackgroundStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			header.titleProperties.textFormat = this.headerTextFormat;
		}
		
		//-------------------------
		// PanelScreen
		//-------------------------
		
		protected function setScaledPanelScreenStyles(panel:Panel):void
		{
			this.setScrollerStyles(panel);
			
			panel.minWidth = 580 * dpiScale;
			
			panel.backgroundSkin = new Scale9Image(this.backgroundPopUpSkinTextures, dpiScale);
			
			panel.padding = Math.round(this.smallGutterSize * dpiScale);
				
			if(!panel.layout)
			{
				var layout:VerticalLayout = new VerticalLayout();
				layout.gap = this.smallGutterSize * dpiScale;
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
				panel.layout = layout;
			}
		}
		
		protected function setScaledPanelScreenHeaderStyles(header:Header):void
		{
			header.useExtraPaddingForOSStatusBar = false;
			
			header.minWidth = this.gridSize * dpiScale;
			header.minHeight = this.gridSize * dpiScale;
			header.padding = this.smallGutterSize * dpiScale;
			header.gap = this.smallGutterSize * dpiScale;
			header.titleGap = this.smallGutterSize * dpiScale;
			header.titleProperties.textFormat = scaledHeaderTextFormat;
		}
		
		//-------------------------
		// ScrollContainer
		//-------------------------
		
		protected function setScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
		}
		
		protected function setToolbarScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
			if(!container.layout)
			{
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.padding = this.smallGutterSize;
				layout.gap = this.smallGutterSize;
				container.layout = layout;
			}
			container.minWidth = this.gridSize;
			container.minHeight = this.gridSize;
			
			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture);
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			container.backgroundSkin = backgroundSkin;
		}
		
		//-------------------------
		// ScrollText
		//-------------------------
		
		protected function setScrollTextStyles(text:ScrollText):void
		{
			this.setScrollerStyles(text);
			
			text.textFormat = this.scrollTextTextFormat;
			text.padding = this.gutterSize;
			text.paddingRight = this.gutterSize + this.smallGutterSize;
		}
		
		//-------------------------
		// SimpleScrollBar
		//-------------------------
		
		protected function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.paddingLeft = this.scrollBarGutterSize;
				scrollBar.customThumbStyleName = THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop = this.scrollBarGutterSize;
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.customThumbStyleName = THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}
		
		protected function setHorizontalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.horizontalScrollBarThumbSkinTextures);
			defaultSkin.width = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}
		
		protected function setVerticalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.verticalScrollBarThumbSkinTextures);
			defaultSkin.height = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}
		
		//-------------------------
		// ToggleSwitch
		//-------------------------
		
		protected function setScaledToggleSwitchStyles(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_ON_OFF;
			toggle.labelAlign = ToggleSwitch.LABEL_ALIGN_MIDDLE;
			
			toggle.defaultLabelProperties.textFormat = this.scaledLightUITextFormat;
		}
		
		protected function setScaledToggleSwitchTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundToggleSwitchOnSkinTextures;
			
			var trackSize:Number = Math.round(this.controlSize * this.dpiScale * 1.5);
			skinSelector.displayObjectProperties =
				{
					width: trackSize * 1.5,
						height: trackSize,
						textureScale: Math.round(this.dpiScale * 1.5)
				};
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setScaledToggleSwitchOffTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundToggleSwitchOffSkinTextures;
			
			var trackSize:Number = Math.round(this.controlSize * this.dpiScale * 1.5);
			skinSelector.displayObjectProperties =
				{
					width: trackSize * 1.5,
						height: trackSize,
						textureScale: Math.round(this.dpiScale * 1.5)
				};
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setScaledToggleSwitchButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonToggleSwitchUpSkinTextures;
			skinSelector.setValueForState(this.buttonToggleSwitchDownSkinTextures, Button.STATE_DOWN, false);
			
			var buttonSize:Number = Math.round(this.controlSize * this.dpiScale * 1.5);
			
			skinSelector.displayObjectProperties =
				{
					width: buttonSize,
						height: buttonSize,
						textureScale: Math.round(this.dpiScale * 1.5)
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = buttonSize;
			button.minTouchWidth = button.minTouchHeight = buttonSize;
		}
		
		protected function setCloseButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCloseUpSkinTexture;
			skinSelector.setValueForState(this.buttonCloseDownSkinTexture, Button.STATE_DOWN, false);
			
			var buttonSize:Number = Math.round(this.controlSize * this.dpiScale * 1.5);
			
			skinSelector.displayObjectProperties =
				{
					width: buttonSize,
						height: buttonSize,
						smoothing: TextureSmoothing.TRILINEAR
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = buttonSize;
			button.minTouchWidth = button.minTouchHeight = buttonSize;
		}
		
		
		//-------------------------
		// Settings button
		//-------------------------
		protected function setSettingsButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonSettingsUpSkinTexture;
			skinSelector.setValueForState(this.buttonSettingsDownSkinTexture, Button.STATE_DOWN, false);
			var settingsSize:Number = Math.ceil(this.controlSize * 1.3);
			skinSelector.displayObjectProperties =
				{
					width: settingsSize,
						height: settingsSize,
						smoothing: TextureSmoothing.TRILINEAR
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = settingsSize;
			button.minTouchWidth = button.minTouchHeight = settingsSize;
		}
	}
}


