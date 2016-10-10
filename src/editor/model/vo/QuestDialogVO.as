package editor.model.vo
{
public class QuestDialogVO
{
	private var _started:Boolean = false;
	private var _id:int;
	private var _text:String = "Текст диалога";
	private var _answers:Vector.<DialogAnswerVO>;
	private var _positionX:int;
	private var _positionY:int;

	public function QuestDialogVO(xml:XML = null)
	{
		_answers = new Vector.<DialogAnswerVO>();
		
		if (xml != null)
		{
			_id = xml.@id;
			if (xml.@started != undefined)
			{
				_started = xml.@started;
			}
			if (xml.@text != undefined)
			{
				_text = xml.@text;
			}
			_positionX = (xml.@positionX != undefined) ? xml.@positionX : -1;
			_positionY = (xml.@positionY != undefined) ? xml.@positionY : -1;
			for each (var answer:XML in xml.answers.answer)
			{
				_answers.push(new DialogAnswerVO(answer));
			}
		}
		else
		{
			_id = 1;
			_started = false;
		}
	}

	public function deleteLinksToDialog(dialogId:int):void
	{
		for each (var answer:DialogAnswerVO in _answers)
		{
			if (answer.relation == dialogId)
			{
				answer.relation = -1;
			}
		}
	}

	public function deleteAnswer(answerId:int):void
	{
		for (var i:int = 0; i < _answers.length; i++)
		{
			if (_answers[i].id == answerId)
			{
				_answers.splice(i, 1);
				return;
			}
		}
	}

	public function updatePosition(posX:int, posY:int):void
	{
		positionX = posX;
		positionY = posY;
	}

	public function getAnswer(answerId:int):DialogAnswerVO
	{
		for each (var answer:DialogAnswerVO in _answers)
		{
			if (answer.id == answerId)
			{
				return answer;
			}
		}
		return null;
	}

	public function updateAnswer(answerData:DialogAnswerVO):void
	{
		for (var i:int = 0; i < _answers.length; i++)
		{
			if (_answers[i].id == answerData.id)
			{
				_answers[i] = answerData;
			}
		}
	}

	public function createNewAnswer():void
	{
		var lastId:int = 0;
		for each (var answer:DialogAnswerVO in _answers)
		{
			if (answer.id > lastId)
			{
				lastId = answer.id;
			}
		}
		lastId += 1;
		answer = new DialogAnswerVO();
		answer.id = lastId;
		_answers.push(answer);
	}

	public function get id():int
	{
		return _id;
	}

	public function set id(value:int):void
	{
		_id = value;
	}

	public function set started(value:Boolean):void
	{
		_started = value;
	}

	public function get started():Boolean
	{
		return _started;
	}

	public function set text(value:String):void
	{
		_text = value;
	}

	public function get text():String
	{
		return _text;
	}

	public function get label():String
	{
		return id + "|" + text;
	}

	public function get answers():Vector.<DialogAnswerVO>
	{
		return _answers;
	}

	public function set positionX(value:int):void
	{
		_positionX = value;
	}

	public function set positionY(value:int):void
	{
		_positionY = value;
	}

	public function get positionX():int
	{
		return _positionX;
	}

	public function get positionY():int
	{
		return _positionY;
	}

	public function getXML():XML
	{
		var questXML:XML = <dialog></dialog>;
		questXML.@id = _id;
		questXML.@started = _started;
		questXML.@text = _text;
		questXML.@positionX = _positionX;
		questXML.@positionY = _positionY;
		if (_answers.length > 0)
		{
			var dialogsList:XML = <answers></answers>;
			for each (var answer:DialogAnswerVO in _answers)
			{
				dialogsList.appendChild(answer.getXML());
			}
			questXML.appendChild(dialogsList);
		}
		return questXML;
	}
}
}
