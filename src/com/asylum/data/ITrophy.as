package com.asylum.data
{
	public interface ITrophy
	{
		function get isTrophy():Boolean;
		function set isTrophy(value:Boolean):void;
		function get claimant():Player;
		function set claimant(value:Player):void;
	}
}