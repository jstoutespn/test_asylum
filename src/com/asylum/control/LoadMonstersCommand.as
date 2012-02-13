package com.asylum.control
{
	import com.asylum.data.BaseAbility;
	import com.asylum.data.Config;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterAbility;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.MonsterFactory;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadMonstersCommand extends StartupTask
	{
		public function LoadMonstersCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void {
			var loader:XMLLoader = new XMLLoader(Config.i.monstersURL, onResult, onFault);
		}
		
		private function onResult(xml:XML):void {
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			var abilList:XMLList = xml.abilities[0].ability;
			var monAbil:MonsterAbility;
			for each (var abilXML:XML in abilList) {
				monAbil = MonsterFactory.makeMonsterAbility(abilXML);
				sourceProxy.monsterAbilities.push(monAbil);	
			}
			var monList:XMLList = xml..monster;
			var monster:Monster;
			var abilId:String;
			for each (var monXML:XML in monList) {
				monster = MonsterFactory.makeMonster(monXML);
				for each (var myAbil:XML in monXML..abilities.ability) {
					abilId = myAbil.@id;
					monAbil = sourceProxy.getMonsterAbility(abilId);
					monster.abilities.push(monAbil);
				}
				sourceProxy.monsters.push(monster);
			}
			sendNotification(NoteName.SET_LOADING_TEXT, "monsters loaded...");
			complete(LoadMonstersCommand);
		}
		
		private function onFault(info:Object):void {
			// TODO
		}
	}
}