/**
 * Created by borisenki on 08.09.16.
 */
package editor.model.vo
{
public class GameTypesVO
{
	private var _resources:Object;
	private var _mans:Object;
	private var _heroes:Object;
	private var _inventories:Object;
	private var _locations:Object;
	private var _perks:Object;
	private var _quests:Object;

	public function GameTypesVO(xml:XML)
	{
		_resources = {};
		for each (var resource:XML in xml.resources[0].resource)
		{
			_resources[resource.@id] = new TypeResourceVO(resource);
		}

		_mans = {};
		for each (var man:XML in xml.mans[0].man)
		{
			_mans[man.@id] = new TypeManVO(man);
		}

		_heroes = {};
		for each (var hero:XML in xml.heros[0].hero)
		{
			_heroes[hero.@id] = new TypeHeroVO(hero);
		}

		_inventories = {};
		for each (var item:XML in xml.inventory[0].item)
		{
			_inventories[item.@id] = new TypeInventoryItemVO(item);
		}

		_locations = {};
		for each (var location:XML in xml.locations[0].location)
		{
			_locations[location.@id] = new TypeLocationVO(location);
		}

		_perks = {};
		for each (var perk:XML in xml.perks[0].perk)
		{
			_perks[perk.@id] = new TypePerkVO(perk);
		}

		_quests = {};
		for each (var quest:XML in xml.quests[0].quest)
		{
			_quests[quest.@id] = new TypeQuestVO(quest);
		}
	}

	public function get heroes():Object
	{
		return _heroes;
	}

	public function get mans():Object
	{
		return _mans;
	}

	public function get inventories():Object
	{
		return _inventories;
	}

	public function get quests():Object
	{
		return _quests;
	}

	public function get resources():Object
	{
		return _resources;
	}

	public function get locations():Object
	{
		return _locations;
	}

	public function get perks():Object
	{
		return _perks;
	}
}
}
