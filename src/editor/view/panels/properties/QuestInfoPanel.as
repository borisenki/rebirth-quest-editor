/**
 * Created by borisenki on 15.09.16.
 */
package editor.view.panels.properties
{
import com.bit101.components.ComboBox;
import com.bit101.components.InputText;
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;

public class QuestInfoPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/properties/quest_info_view.xml", mimeType="application/octet-stream")]
	private var quest_info_Class:Class;

	private var config:MinimalConfigurator;
	private var typesList:ComboBox;
	private var questIdLabel:InputText;
	private var questLabel:InputText;

	public function QuestInfoPanel()
	{
		initComponents();
	}

	private function initComponents():void
	{ 
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new quest_info_Class()));
		typesList = config.getCompById("typesList") as ComboBox;
		questIdLabel = config.getCompById("questIdLabel") as InputText;
		questLabel = config.getCompById("questLabel") as InputText;
		trace(this.height);
	}
}
}
