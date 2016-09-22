/**
 * Created by borisenki on 18.09.16.
 */
package editor.model
{
import editor.model.vo.GameQuestVO;
import editor.model.vo.QuestDialogVO;

import org.osflash.signals.Signal;

public class GameQuests
{
	public var dataUpdate:Signal;
	public var dialogSelected:Signal;
	public var questSelected:Signal;

	private var _selectedQuestId:int;
	private var _selectedDialogId:int;

	private var _quests:Vector.<GameQuestVO>;

	public function GameQuests()
	{
		_quests = new Vector.<GameQuestVO>();
		dataUpdate = new Signal();
		questSelected = new Signal();
		dialogSelected = new Signal();
	}

	public function setupXML(xml:XML):void
	{
		for each (var quest:XML in xml.quest)
		{
			_quests.push(new GameQuestVO(quest));
		}
		dataUpdate.dispatch();
	}

	public function createDialog(questId:int):void
	{
		getQuestById(questId).createDialog();
		dataUpdate.dispatch();
	}
	public function createAnswer(questId:int, dialogId:int):void
	{
		getQuestById(questId).getDialogById(dialogId).createNewAnswer();
		dataUpdate.dispatch();
	}

	public function getQuestById(questId:int):GameQuestVO
	{
		for each (var quest:GameQuestVO in _quests)
		{
			if (quest.id == questId)
			{
				return quest;
			}
		}
		return null;
	}

	public function getSelectedQuest():GameQuestVO
	{
		return getQuestById(_selectedQuestId);
	}

	public function setSelectedQuest(questId:int):void
	{
		_selectedQuestId = questId;
		questSelected.dispatch();
	}

	public function setSelectedDialog(dialogId:int):void
	{
		_selectedDialogId = dialogId;
		dialogSelected.dispatch();
	}
	
	public function getSelectedDialog():QuestDialogVO
	{
		return getQuestById(_selectedQuestId).getDialogById(_selectedDialogId);
	}

	public function updateQuestData(quest:GameQuestVO):void
	{
		for (var i:int = 0; i < _quests.length; i++)
		{
			if (_quests[i].id == quest.id)
			{
				_quests[i] = quest;
				return;
			}
		}
		dataUpdate.dispatch();
	}

	public function updateDialogData(dialog:QuestDialogVO):void
	{
		for each (var quest:GameQuestVO in _quests)
		{
			if (quest.id == _selectedQuestId)
			{
				quest.updateDialog(dialog);
			}
		}
		dataUpdate.dispatch();
	}

	public function get quests():Vector.<GameQuestVO>
	{
		return _quests;
	}

	public function addQuest(quest:GameQuestVO):void
	{
		_quests.push(quest);
		dataUpdate.dispatch();
	}

	public function gexXML():XML
	{
		var rootXML:XML = new XML("<data></data>");
		for each (var gameQuest:GameQuestVO in _quests)
		{
			rootXML.appendChild(gameQuest.getXML());
		}
		//
		return rootXML;
	}

	public function get selectedQuestId():int
	{
		return _selectedQuestId;
	}

	public function get selectedDialogId():int
	{
		return _selectedDialogId;
	}
}
}