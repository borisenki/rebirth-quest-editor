/**
 * Created by borisenki on 06.09.16.
 */
package editor.view
{
import com.bit101.components.Label;
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;

public class StatusPanel extends Sprite
{
	[Embed(source="../../../assets/editor/panels/status_panel.xml", mimeType="application/octet-stream")]
	private var status_panel_Class:Class;

	private var config:MinimalConfigurator;
	private var _statusLabel:Label;

	public function StatusPanel()
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new status_panel_Class()));
		_statusLabel = config.getCompById("statusLabel") as Label;
	}

	public function setStatus(text:String):void
	{
		_statusLabel.text = text;
	}
}
}
