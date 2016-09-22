/**
 * Created by borisenki on 12.09.16.
 */
package editor.view.windows
{
import com.bit101.components.Panel;
import com.bit101.components.Window;
import com.bit101.utils.MinimalConfigurator;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

public class EditorSettings extends Window
{
	[Embed(source="../../../../assets/editor/windows/editor_settings.xml", mimeType="application/octet-stream")]
	private var settings_class:Class;

	private const EDITOR_SETTINGS:String = "Настройки редактора";
	private var config:MinimalConfigurator;

	public function EditorSettings(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
		super(parent, xpos, ypos, EDITOR_SETTINGS);
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new settings_class()));

		this.width = (config.getCompById("rootPanel") as Panel).width + 6;
		this.height = (config.getCompById("rootPanel") as Panel).height + 6;

		this.hasCloseButton = true;
	}


	override protected function onClose(event:MouseEvent):void {
		super.onClose(event);
		this.parent.removeChild(this);
	}
}
}
