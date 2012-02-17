package com.asylum.data.enum
{
	public class MonsterMovement
	{
		public static const NORMAL:String = "normal";
		public static const STATIONARY:String = "stationary";
		public static const FAST:String = "fast";
		public static const UNIQUE:String = "unique";
		public static const FLYING:String = "flying";
		public static const STALKER:String = "stalker";
		public static const AQUATIC:String = "aquatic";
		
		public static function getMovementColor(movement:String):uint {
			switch (movement) {
				case STATIONARY:
					return new uint(0xDDD000);
					break;
				case FAST:
					return new uint(0xFF0000);
					break;
				case UNIQUE:
					return new uint(0x00FF00);
					break;
				case FLYING:
					return new uint(0x0088CC);
					break;
				case AQUATIC:
					return new uint(0xFFA500);
					break;
				case STALKER:
					return new uint(0x800080);
					break;
				default:
					return new uint(0x000000);
					break;
			}
		}
	}
}