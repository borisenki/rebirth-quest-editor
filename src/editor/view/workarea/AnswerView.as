package editor.view.workarea
{
import com.bit101.components.InputText;

import editor.model.vo.DialogAnswerVO;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.osflash.signals.Signal;

public class AnswerView extends Sprite
{
	private var _viewWidth:int = 250;
	private var answerLabel:InputText;
	private var _answerSelectedSignal:Signal;
	private var _createRelationSignal:Signal;
	private var _answerData:DialogAnswerVO;
	private var _dialogId:int;
	private var _relationPoint:Sprite;

	public function AnswerView()
	{
		_answerSelectedSignal = new Signal();
		_createRelationSignal = new Signal();
		answerLabel = new InputText(this, 0, 0);
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
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStade);
	}

	private function onAddedToStade(e:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStade);

		answerLabel.text = _answerData.id + "|" + _answerData.text;
		_relationPoint = createRelationPoint();
		addChildAt(_relationPoint, 0);
		_relationPoint.x = answerLabel.width;
		_relationPoint.y = answerLabel.height / 2;
		if (_answerData.relation != -1)
		{
			_createRelationSignal.dispatch();
		}
	}

	private function createRelationPoint():Sprite
	{
		var point:Sprite = new Sprite();
		point.graphics.beginFill(0x0, 0.8);
		point.graphics.drawCircle(0, 0, 7);
		point.graphics.endFill();
		point.graphics.beginFill(0x555555, 0.7);
		point.graphics.drawCircle(0, 0, 6);
		point.graphics.endFill();
		return point;
	}

	public function get answerSelectedSignal():Signal
	{
		return _answerSelectedSignal;
	}

	public function get createRelationSignal():Signal
	{
		return _createRelationSignal;
	}

	public function get answerData():DialogAnswerVO
	{
		return _answerData;
	}

	public function get dialogId():int
	{
		return _dialogId;
	}

	public function get relationPoint():Sprite
	{
		return _relationPoint;
	}

	public function getGlobalPointOfRelation():Point
	{
		return localToGlobal(new Point(_relationPoint.x, _relationPoint.y));
	}
}
}
