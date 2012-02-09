package com.asylum.control
{
	import com.asylum.data.Character;
	import com.asylum.data.Config;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.CharacterFactory;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadCharactersCommand extends StartupTask
	{
		public function LoadCharactersCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void {
			var loader:XMLLoader = new XMLLoader(Config.i.charactersURL, onResult, onFault);
		}
		
		private function onResult(xml:XML):void {
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			var charList:XMLList = xml..character;
			var character:Character;
			for each (var charXML:XML in charList) {
				character = CharacterFactory.makeCharacter(charXML);
				sourceProxy.characters.push(character);
			}
			sendNotification(NoteName.SET_LOADING_TEXT, "characters loaded...");
			complete(LoadCharactersCommand);
		}
		
		private function onFault(info:Object):void {
			
		}
	}
}