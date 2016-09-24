/**
 * Created by borisenki on 15.09.16.
 */
package editor.view.workarea
{
import com.bit101.components.InputText;
import com.bit101.components.Label;
import com.bit101.components.Style;
import com.bit101.components.Text;

import editor.Settings;
import editor.model.vo.DialogAnswerVO;
import editor.model.vo.QuestDialogVO;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Rectangle;

import org.osflash.signals.Signal;

public class DialogView extends Sprite
{
	private var _questDialog:QuestDialogVO;
	private var _questDialogSetup:Signal;
	private var _selectDialog:Signal;
	private var _viewWidth:int = 250;
	private var _viewHeight:int = 200;

	private var _container:Sprite;
	private var _containerViews:Sprite;

	public function DialogView()
	{
		_questDialogSetup = new Signal();
		_selectDialog = new Signal();
		_container = new Sprite();
		_containerViews = new Sprite();
		addChild(_container);
		addChild(_containerViews);
		draw();
		initDrag();
		_container.addEventListener(MouseEvent.CLICK, onClickView);
	}

	public function dialogSelected(dialogId:int):void
	{
		if (_questDialog.id == dialogId)
		{
			filters = [new GlowFilter(0xD6A552, 1, 10, 10, 4)];
		}
		else
		{
			filters = [];
		}
	}

	private function onClickView(e:MouseEvent):void
	{
		_selectDialog.dispatch();
	}

	private function draw(e:Event = null):void
	{
		_viewHeight = _container.height + _containerViews.height + 15;
		graphics.clear();
		graphics.beginFill(0x666666, 1);
		graphics.lineStyle(1, 0x333333);
		graphics.drawRoundRect(0, 0, _viewWidth, _viewHeight, 10, 10);
		graphics.endFill();
	}

	private function initDrag():void
	{
		addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
	}

	private function onStopDrag(e:MouseEvent = null):void
	{
		this.stopDrag();
	}

	private function onStartDrag(e:MouseEvent):void
	{
		var dragRect:Rectangle = new Rectangle();
		dragRect.x = Settings.PROPERTIES_PANEL_WIDTH;
		dragRect.y = 30;
		dragRect.width = 1280 - Settings.COMMAND_PANEL_WIDTH - Settings.PROPERTIES_PANEL_WIDTH - this.width;
		dragRect.height = 720 - 30 - 30 - this.height;
		this.startDrag(false);
	}

	public function setQuestDialog(questDialog:QuestDialogVO):void
	{
		_questDialog = questDialog;
		initComponents();
	}

	private function initComponents():void
	{
		_container.removeChildren();
		_containerViews.removeChildren();
		var idLabel:Label = new Label(_container, 3, 3, "ID-" + _questDialog.id);
		idLabel.textField.textColor = 0xEDBE3F;
		var temp:uint = Style.LABEL_TEXT;
		Style.LABEL_TEXT = 0xEDBEFF;
		var textLabel:Text = new Text(_container, 0, 20, _questDialog.text);
		textLabel.draw();
		textLabel.width = _viewWidth;
		textLabel.editable = false;
		Style.LABEL_TEXT = temp;

		var startAnswerPosition:int = 0;
		for each (var answer:DialogAnswerVO in _questDialog.answers)
		{
			var answerView:AnswerView = new AnswerView();
			answerView.setDialogId(_questDialog.id);
			answerView.setAnswer(answer);
			answerView.y = int(startAnswerPosition);
			_containerViews.addChild(answerView);
			startAnswerPosition += 5 + answerView.height;
		}
		_containerViews.y = int(_container.height) + 5;

		draw();
	}

	public function get selectDialog():Signal
	{
		return _selectDialog;
	}

	public function get questDialog():QuestDialogVO
	{
		return _questDialog;
	}

	public function destroy():void
	{
		removeEventListener(MouseEvent.CLICK, onClickView);
	}
}
}
