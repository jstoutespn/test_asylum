package com.asylum.data
{
	public class Character
	{
		public var id:int;
		public var name:String;
		public var maxSanity:int;
		public var maxStamina:int;
		public var focus:int;
		public var unique:BaseAbility;
		
		public var speedValues:Array;
		public var sneakValues:Array;
		public var fightValues:Array;
		public var willValues:Array;
		public var loreValues:Array;
		public var luckValues:Array;
		
		public var startLocation:String;
		public var startLocationName:String;
		
		public var startCash:int;
		public var startClues:int;
		public var startCards:Vector.<int>;
		public var randomDraw:RandomItemDraw;
		public var fixedGear:String;
		public var randomGear:String;
		
		public function Character()
		{
			startCards = new Vector.<int>();
			unique = new BaseAbility();
			randomDraw = new RandomItemDraw();
			startCash = 0;
			startClues = 0;
		}
	}
}