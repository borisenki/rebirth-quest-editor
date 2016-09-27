/**
 * Created by borisenki on 10.09.16.
 */
package editor.view.workarea
{
import editor.Settings;
import editor.model.vo.GameQuestVO;
import editor.model.vo.QuestDialogVO;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;

public class WorkPlane extends Sprite
{
	private var _spacePressed:Boolean = false;
	private var _area:Sprite;
	private var _dialogsCont:Sprite;
	private var _relationsCont:Sprite;
	private var _selectedQuest:GameQuestVO;
	private var _dialogs:Vector.<DialogView>;

	private var _relationsAnswers:Vector.<AnswerView>;

	public function WorkPlane()
	{
		super();
		_dialogs = new <DialogView>[];
		_relationsAnswers = new <AnswerView>[];
		_area = new Sprite();
		_dialogsCont = new Sprite();
		_relationsCont = new Sprite();
		addChild(_area);
		addChild(_dialogsCont);
		addChild(_relationsCont);
		createPlane();
		initDrag();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(e:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	public function questSelected(quest:GameQuestVO):void
	{
		_dialogs = new <DialogView>[];
		_relationsAnswers = new <AnswerView>[];
		_selectedQuest = quest;
		drawDialogs();
	}

	private function drawDialogs():void
	{
		_dialogsCont.removeChildren();
		var xOffset:int = 15;

		for each (var dialog:QuestDialogVO in _selectedQuest.dialogs)
		{
			var newDialogView:DialogView = new DialogView();
			newDialogView.setQuestDialog(dialog);
			_dialogs.push(newDialogView);
		}

		for each (var dialogView:DialogView in _dialogs)
		{
			dialogView.initDialog();
			dialogView.x = xOffset;
			dialogView.y = 15;
			_dialogsCont.addChild(dialogView);
			xOffset = dialogView.x + dialogView.width + 40;
		}
		drawRelation();
	}

	private function getDialogViewById(dialogId:int):DialogView
	{
		for each (var dialogView:DialogView in _dialogs)
		{
			if (dialogView.questDialog.id == dialogId)
			{
				return dialogView;
			}
		}
		return null;
	}

	public function createRelation(answer:AnswerView):void
	{
		_relationsAnswers.push(answer);
	}

	private function drawRelation():void
	{
		_relationsCont.graphics.clear();
		for each (var answer:AnswerView in _relationsAnswers)
		{
			var dialogView:DialogView = getDialogViewById(answer.answerData.relation);
			var startDrawPoint:Point = _relationsCont.globalToLocal(answer.getGlobalPointOfRelation());
			var endDrawPoint:Point = _relationsCont.globalToLocal(dialogView.getGlobalPointOfRelation());
			_relationsCont.graphics.beginFill(0xFF0000, 1);
			_relationsCont.graphics.lineStyle(2, 0xFF0000);
			_relationsCont.graphics.moveTo(startDrawPoint.x, startDrawPoint.y);
			_relationsCont.graphics.lineTo(endDrawPoint.x, endDrawPoint.y);
			_relationsCont.graphics.endFill();
		}
	}

	private function initDrag():void
	{
		addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
	}

	private function onKeyUp(e:KeyboardEvent):void
	{
		if (e.charCode == Keyboard.SPACE)
		{
			onStopDrag();
			_spacePressed = false;
		}
	}

	private function onKeyDown(e:KeyboardEvent):void
	{
		if (e.charCode == Keyboard.SPACE)
		{
			_spacePressed = true;
		}
	}

	private function onStopDrag(e:MouseEvent = null):void
	{
		this.stopDrag();
	}

	private function onStartDrag(e:MouseEvent):void
	{
		if (_spacePressed)
		{
			var dragRect:Rectangle = new Rectangle();
			dragRect.x = Settings.PROPERTIES_PANEL_WIDTH;
			dragRect.y = 30;
			dragRect.width = 1280 - Settings.COMMAND_PANEL_WIDTH - Settings.PROPERTIES_PANEL_WIDTH - _area.width;
			dragRect.height = 720 - 30 - 30 - _area.height;
			this.startDrag(false, dragRect);
		}
	}

	private function createPlane():void
	{
		_area.graphics.clear();
		//
		var lineStep:int = 30;
		var w:int = Settings.DEFAULT_WORK_PLANE_WIDTH;
		var h:int = Settings.DEFAULT_WORK_PLANE_HEIGHT;
		//
		_area.graphics.beginFill(0xEEEEEE, 1);
		_area.graphics.lineStyle(1, 0x333333, 0.5);
		_area.graphics.moveTo(0, 0);
		_area.graphics.lineTo(w, 0);
		_area.graphics.lineTo(w, h);
		_area.graphics.lineTo(0, h);
		_area.graphics.lineTo(0, 0);
		for (var i:int = lineStep; i < w; i += lineStep)
		{
			_area.graphics.moveTo(i, 0);
			_area.graphics.lineTo(i, h);
		}
		for (i = lineStep; i < h; i += lineStep)
		{
			_area.graphics.moveTo(0, i);
			_area.graphics.lineTo(w, i);
		}
		_area.graphics.endFill();

	}

	public function destroy():void
	{
		removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);
	}
}
}
