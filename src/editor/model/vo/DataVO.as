/**
 * Created by borisenki on 03.09.16.
 */
package editor.model.vo
{
public class DataVO
{
	private var _key:String;

	public function DataVO(keyS:String)
	{
		_key = keyS;
	}

	public function get key():String
	{
		return _key;
	}
}
}
