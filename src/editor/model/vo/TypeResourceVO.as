/**
 * Created by borisenki on 08.09.16.
 */
package editor.model.vo
{
public class TypeResourceVO
{
	private var _label:String;
	private var _id:String;

	public function TypeResourceVO(xml:XML)
	{
		_id = xml.@id;
		_label = xml.@label;
	}

	public function get id():String
	{
		return _id;
	}

	public function get label():String
	{
		return _label;
	}
}
}
