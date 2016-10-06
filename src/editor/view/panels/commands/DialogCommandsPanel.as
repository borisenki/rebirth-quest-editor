package editor.view.panels.commands
{
import com.bit101.components.PushButton;
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

public class DialogCommandsPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/command/dialog_commands_view.xml", mimeType="application/octet-stream")]
	private var quest_info_Class:Class;

	private var config:MinimalConfigurator;
	private var createDialog:PushButton;
	private var _createDialogAnswerSignal:Signal;
	private var _deleteDialogSignal:Signal;
	private var _dialogId:int;

	public function DialogCommandsPanel()
	{
		_createDialogAnswerSignal = new Signal();
		_deleteDialogSignal = new Signal();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new quest_info_Class()));
		createDialog = config.getCompById("createAnswer") as PushButton;
	}

	public function createNewDialogAnswer(e:Event):void
	{
		_createDialogAnswerSignal.dispatch();
	}

	public function deleteDialog(e:Event):void
	{
		_deleteDialogSignal.dispatch();
	}

	public function get deleteDialogSignal():Signal
	{
		return _deleteDialogSignal;
	}

	public function set dialogId(value:int):void
	{
		_dialogId = value;
	}

	public function get dialogId():int
	{
		return _dialogId;
	}

	public function get createDialogAnswerSignal():Signal
	{
		return _createDialogAnswerSignal;
	}
}
}
