package com.asylum
{
	import com.asylum.data.enum.NoteName;
	import com.asylum.mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ArkhamMediator extends BaseMediator
	{
		public static const NAME:String = "mainMediator";
		
		public function ArkhamMediator(viewComponent:Arkham)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.SET_LOADING_TEXT, onSetLoadText);
		}
		
		public function get view():Arkham {
			return viewComponent as Arkham;
		}
		
		private function onSetLoadText(note:INotification):void {
			if (view && view.currentState == "loading") {
				view.loadLabel.text = note.getBody() as String;
			}
		}
	}
}