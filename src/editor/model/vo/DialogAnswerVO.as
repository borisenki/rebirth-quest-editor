/**
 * Created by borisenki on 22.09.16.
 */
package editor.model.vo
{
public class DialogAnswerVO
{
	private var _id:int;
	private var _text:String;

	public function DialogAnswerVO(xml:XML = null)
	{
		if (xml != null)
		{
			_id = xml.@id;
			_text = xml.@text;
		}
		else
		{
			_id = 1;
			_text = "TEMP"
		}
	}

	public function set id(value:int):void
	{
		_id = value;
	}

	public function get id():int
	{
		return _id;
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
		var xml:XML = <answer/>
		xml.@id = _id;
		xml.@text = _text;
		return xml;
	}
}
}
