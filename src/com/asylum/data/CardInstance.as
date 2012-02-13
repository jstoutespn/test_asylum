package com.asylum.data
{
	public class CardInstance
	{
		public var id:String;
		public var source:Card;
		public var isInPlay:Boolean;
		public var owner:Player;
		
		public function CardInstance(card:Card = null)
		{
			source = card;
			isInPlay = false;
		}
	}
}