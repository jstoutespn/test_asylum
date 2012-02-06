package com.asylum.view.map
{
	import com.asylum.events.NoteEvent;
	import com.asylum.mediator.BaseMediator;
	
	import flash.utils.Dictionary;

	public class MapMediator extends BaseMediator
	{
		public static const NAME:String = "mapMediator";
		
		private var mapIndex:Dictionary;
		
		public function MapMediator(viewComponent:GameMap)
		{
			super(NAME, viewComponent);
			buildMapIndex();
		}
		
		private function get view():GameMap
		{
			return viewComponent as GameMap;
		}
		
		private function onNoteEvent(event:NoteEvent):void
		{
			sendNotification(event.name, event.message);
		}
		
		private function buildMapIndex():void {
			mapIndex = new Dictionary();
			var items:Array = view.allItems;
			for each (var item:ILocation in items) {
				mapIndex[item.mapId] = item;
				item.addEventListener(NoteEvent.NOTIFICATION, onNoteEvent, false, 0, true);
			}
		}
	}
}