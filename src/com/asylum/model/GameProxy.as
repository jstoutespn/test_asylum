package com.asylum.model
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.GateInstance;
	import com.asylum.data.ItemInstance;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Player;
	import com.asylum.data.SkillInstance;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class GameProxy extends Proxy
	{
		public static const NAME:String = "gameProxy";
		
		public var gameId:int;
		public var gamePhase:String;
		public var boss:AncientOne;
		public var doomTrack:int;
		public var terrorTrack:int;
		public var players:Vector.<Player>;
		public var monsters:Vector.<MonsterInstance>;
		public var monsterCup:Vector.<MonsterInstance>;
		public var gates:Vector.<GateInstance>;
		public var gateCup:Vector.<GateInstance>;
		public var items:Vector.<ItemInstance>;
		public var commonItemDeck:Vector.<ItemInstance>;
		public var uniqueItemDeck:Vector.<ItemInstance>;
		public var spellDeck:Vector.<ItemInstance>;
		public var skillDeck:Vector.<SkillInstance>;
		public var graveyard:Vector.<Player>;
		
		public function GameProxy()
		{
			players = new Vector.<Player>();
			monsters = new Vector.<MonsterInstance>();
			monsterCup = new Vector.<MonsterInstance>();
			gates = new Vector.<GateInstance>();
			gateCup = new Vector.<GateInstance>();
			items = new Vector.<ItemInstance>();
			commonItemDeck = new Vector.<ItemInstance>();
			uniqueItemDeck = new Vector.<ItemInstance>();
			spellDeck = new Vector.<ItemInstance>();
			skillDeck = new Vector.<SkillInstance>();
			graveyard = new Vector.<Player>();
			super(NAME, null);
		}
	}
}