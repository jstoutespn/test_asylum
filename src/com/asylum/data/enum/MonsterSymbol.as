package com.asylum.data.enum
{
	public class MonsterSymbol
	{
		public static const CROSS:String = "cross";
		public static const CRESCENT:String = "crescent";
		public static const CIRCLE:String = "circle";
		public static const SLASH:String = "slash";
		public static const HEXAGON:String = "hexagon";
		public static const TRIANGLE:String = "triangle";
		public static const SQUARE:String = "square";
		public static const DIAMOND:String = "diamond";
		public static const STAR:String = "star";
		
		public static function getSymbolImage(symbol:String):Class
		{
			switch (symbol) {
				case CROSS:
					return EmbeddedImages.SYMBOL_CROSS;
					break;
				case CRESCENT:
					return EmbeddedImages.SYMBOL_CRESCENT;
					break;
				case CIRCLE:
					return EmbeddedImages.SYMBOL_CIRCLE;
					break;
				case SLASH:
					return EmbeddedImages.SYMBOL_SLASH;
					break;
				case HEXAGON:
					return EmbeddedImages.SYMBOL_HEXAGON;
					break;
				case TRIANGLE:
					return EmbeddedImages.SYMBOL_TRIANGLE;
					break;
				case SQUARE:
					return EmbeddedImages.SYMBOL_SQUARE;
					break;
				case DIAMOND:
					return EmbeddedImages.SYMBOL_DIAMOND;
					break;
				case STAR:
					return EmbeddedImages.SYMBOL_STAR;
					break;
			}
			return null;
		}
	}
}