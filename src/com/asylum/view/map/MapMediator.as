package com.asylum.view.map
{
	import com.asylum.data.GateInstance;
	import com.asylum.data.IMiniature;
	import com.asylum.data.LocationState;
	import com.asylum.data.Player;
	import com.asylum.events.NoteEvent;
	import com.asylum.mediator.BaseMediator;
	
	import flash.utils.Dictionary;

	public class MapMediator extends BaseMediator
	{
		public static const NAME:String = "mapMediator";
		
		private var mapIndex:Dictionary;
		private var isMapIndexBuilt:Boolean;
		
		public function MapMediator(viewComponent:GameMap)
		{
			super(NAME, viewComponent);
			isMapIndexBuilt = false;
			buildMapIndex();
		}
		
		private function get view():GameMap
		{
			return viewComponent as GameMap;
		}
		
		public function getArkhamLocations():Vector.<ILocation> {
			var list:Vector.<ILocation> = new Vector.<ILocation>();
			for each (var loc:ArkhamLocation in view.locations) {
				list.push(loc);
			}
			return list;
		}
		
		public function getLocation(id:String):ILocation {
			if (mapIndex[id] != null) {
				return mapIndex[id] as ILocation;
			}
			return null;
		}
		
		public function addPlayer(player:IMiniature):void {
			var loc:ILocation = getLocation(player.locationId);
			if (loc != null) {
				player.location = loc;
				loc.characters.addItem(player);
			}
		}
		
		public function addMonster(monster:IMiniature):void {
			var loc:ILocation = getLocation(monster.locationId);
			if (loc != null) {
				monster.location = loc;
				loc.monsters.addItem(monster);
			}
		}
		
		public function addGate(gate:GateInstance):void {
			var loc:ArkhamLocation = getLocation(gate.locationId) as ArkhamLocation;
			if (loc != null && loc.canHazGate && !loc.hazGate && !loc.isSealed) {
				gate.location = loc;
				loc.gate = gate;
			}
		}
		
		public function applyLocationState(locationState:LocationState):void {
			var location:ArkhamLocation = getLocation(locationState.id) as ArkhamLocation;
			if (location != null) {
				location.clues = locationState.clueNum;
				location.isSealed = locationState.isSealed;
				location.isClosed = locationState.isClosed;
			}
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
			isMapIndexBuilt = true;
		}
	}
}