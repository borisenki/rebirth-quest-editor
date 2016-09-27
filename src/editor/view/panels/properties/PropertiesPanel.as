/**
 * Created by borisenki on 07.09.16.
 */
package editor.view.panels.properties
{
import editor.view.panels.*;

import com.bit101.components.Label;
import com.bit101.components.Panel;
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;

public class PropertiesPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/properties/properties_panel.xml", mimeType="application/octet-stream")]
	private var properties_panel_Class:Class;

	public static const QUEST_INFO_PANEL:int = 2;
	public static const DIALOG_INFO_PANEL:int = 4;
	public static const ANSWER_PROPERTIES_PANEL:int = 8;

	private var config:MinimalConfigurator;
	private var rootPanel:Panel;
	private var panelsContainer:Sprite;
	private var panelsContainerHeight:int;

	public function PropertiesPanel()
	{
		super();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new properties_panel_Class()));
		rootPanel = config.getCompById("rootPanel") as Panel;
		panelsContainer = new Sprite();
		addChild(panelsContainer);
		panelsContainerHeight = 0;
	}

	public function setEnable(enabled:Boolean):void
	{
		rootPanel.enabled = enabled;
	}

	public function fillPanel(mask:int):void
	{
		panelsContainer.removeChildren();
		panelsContainerHeight = 0;
		if (DIALOG_INFO_PANEL & mask)
		{
			addDialogInfo();
		}
		if (ANSWER_PROPERTIES_PANEL & mask)
		{
			addAnswerProperties();
		}
		if (QUEST_INFO_PANEL & mask)
		{
			addQuestInfo();
		}
	}

	private function addAnswerProperties():void
	{
		var answerProperties:AnswerPropertiesPanel = new AnswerPropertiesPanel();
		answerProperties.y = panelsContainerHeight;
		panelsContainer.addChild(answerProperties);
		panelsContainerHeight += 180;
	}

	public function addQuestInfo():void
	{
		var questInfo:QuestInfoPanel = new QuestInfoPanel();
		questInfo.y = panelsContainerHeight;
		panelsContainer.addChild(questInfo);
		panelsContainerHeight += 240;
	}

	public function addDialogInfo():void
	{
		var dialogInfo:DialogInfoPanel = new DialogInfoPanel();
		dialogInfo.y = panelsContainerHeight;
		panelsContainer.addChild(dialogInfo);
		panelsContainerHeight += 260;
	}
}
}
