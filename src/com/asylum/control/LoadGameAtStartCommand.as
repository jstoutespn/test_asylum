package com.asylum.control
{
	import com.asylum.data.CardInstance;
	import com.asylum.data.Config;
	import com.asylum.data.GateInstance;
	import com.asylum.data.LocationState;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Player;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.CardFactory;
	import com.asylum.factory.MapFactory;
	import com.asylum.factory.MonsterFactory;
	import com.asylum.factory.PlayerFactory;
	import com.asylum.model.GameProxy;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadGameAtStartCommand extends StartupTask
	{
		public function LoadGameAtStartCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var args:Object = {game:Config.i.gameId, user:Config.i.userId, lastUpdate:0};
			var loader:XMLLoader = new XMLLoader(Config.i.gameURL, onResult, onFault, args, true);
		}
		
		private function onResult(xml:XML):void {
			if ( !xml.hasOwnProperty("@id") ) {
				// throw some sort of error here and deny access
				return;
			}
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			gameProxy.phase = xml.@phase;
			// get players regardless of phase
			var playerList:XMLList = xml..players.player;
			var player:Player;
			var charsLoaded:Boolean = startupProxy.isTaskComplete(LoadCharactersCommand);
			for each (var playerXML:XML in playerList) {
				player = PlayerFactory.makePlayer(playerXML);
				if (charsLoaded && player.characterId > -1) {
					player.character = sourceProxy.getCharacter(player.characterId);
				}
				gameProxy.players.push(player);
			}
			// do stuff based on game's phase
			if (gameProxy.phase == GamePhase.GAME_SETUP) {
				
			} else {
				// read game
				gameProxy.doomTrack = parseFloat(xml.@doom) as int;
				gameProxy.terrorTrack = parseFloat(xml.@terror) as int;
				gameProxy.lastUpdate = parseFloat(xml.@updated) as uint;
				// read ancient one
				var bossId:int = parseFloat(xml.@boss) as int;
				if ( startupProxy.isTaskComplete(LoadAncientOnesCommand) ) {
					gameProxy.boss = sourceProxy.getAncientOne(bossId);
				}
				// read monsters
				var monsterList:XMLList = xml..monsters.monster;
				if ( startupProxy.isTaskComplete(LoadMonstersCommand) ) {
					var monsterId:int;
					var monsterInst:MonsterInstance;
					for each (var monXML:XML in monsterList) {
						monsterInst = MonsterFactory.makeMonsterInstance(monXML);
						monsterId = parseFloat(monXML.@source) as int;
						monsterInst.source = sourceProxy.getMonster(monsterId);
						if (monsterInst.locationId == "cup" && !monsterInst.isTrophy) {
							gameProxy.monsterCup.push(monsterInst);
						} else if (monsterInst.isTrophy) {
							monsterInst.claimant = gameProxy.getPlayer(xml.@owner);
							gameProxy.monsters.push(monsterInst);
						} else {
							gameProxy.monsters.push(monsterInst);
						}
					}
				}
				// read gates
				var gateList:XMLList = xml..gates.gate;
				var cardsLoaded:Boolean = startupProxy.isTaskComplete(LoadCardsCommand);
				if (cardsLoaded) {
					var gateId:int;
					var gateInst:GateInstance;
					for each (var gateXML:XML in gateList) {
						gateInst = CardFactory.makeGateToken(gateXML);
						gateId = parseFloat(gateXML.@source) as int;
						gateInst.source = sourceProxy.getGate(gateId);
						if (gateInst.locationId == "cup" && !gateInst.isTrophy) {
							gameProxy.gateCup.push(gateInst);
						} else if (gateInst.isTrophy) {
							gateInst.claimant = gameProxy.getPlayer(xml.@owner);
							gameProxy.gates.push(gateInst);
						} else {
							gameProxy.gates.push(gateInst);
						}
					}
				}
				// read cards
				var cardList:XMLList = xml..cards.card;
				if (cardsLoaded) {
					var cardId:int;
					var cardInst:CardInstance;
					for each (var cardXML:XML in cardList) {
						cardInst = CardFactory.makeCardInstance(cardXML);
						cardId = parseFloat(cardXML.@source) as int;
						cardInst.source = sourceProxy.getCard(cardId);
						if (cardInst.isInPlay) {
							cardInst.owner = gameProxy.getPlayer(xml.@owner);
							gameProxy.cardsInPlay.push(cardInst);
						} else {
							gameProxy.addCardToDeck(cardInst);
						}
					}
				}
				// read location states
				var locList:XMLList = xml..locations.location;
				var locState:LocationState;
				for each (var locXML:XML in locList) {
					locState = MapFactory.makeLocationState(locXML);
					gameProxy.locationStates.push(locState);
				}
				// read logs
				var logs:XML = xml.logs[0];
				if (logs.children().length() > 0) {
					sendNotification(NoteName.UPDATE_LOGS, {xml:logs, renderAll:true});
				}
			}
			sendNotification(NoteName.SET_LOADING_TEXT, "game loaded...");
			complete(LoadGameAtStartCommand);
		}
		
		private function onFault(info:Object):void {
			
		}
	}
}