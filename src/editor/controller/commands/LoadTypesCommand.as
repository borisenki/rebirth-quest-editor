/**
 * Created by borisenki on 07.09.16.
 */
package editor.controller.commands
{
import editor.controller.signals.StatusPanelSignal;
import editor.model.DataModel;
import editor.model.DataTypes;
import editor.model.vo.GameTypesVO;

import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class LoadTypesCommand extends AsyncCommand
{
	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	private var file:File;

	override public function execute():void
	{
		trace("Start--LoadTypesCommand");

		file = new File(File.applicationDirectory.nativePath + "//engine//types.xml");
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.READ);
		var typesXML:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
		stream.close();
		statusPanelSignal.dispatch("types.xml загружен");
		var gameTypesVO:GameTypesVO = new GameTypesVO(typesXML);
		dataModel.setData(DataTypes.GAME_TYPES, gameTypesVO);
		dispatchComplete(true);
	}
}
}
