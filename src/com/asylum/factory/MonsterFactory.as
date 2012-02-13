package com.asylum.factory
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.BaseAbility;
	import com.asylum.data.Config;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterAbility;
	import com.asylum.data.MonsterInstance;

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
		
		public static function makeMonsterAbility(xml:XML):MonsterAbility {
			var monAbil:MonsterAbility = new MonsterAbility();
			monAbil.id = xml.@id;
			monAbil.title = xml..title;
			monAbil.text = xml..text;
			return monAbil;
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
			if (xml.child("special").length() > 0) {
				var specialText:String = xml..special;
				var specialAbil:BaseAbility = new BaseAbility("Special", specialText);
				mon.abilities.push(specialAbil);
			}
			return mon;
		}
		
		public static function getMonsterInstanceId(monsterId:int, monsterNumber:int):String {
			return new String("mon_" + Config.i.gameId + "_" + monsterId + "_" + monsterNumber);
		}
		
		public static function getMonsterInstanceXML(monster:MonsterInstance):XML {
			var xml:XML = new XML("<monster></monster>");
			xml.@id = monster.id;
			xml.@source = monster.source.id;
			if (monster.isTrophy) {
				xml.@trophy = "true";
				xml.@owner = monster.claimant.id;
			} else {
				xml.@trophy = "false";
				if (monster.location != null) {
					xml.@location = monster.location.mapId;
				} else {
					xml.@location = "cup";
				}
			}
			return xml;
		}
		
		public static function makeMonsterInstance(xml:XML):MonsterInstance {
			var mon:MonsterInstance = new MonsterInstance();
			mon.id = xml.@id;
			mon.locationId = xml.@location;
			if (xml.@trophy == "true") {
				mon.isTrophy = true;
			} else {
				mon.isTrophy = false;
			}
			return mon;
		}
	}
}