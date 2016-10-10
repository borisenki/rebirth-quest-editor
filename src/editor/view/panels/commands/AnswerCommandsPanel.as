package editor.view.panels.commands
{
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

public class AnswerCommandsPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/command/answer_command_view.xml", mimeType="application/octet-stream")]
	private var quest_info_Class:Class;

	private var config:MinimalConfigurator;
	private var _deleteAnswerSignal:Signal;
	private var _answerId:int;

	public function AnswerCommandsPanel()
	{
		_deleteAnswerSignal = new Signal();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new quest_info_Class()));
	}

	public function onDeleteAnswer(e:Event):void
	{
		_deleteAnswerSignal.dispatch();
	}

	public function get deleteAnswerSignal():Signal
	{
		return _deleteAnswerSignal;
	}

	public function set answerId(value:int):void
	{
		_answerId = value;
	}

	public function get answerId():int
	{
		return _answerId;
	}
}
}