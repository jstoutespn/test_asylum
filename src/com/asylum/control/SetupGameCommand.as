package com.asylum.control
{
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.GateInstance;
	import com.asylum.data.Item;
	import com.asylum.data.ItemInstance;
	import com.asylum.data.LocationState;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Skill;
	import com.asylum.data.SkillInstance;
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
			
			// set up items
			var itemsXML:XML = new XML("<items></items>");
			var itemXML:XML;
			var itemCards:Vector.<ItemInstance>;
			for each (var common:Item in sourceProxy.commonItems) {
				itemCards = getItemInstances(common);
				for each (var commonCard:ItemInstance in itemCards) {
					gameProxy.commonItemDeck.push(commonCard);
					itemXML = CardFactory.getItemCardXML(commonCard);
					itemsXML.appendChild(itemXML);
				}
			}
			for each (var unique:Item in sourceProxy.uniqueItems) {
				itemCards = getItemInstances(unique);
				for each (var uniqueCard:ItemInstance in itemCards) {
					gameProxy.uniqueItemDeck.push(uniqueCard);
					itemXML = CardFactory.getItemCardXML(uniqueCard);
					itemsXML.appendChild(itemXML);
				}
			}
			for each (var spell:Spell in sourceProxy.spells) {
				itemCards = getItemInstances(spell);
				for each (var spellCard:ItemInstance in itemCards) {
					gameProxy.spellDeck.push(spellCard);
					itemXML = CardFactory.getItemCardXML(spellCard);
					itemsXML.appendChild(itemXML);
				}
			}
			
			// set up skills
			var skillsXML:XML = new XML("<skills></skills>");
			var skillCard:SkillInstance;
			var skillXML:XML;
			for each (var skill:Skill in sourceProxy.skills) {
				count = skill.num;
				for (var s:int = 0; s<count; s++) {
					skillCard = new SkillInstance(skill);
					skillCard.id = CardFactory.getSkillCardId(skill.id, s);
					skillXML = CardFactory.getSkillCardXML(skillCard);
					skillsXML.appendChild(skillXML);
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
								'gates':gatesXML.toXMLString(), 'items':itemsXML.toXMLString(), 'skills':skillsXML.toXMLString(), 'locations':locationsXML.toXMLString(),
								'log':"set up the game"};
			var service:XMLService = new XMLService(Config.i.gameURL, onResult, onFault);
			service.load(NoteName.SETUP_GAME, args);
		}
		
		private function onResult(xml:XML):void {
			gameProxy.phase = GamePhase.WAITING_FOR_PLAYERS;
			sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.PLAYING});
		}
		
		private function onFault(info:Object):void {
			trace("i gotta fault");
		}
		
		private function getItemInstances(item:Item):Vector.<ItemInstance> {
			var count:int = item.num;
			var list:Vector.<ItemInstance> = new Vector.<ItemInstance>();
			var itemCard:ItemInstance;
			for (var i:int = 0; i<count; i++) {
				itemCard = new ItemInstance(item);
				itemCard.id = CardFactory.getItemCardId(item.id, i);
				list.push(itemCard);
			}
			return list;
		}
	}
}