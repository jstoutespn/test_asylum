package com.asylum.control
{
	import com.asylum.data.Ally;
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.Item;
	import com.asylum.data.Skill;
	import com.asylum.data.Special;
	import com.asylum.data.Spell;
	import com.asylum.data.enum.CardType;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.CardFactory;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadCardsCommand extends StartupTask
	{
		public function LoadCardsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var loader:XMLLoader = new XMLLoader(Config.i.cardsURL, result, fault);
		}
		
		private function result(xml:XML):void {
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			var gates:XMLList = xml..gates.gate;
			var cards:XMLList = xml..cards.card;
			// get gates
			var gate:Gate;
			for each (var gateXML:XML in gates) {
				gate = CardFactory.makeGate(gateXML);
				sourceProxy.gates.push(gate);
			}
			// get cards
			var item:Item;
			var spell:Spell;
			var skill:Skill;
			var special:Special;
			var ally:Ally;
			var cardType:String;
			for each (var cardXML:XML in cards) {
				cardType = cardXML.@type;
				switch (cardType) {
					case CardType.SPELL:
						spell = CardFactory.makeSpell(cardXML);
						sourceProxy.spells.push(spell);
						break;
					case CardType.SKILL:
						skill = CardFactory.makeSkill(cardXML);
						sourceProxy.skills.push(skill);
						break;
					case CardType.SPECIAL:
						special = CardFactory.makeSpecial(cardXML);
						sourceProxy.specials.push(special);
						break;
					case CardType.ALLY:
						ally = CardFactory.makeAlly(cardXML);
						sourceProxy.allies.push(ally);
						break;
					default:
						item = CardFactory.makeItem(cardXML);
						if (cardType == CardType.UNIQUE) {
							sourceProxy.uniqueItems.push(item);
						} else {
							sourceProxy.commonItems.push(item);
						}
						break;
				}
			}
			// complete task
			sendNotification(NoteName.SET_LOADING_TEXT, "cards loaded...");
			complete(LoadCardsCommand);
		}
		
		private function fault(info:Object):void {
			// should probably do something here
		}
	}
}