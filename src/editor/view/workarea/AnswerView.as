package editor.view.workarea
{
import com.bit101.components.InputText;

import editor.model.vo.DialogAnswerVO;

import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class AnswerView extends Sprite
{
	private var _viewWidth:int = 250;
	private var answerLabel:InputText;
	private var _answerSelectedSignal:Signal;
	private var _answerData:DialogAnswerVO;
	private var _dialogId:int;

	public function AnswerView()
	{
		_answerSelectedSignal = new Signal();
		answerLabel = new InputText(this, 0, 3);
		answerLabel.textField.textColor = 0xEDBE3F;
		answerLabel.width = _viewWidth;
		answerLabel.draw();
		addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
	}

	private function onClick(e:MouseEvent):void
	{
		_answerSelectedSignal.dispatch();
	}

	public function setDialogId(dialogId:int):void
	{
		_dialogId = dialogId;
	}

	public function setAnswer(answerData:DialogAnswerVO):void
	{
		_answerData = answerData;
		answerLabel.text = answerData.id + "|" + answerData.text;
	}

	public function get answerSelectedSignal():Signal
	{
		return _answerSelectedSignal;
	}

	public function get answerData():DialogAnswerVO
	{
		return _answerData;
	}

	public function get dialogId():int
	{
		return _dialogId;
	}
}
}
