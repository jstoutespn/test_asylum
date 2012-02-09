package com.asylum.factory
{
	import com.asylum.data.Config;
	import com.asylum.data.Player;

	public class PlayerFactory
	{
		public static function makePlayer(xml:XML):Player {
			var player:Player = new Player();
			player.id = xml.@id;
			player.name = xml.@name;
			player.firstName = xml.@firstName;
			player.lastName = xml.@lastName;
			player.imageUrl = xml.@imageUrl;
			if (player.id == Config.i.userId) {
				player.isMe = true;
			}
			if ( xml.hasOwnProperty("@character") ) {
				player.characterId = parseFloat(xml.@character) as int;
			}	
			if ( xml.hasOwnProperty("@order") ) {
				player.order = parseFloat(xml.@order) as int;
			}
			if ( xml.hasOwnProperty("@location") ) {
				player.locationId = xml.@location;
			}
			if ( xml.hasOwnProperty("@firstPlayer") && xml.@firstPlayer == "true" ) {
				player.isFirstPlayer = true;
			}
			return player;
		}
	}
}