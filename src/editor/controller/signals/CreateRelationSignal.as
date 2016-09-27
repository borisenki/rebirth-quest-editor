/**
 * Created by borisenki on 27.09.16.
 */
package editor.controller.signals
{
import editor.view.workarea.AnswerView;

import org.osflash.signals.Signal;

public class CreateRelationSignal extends Signal
{
	public function CreateRelationSignal()
	{
		super(AnswerView);
	}
}
}
