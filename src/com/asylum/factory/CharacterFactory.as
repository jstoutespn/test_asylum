package com.asylum.factory
{
	import com.asylum.data.Character;
	import com.asylum.data.Stat;

	public class CharacterFactory
	{
		public static function makeCharacter(xml:XML):Character {
			var char:Character = new Character();
			char.id = parseFloat(xml.@id) as int;
			char.name = xml.name[0].toString();
			char.maxSanity = parseFloat(xml..sanity) as int;
			char.maxStamina = parseFloat(xml..stamina) as int;
			char.unique.title = xml..unique.name;
			char.unique.text = xml..unique.description;
			// speed
			var speedSteps:String = xml..speed.@steps;
			char.speed = new Stat( speedSteps.split(",") );
			// sneak
			var sneakSteps:String = xml..sneak.@steps;
			char.sneak = new Stat( sneakSteps.split(",") );
			// fight
			var fightSteps:String = xml..fight.@steps;
			char.fight = new Stat( fightSteps.split(",") );
			// will
			var willSteps:String = xml..will.@steps;
			char.will = new Stat( willSteps.split(",") );
			// lore
			var loreSteps:String = xml..lore.@steps;
			char.lore = new Stat( loreSteps.split(",") );
			// luck
			var luckSteps:String = xml..luck.@steps;
			char.luck = new Stat( luckSteps.split(",") );
			
			// gear
			if (xml..fixed.cash) {
				char.cash = parseFloat(xml..fixed.cash) as int;
			}
			if (xml..fixed.clue) {
				char.clues = parseFloat(xml..fixed.clue) as int;
			}
			var itemList:XMLList = xml..fixed.item;
			if (itemList.length() > 0) {
				var fixedItem:int;
				for each (var itemXML:XML in itemList) {
					fixedItem = parseFloat(itemXML.@id) as int;
					char.startItems.push(fixedItem);
				}
			}
			
			// random gear
			if (xml..gear.random) {
				if (xml..gear.random.commonItems.length() > 0) {
					char.randomDraw.commonItems = parseFloat(xml..gear.random.commonItems.@num) as int;
				}
				if (xml..gear.random.uniqueItems.length() > 0) {
					char.randomDraw.uniqueItems = parseFloat(xml..gear.random.uniqueItems.@num) as int;
				}
				if (xml..gear.random.skills.length() > 0) {
					char.randomDraw.skills = parseFloat(xml..gear.random.skills.@num) as int;
				}
				if (xml..gear.random.spells.length() > 0) {
					char.randomDraw.spells = parseFloat(xml..gear.random.spells.@num) as int;
				}
			}
			
			// check for statuses
			var statusCards:XMLList = xml..gear.fixed.status;
			if (statusCards.length() > 0) {
				for each (var statusCard:XML in statusCards) {
					if (statusCard.@id == "blessing") {
						char.blessed = true;
					} else if (statusCard.@id == "cursed") {
						char.cursed = true;
					}
				}
			}
			
			return char;
		}
	}
}