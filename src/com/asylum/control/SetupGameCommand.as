package com.asylum.control
{
	import com.asylum.data.Ally;
	import com.asylum.data.Card;
	import com.asylum.data.CardInstance;
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.GateInstance;
	import com.asylum.data.Item;
	import com.asylum.data.LocationState;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Skill;
	import com.asylum.data.Special;
	import com.asylum.data.Spell;
	import com.asylum.data.enum.ApplicationScreen;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.CardFactory;
	import com.asylum.factory.MapFactory;
	import com.asylum.factory.MonsterFactory;
	import com.asylum.model.GameProxy;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLService;
	import com.asylum.view.map.ILocation;
	import com.asylum.view.map.MapMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetupGameCommand extends SimpleCommand
	{
		private var gameProxy:GameProxy;
		
		public function SetupGameCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.LOADING, message:"setting up game..."});
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			gameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var mapMediator:MapMediator = facade.retrieveMediator(MapMediator.NAME) as MapMediator;
			gameProxy.boss = notification.getBody().boss;
			gameProxy.doomTrack = 0;
			gameProxy.terrorTrack = 0;
			
			// set up monsters
			var monstersXML:XML = new XML("<monsters></monsters>");
			var monster:MonsterInstance;
			var monXML:XML;
			var count:int;
			for each (var mon:Monster in sourceProxy.monsters) {
				count = mon.num;
				for (var m:int = 0; m<count; m++) {
					monster = new MonsterInstance(mon);
					monster.id = MonsterFactory.getMonsterInstanceId(mon.id, m);
					gameProxy.monsterCup.push(monster);
					monXML = MonsterFactory.getMonsterInstanceXML(monster);
					monstersXML.appendChild(monXML);
				}
			}
			
			// set up gates
			var gatesXML:XML = new XML("<gates></gates>");
			var gateToken:GateInstance;
			var gateXML:XML;
			for each (var gate:Gate in sourceProxy.gates) {
				count = gate.num;
				for (var g:int = 0; g<count; g++) {
					gateToken = new GateInstance(gate);
					gateToken.id = CardFactory.getGateTokenId(gate.id, g);
					gameProxy.gateCup.push(gateToken);
					gateXML = CardFactory.getGateTokenXML(gateToken);
					gatesXML.appendChild(gateXML);
				}
			}
			
			// set up cards
			var cardsXML:XML = new XML("<cards></cards>");
			var cardXML:XML;
			var cardlist:Vector.<CardInstance>;
			for each (var common:Item in sourceProxy.commonItems) {
				cardlist = getCardInstances(common);
				for each (var commonCard:CardInstance in cardlist) {
					gameProxy.commonItemDeck.push(commonCard);
					cardXML = CardFactory.getCardInstanceXML(commonCard);
					cardsXML.appendChild(cardXML);
				}
			}
			for each (var unique:Item in sourceProxy.uniqueItems) {
				cardlist = getCardInstances(unique);
				for each (var uniqueCard:CardInstance in cardlist) {
					gameProxy.uniqueItemDeck.push(uniqueCard);
					cardXML = CardFactory.getCardInstanceXML(uniqueCard);
					cardsXML.appendChild(cardXML);
				}
			}
			for each (var spell:Spell in sourceProxy.spells) {
				cardlist = getCardInstances(spell);
				for each (var spellCard:CardInstance in cardlist) {
					gameProxy.spellDeck.push(spellCard);
					cardXML = CardFactory.getCardInstanceXML(spellCard);
					cardsXML.appendChild(cardXML);
				}
			}
			for each (var skill:Skill in sourceProxy.skills) {
				cardlist = getCardInstances(skill);
				for each (var skillCard:CardInstance in cardlist) {
					gameProxy.skillDeck.push(skillCard);
					cardXML = CardFactory.getCardInstanceXML(skillCard);
					cardsXML.appendChild(cardXML);
				}
			}
			for each (var special:Special in sourceProxy.specials) {
				cardlist = getCardInstances(special);
				for each (var cardInst:CardInstance in cardlist) {
					gameProxy.specialDeck.push(cardInst);
					cardXML = CardFactory.getCardInstanceXML(cardInst);
					cardsXML.appendChild(cardXML);
				}
			}
			for each (var ally:Ally in sourceProxy.allies) {
				cardlist = getCardInstances(ally);
				for each (var allyCard:CardInstance in cardlist) {
					gameProxy.allyDeck.push(allyCard);
					cardXML = CardFactory.getCardInstanceXML(allyCard);
					cardsXML.appendChild(cardXML);
				}
			}			
			// set up locations
			var locationsXML:XML = new XML("<locations></locations>");
			var locState:LocationState;
			var locXML:XML;
			var locList:Vector.<ILocation> = mapMediator.getArkhamLocations();
			for each (var loc:ILocation in locList) {
				locState = new LocationState(loc.mapId);
				gameProxy.locationStates.push(locState);
				locXML = MapFactory.getLocationStateXML(locState);
				locationsXML.appendChild(locXML);
			}
			
			// send to server
			var args:Object = {'boss':gameProxy.boss.id, 'doom':gameProxy.doomTrack, 'terror':gameProxy.terrorTrack, 'monsters':monstersXML.toXMLString(),
								'gates':gatesXML.toXMLString(), 'cards':cardsXML.toXMLString(), 'locations':locationsXML.toXMLString(), 'log':"set up the game"};
			var service:XMLService = new XMLService(Config.i.gameURL, onResult, onFault);
			service.load(NoteName.SETUP_GAME, args);
		}
		
		private function onResult(xml:XML):void {
			gameProxy.phase = GamePhase.WAITING_FOR_PLAYERS;
			sendNotification(NoteName.UPDATE_GAME_VIEW, {isFirstTime:true});
			sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.PLAYING});
		}
		
		private function onFault(info:Object):void {
			trace("i gotta fault");
		}
		
		private function getCardInstances(card:Card):Vector.<CardInstance> {
			var count:int = card.num;
			var list:Vector.<CardInstance> = new Vector.<CardInstance>();
			var cardInstance:CardInstance;
			for (var i:int = 0; i<count; i++) {
				cardInstance = new CardInstance(card);
				cardInstance.id = CardFactory.getCardInstanceId(card.type, card.id, i);
				list.push(cardInstance);
			}
			return list;
		}
	}
}