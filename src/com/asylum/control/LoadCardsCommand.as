package com.asylum.control
{
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.Item;
	import com.asylum.data.Skill;
	import com.asylum.data.Spell;
	import com.asylum.data.enum.ItemType;
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
			var items:XMLList = xml..items.item;
			var skills:XMLList = xml..skills.skill;
			// get gates
			var gate:Gate;
			for each (var gateXML:XML in gates) {
				gate = CardFactory.makeGate(gateXML);
				sourceProxy.gates.push(gate);
			}
			// get items
			var item:Item;
			var spell:Spell;
			for each (var itemXML:XML in items) {
				if (itemXML.@type == ItemType.SPELL) {
					spell = CardFactory.makeSpell(itemXML);
					sourceProxy.spells.push(spell);
				} else {
					item = CardFactory.makeItem(itemXML);
					if (item.type == ItemType.UNIQUE) {
						sourceProxy.uniqueItems.push(item);
					} else {
						sourceProxy.commonItems.push(item);
					}
				}
			}
			// get skills
			var skill:Skill;
			for each (var skillXML:XML in skills) {
				skill = CardFactory.makeSkill(skillXML);
				sourceProxy.skills.push(skill);
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