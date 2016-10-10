package editor.model.vo
{
public class GameQuestVO
{
	private var _id:int;
	private var _label:String;
	private var _type:String;

	private var _dialogs:Vector.<QuestDialogVO>;

	public function GameQuestVO(quest:XML = null)
	{
		_dialogs = new Vector.<QuestDialogVO>();
		if (quest != null)
		{
			_id = quest.@id;
			_label = quest.@label;
			_type = quest.@type;
			for each (var questDialog:XML in quest.dialogs.dialog)
			{
				_dialogs.push(new QuestDialogVO(questDialog));
			}
		}
		else
		{
			_id = 1;
			_label = "TEMP";
			_type = "TEMP";
			var mainDialog:QuestDialogVO = new QuestDialogVO();
			mainDialog.started = true;
			_dialogs.push(mainDialog);
		}
	}

	public function getDialogById(dialogId:int):QuestDialogVO
	{
		for each (var dialog:QuestDialogVO in _dialogs)
		{
			if (dialog.id == dialogId)
			{
				return dialog;
			}
		}
		return null;
	}

	public function createDialog():void
	{
		var lastId:int = 0;
		for each (var dialog:QuestDialogVO in _dialogs)
		{
			if (dialog.id > lastId)
			{
				lastId = dialog.id;
			}
		}
		lastId += 1;
		var newDialog:QuestDialogVO = new QuestDialogVO();
		newDialog.id = lastId;
		_dialogs.push(newDialog);
	}
	
	public function deleteDialog(dialogId:int):void
	{
		for (var i:int = 0; i < _dialogs.length; i++)
		{
			if (_dialogs[i].id == dialogId)
			{
				_dialogs.splice(i, 1);
			}
		}
	}

	public function deleteAnswer(dialogId:int, answerId:int):void
	{
		for (var i:int = 0; i < _dialogs.length; i++)
		{
			if (_dialogs[i].id == dialogId)
			{
				_dialogs[i].deleteAnswer(answerId);
			}
		}
	}

	public function deleteLinksToDialog(dialogId:int):void
	{
		for each (var dialog:QuestDialogVO in _dialogs)
		{
			dialog.deleteLinksToDialog(dialogId);
		}
	}

	public function updateDialog(dialog:QuestDialogVO):void
	{
		for (var i:int = 0; i < _dialogs.length; i++)
		{
			if (_dialogs[i].id == dialog.id)
			{
				_dialogs[i] = dialog;
				break;
			}
		}
	}

	public function set label(value:String):void
	{
		_label = value;
	}

	public function get label():String
	{
		return _label;
	}

	public function get type():String
	{
		return _type;
	}

	public function set type(value:String):void
	{
		_type = value;
	}

	public function get id():int
	{
		return _id;
	}

	public function set id(value:int):void
	{
		_id = value;
	}

	public function getXML():XML
	{
		var questXML:XML = <quest></quest>;
		questXML.@id = _id;
		questXML.@label = _label;
		questXML.@type = _type;
		if (_dialogs.length > 0)
		{
			var dialogsList:XML = <dialogs></dialogs>;
			for each (var questDialog:QuestDialogVO in _dialogs)
			{
				dialogsList.appendChild(questDialog.getXML());
			}
			questXML.appendChild(dialogsList);
		}
		return questXML;
	}

	public function get dialogs():Vector.<QuestDialogVO>
	{
		return _dialogs;
	}
}
}
