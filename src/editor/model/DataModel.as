/**
 * Created by borisenki on 03.09.16.
 */
package editor.model
{
import flash.utils.Dictionary;

import editor.model.vo.DataVO;

import org.osflash.signals.Signal;

public class DataModel
{

	private var _data:Dictionary;
	public var dataUpdate:Signal;

	public function getData(key:String):Object
	{
		return _data[key];
	}

	public function setData(key:String, data:Object):void
	{
		_data[key] = data;
		dataUpdate.dispatch(new DataVO(key))
	}

	public function DataModel()
	{
		dataUpdate = new Signal(DataVO);
		_data = new Dictionary();
	}
}
}
