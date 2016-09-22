/**
 * Created by borisenki on 10.09.16.
 */
package editor.model.vo
{
public class CurrentEditableQuestVO
{
	private var _saved:Boolean = true;
	private var _gameQuest:GameQuestVO;

	public function CurrentEditableQuestVO()
	{
		//
	}

	public function get saved():Boolean
	{
		return _saved;
	}

	public function set saved(value:Boolean):void
	{
		_saved = value;
	}
}
}
