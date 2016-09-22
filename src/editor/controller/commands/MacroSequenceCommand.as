/**
 * Created by borisenki on 07.09.16.
 */
package editor.controller.commands
{
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

public class MacroSequenceCommand extends SequenceMacro
{
	override public function prepare():void
	{
		trace("--MacroSequenceCommand--prepare--")
		//
		add(LoadTypesCommand);

		registerCompleteCallback(registerComplete)
	}

	private function registerComplete(success:Boolean):void
	{
		if (success)
		{
			trace('--MacroSequenceCommand--', success);
		}
		else
		{
			trace('--MacroSequenceCommand--', success);
		}
	}
}
}
