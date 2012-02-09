package com.asylum.data
{
	public class AncientOne
	{
		public var id:int;
		public var name:String;
		public var combat:String;
		public var defenses:String;
		public var doom:int;
		public var worshippers:String;
		public var power:MonsterAbility;
		public var startBattleText:String;
		public var attack:String;
		
		public function AncientOne()
		{
			name = "";
			combat = "";
			defenses = "";
			worshippers = "";
			startBattleText = "";
			attack = "";
			power = new MonsterAbility();
		}
	}
}