package com.asylum.model
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.CardInstance;
	import com.asylum.data.GateInstance;
	import com.asylum.data.LocationState;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Player;
	import com.asylum.data.enum.CardType;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class GameProxy extends Proxy
	{
		public static const NAME:String = "gameProxy";
		
		public var phase:String;
		public var lastUpdate:uint;
		public var boss:AncientOne;
		public var doomTrack:int;
		public var terrorTrack:int;
		public var players:Vector.<Player>;
		public var monsters:Vector.<MonsterInstance>;
		public var monsterCup:Vector.<MonsterInstance>;
		public var gates:Vector.<GateInstance>;
		public var gateCup:Vector.<GateInstance>;
		public var cardsInPlay:Vector.<CardInstance>;
		public var commonItemDeck:Vector.<CardInstance>;
		public var uniqueItemDeck:Vector.<CardInstance>;
		public var spellDeck:Vector.<CardInstance>;
		public var skillDeck:Vector.<CardInstance>;
		public var specialDeck:Vector.<CardInstance>;
		public var allyDeck:Vector.<CardInstance>;
		public var locationStates:Vector.<LocationState>;
		public var discards:Vector.<CardInstance>;
		public var graveyard:Vector.<Player>;
		
		public function GameProxy()
		{
			lastUpdate = 0;
			players = new Vector.<Player>();
			monsters = new Vector.<MonsterInstance>();
			monsterCup = new Vector.<MonsterInstance>();
			gates = new Vector.<GateInstance>();
			gateCup = new Vector.<GateInstance>();
			cardsInPlay = new Vector.<CardInstance>();
			commonItemDeck = new Vector.<CardInstance>();
			uniqueItemDeck = new Vector.<CardInstance>();
			spellDeck = new Vector.<CardInstance>();
			skillDeck = new Vector.<CardInstance>();
			specialDeck = new Vector.<CardInstance>();
			allyDeck = new Vector.<CardInstance>();
			locationStates = new Vector.<LocationState>();
			discards = new Vector.<CardInstance>();
			graveyard = new Vector.<Player>();
			super(NAME, null);
		}
		
		public function getPlayer(id:String):Player {
			for each (var player:Player in players) {
				if (player.id == id) {
					return player;
				}
			}
			return null;
		}
		
		public function addCardToDeck(card:CardInstance):void {
			switch (card.source.type) {
				case CardType.COMMON:
					commonItemDeck.push(card);
					break;
				case CardType.UNIQUE:
					uniqueItemDeck.push(card);
					break;
				case CardType.SPELL:
					spellDeck.push(card);
					break;
				case CardType.SKILL:
					skillDeck.push(card);
					break;
				case CardType.SPECIAL:
					specialDeck.push(card);
					break;
				case CardType.ALLY:
					allyDeck.push(card);
					break;
			}
		}
	}
}