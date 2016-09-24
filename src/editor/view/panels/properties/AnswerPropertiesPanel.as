/**
 * Created by borisenki on 24.09.16.
 */
package editor.view.panels.properties
{
import com.bit101.components.InputText;
import com.bit101.components.TextArea;
import com.bit101.utils.MinimalConfigurator;

import editor.model.vo.DialogAnswerVO;

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

public class AnswerPropertiesPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/properties/answer_properties_view.xml", mimeType="application/octet-stream")]
	private var answer_properties_Class:Class;

	private var config:MinimalConfigurator;

	private var answerIdLabel:InputText;
	private var answerText:TextArea;

	private var _questId:int;
	private var _dialogId:int;
	private var _answerId:int;

	private var _saveAnswerSignal:Signal;

	public function AnswerPropertiesPanel()
	{
		_saveAnswerSignal = new Signal();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new answer_properties_Class()));
		answerIdLabel = config.getCompById("answerIdLabel") as InputText;
		answerText = config.getCompById("answerText") as TextArea;
	}

	public function setInfo(answer:DialogAnswerVO):void
	{
		answerIdLabel.text = answer.id.toString();
		answerText.text = answer.text;
	}

	public function saveAnswer(e:Event):void
	{
		_saveAnswerSignal.dispatch();
	}

	public function get answerId():int
	{
		return _answerId;
	}

	public function set answerId(value:int):void
	{
		_answerId = value;
	}

	public function getAnswerText():String
	{
		return answerText.text;
	}

	public function get saveAnswerSignal():Signal
	{
		return _saveAnswerSignal;
	}


}
}
