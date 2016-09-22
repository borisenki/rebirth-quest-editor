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
import flash.geom.Rectangle;
import flash.ui.Keyboard;

public class WorkPlane extends Sprite
{
	private var _spacePressed:Boolean = false;
	private var _area:Sprite;
	private var _dialogsCont:Sprite;
	private var _selectedQuest:GameQuestVO;

	public function WorkPlane()
	{
		super();
		_area = new Sprite();
		_dialogsCont = new Sprite();
		addChild(_area);
		addChild(_dialogsCont);
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
		_selectedQuest = quest;
		drawDialogs();
	}

	private function drawDialogs():void
	{
		_dialogsCont.removeChildren();
		var xOffset:int = 15;
		for each (var dialog:QuestDialogVO in _selectedQuest.dialogs)
		{
			var dialogView:DialogView = new DialogView();
			dialogView.setQuestDialog(dialog);
			dialogView.x = xOffset;
			dialogView.y = 15;
			_dialogsCont.addChild(dialogView);
			xOffset = dialogView.x + dialogView.width + 10;
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
