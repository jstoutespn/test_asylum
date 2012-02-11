package com.asylum.view.ancient
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.enum.ApplicationScreen;
	import com.asylum.data.enum.NoteName;
	import com.asylum.mediator.BaseMediator;
	import com.asylum.model.SourceProxy;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class AncientMediator extends BaseMediator
	{
		public static const NAME:String = "ancientMediator";
		
		public function AncientMediator(viewComponent:AncientScreen)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.SET_SCREEN, onScreenChange);
		}
				
		public function get view():AncientScreen {
			return viewComponent as AncientScreen;
		}
		
		private function onScreenChange(note:INotification):void {
			if (note.getBody().screen == ApplicationScreen.BOSS_SELECT) {
				view.addEventListener(AncientScreen.SELECTED, onAncientSelect, false, 0, true);
				loadData();
			} else {
				view.dataProvider.removeAll();
			}
		}
		
		private function loadData():void
		{
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			var data:ArrayCollection = new ArrayCollection();
			for each (var ancient:AncientOne in sourceProxy.ancients) {
				data.addItem(ancient);
			}
			view.dataProvider = data;
		}

		private function onAncientSelect(event:Event):void
		{
			var ancient:AncientOne = view.selection;
			view.removeEventListener(AncientScreen.SELECTED, onAncientSelect);
			sendNotification(NoteName.SETUP_GAME, {boss:ancient});
		}
	}
}