/**
 * Created by borisenki on 17.09.16.
 */
package editor.view.panels
{
import com.bit101.components.InputText;
import com.bit101.components.TextArea;
import com.bit101.utils.MinimalConfigurator;

import editor.model.vo.QuestDialogVO;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class DialogInfoPanel extends Sprite
{
	[Embed(source="../../../../assets/editor/panels/properties/dialog_prop_view.xml", mimeType="application/octet-stream")]
	private var dialog_info_Class:Class;

	private var config:MinimalConfigurator;

	private var dialogIdLabel:InputText;
	private var dialogText:TextArea;
	private var dialogStarted:InputText;

	private var _questId:int;
	private var _dialogId:int;

	private var _saveDialogSignal:Signal;

	public function DialogInfoPanel()
	{
		_saveDialogSignal = new Signal();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new dialog_info_Class()));
		dialogIdLabel = config.getCompById("dialogIdLabel") as InputText;
		dialogStarted = config.getCompById("dialogStarted") as InputText;
		dialogText = config.getCompById("dialogText") as TextArea;
	}

	public function saveDialog(e:Event):void
	{
		_saveDialogSignal.dispatch();
	}

	public function setInfo(dialog:QuestDialogVO):void
	{
		dialogIdLabel.text = dialog.id.toString();
		dialogStarted.text = dialog.started.toString();
		dialogText.text = dialog.text;
	}

	public function get dialogId():int
	{
		return _dialogId;
	}

	public function set dialogId(value:int):void
	{
		_dialogId = value;
	}

	public function get questId():int
	{
		return _questId;
	}

	public function set questId(value:int):void
	{
		_questId = value;
	}

	public function getText():String
	{
		return dialogText.text;
	}

	public function get saveDialogSignal():Signal
	{
		return _saveDialogSignal;
	}
}
}
