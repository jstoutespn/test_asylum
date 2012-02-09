package com.asylum.factory
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterAbility;

	public class MonsterFactory
	{
		public static function makeAncientOne(xml:XML):AncientOne {
			var boss:AncientOne = new AncientOne();
			boss.id = parseFloat(xml.@id) as int;
			boss.name = xml..name;
			boss.combat = xml..combat;
			boss.defenses = xml..defenses;
			boss.doom = parseFloat(xml..doom) as int;
			boss.worshippers = xml..worshippers;
			boss.power.title = xml..power.title;
			boss.power.text = xml..power.text;
			if (xml.child("battlestart").length() > 0) {
				boss.startBattleText = xml..battlestart;
			}
			boss.attack = xml..attack;
			return boss;
		}
		
		public static function makeMonster(xml:XML):Monster {
			var mon:Monster = new Monster();
			mon.id = parseFloat(xml.@id) as int;
			mon.name = xml..name;
			mon.num = parseFloat(xml.@num) as int;
			mon.symbol = xml.@symbol;
			mon.awareness = parseFloat(xml.@awareness) as int;
			mon.horror = parseFloat(xml.@horror) as int;
			mon.sanDamage = parseFloat(xml.@sandamage) as int;
			mon.toughness = parseFloat(xml.@toughness) as int;
			mon.combat = parseFloat(xml.@combat) as int;
			mon.damage = parseFloat(xml.@damage) as int;
			var abilities:XMLList = xml..abilities.ability;
			var monAbil:MonsterAbility;
			for each (var abilXML:XML in abilities) {
				monAbil = new MonsterAbility();
				monAbil.title = abilXML.@title;
				monAbil.text = abilXML.toString();
				mon.abilities.push(monAbil);
			}
			return mon;
		}
	}
}