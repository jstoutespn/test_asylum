package com.asylum
{
	import com.asylum.mediator.BaseMediator;
	
	public class ArkhamMediator extends BaseMediator
	{
		public static const NAME:String = "mainMediator";
		
		public function ArkhamMediator(viewComponent:Arkham)
		{
			super(NAME, viewComponent);
		}
		
		public function get view():Arkham {
			return viewComponent as Arkham;
		}
	}
}