/**
 * Created by borisenki on 16.09.16.
 */
package editor.model.vo
{
public class QuestDialogVO
{
	private var _started:Boolean = false;
	private var _id:int;
	private var _text:String = "Текст диалога";
	private var _answers:Vector.<DialogAnswerVO>;

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

	public function getXML():XML
	{
		var questXML:XML = <dialog></dialog>;
		questXML.@id = _id;
		questXML.@started = _started;
		questXML.@text = _text;
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
