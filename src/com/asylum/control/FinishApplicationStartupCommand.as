package com.asylum.control
{
	import com.asylum.data.Card;
	import com.asylum.data.Character;
	import com.asylum.data.RandomItemDraw;
	import com.asylum.data.enum.ApplicationScreen;
	import com.asylum.data.enum.CardType;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.model.GameProxy;
	import com.asylum.model.SourceProxy;
	import com.asylum.view.map.MapMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class FinishApplicationStartupCommand extends SimpleCommand
	{
		private var mapMediator:MapMediator;
		private var sourceProxy:SourceProxy;
		private var gameProxy:GameProxy;
		
		public function FinishApplicationStartupCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void {
			// finalize data
			mapMediator = facade.retrieveMediator(MapMediator.NAME) as MapMediator;
			sourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			gameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;

			for each (var character:Character in sourceProxy.characters) {
				character.startLocationName = mapMediator.getLocationName(character.startLocation);
				character.fixedGear = getFixedGear(character);
				character.randomGear = getRandomGear(character.randomDraw);
			}
			// determine starting screen
			if (gameProxy.phase == GamePhase.GAME_SETUP) {
				sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.BOSS_SELECT});
			} else {
				sendNotification(NoteName.UPDATE_GAME_VIEW, {isFirstTime:true});
				sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.PLAYING});
			}
		}
		
		private function getFixedGear(character:Character):String {
			var gear:Array = new Array();
			if (character.startCash > 0) {
				var cashStr:String = new String("$" + character.startCash);
				gear.push(cashStr);
			}
			if (character.startClues > 0) {
				var clueStr:String = new String(character.startClues + " Clue Tokens");
				gear.push(clueStr);
			}
			if (character.startCards.length > 0) {
				var card:Card;
				var cardStr:String;
				for each (var itemId:int in character.startCards) {
					card = sourceProxy.getCard(itemId);
					if (card != null) {
						switch (card.type) {
							case CardType.SKILL:
								cardStr = "Skill (" + card.name + ")";
								break;
							case CardType.SPECIAL:
								cardStr = "Special (" + card.name + ")";
								break;
							case CardType.ALLY:
								cardStr = "Ally (" + card.name + ")";
								break;
							default:
								cardStr = card.name;
								break;
						}
						gear.push(cardStr);
					}
				}
			}
			return gear.join(", ");
		}
		
		private function getRandomGear(gearDraw:RandomItemDraw):String {
			var randGear:Array = new Array();
			var randStr:String;
			if (gearDraw.commonItems > 0) {
				randStr = new String(gearDraw.commonItems + " Common Items");
				randGear.push(randStr);
			}
			if (gearDraw.uniqueItems > 0) {
				randStr = new String(gearDraw.uniqueItems + " Unique Items");
				randGear.push(randStr);
			}
			if (gearDraw.spells > 0) {
				randStr = new String(gearDraw.spells + " Spells");
				randGear.push(randStr);
			}
			if (gearDraw.skills > 0) {
				randStr = new String(gearDraw.skills + " Skills");
				randGear.push(randStr);
			}
			return randGear.join(", ");
		}
	}
}