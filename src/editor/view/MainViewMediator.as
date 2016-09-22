/**
 * Created by borisenki on 03.09.16.
 */
package editor.view
{
import editor.controller.signals.MacroSequenceSignal;
import editor.model.DataModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MainViewMediator extends Mediator
{
	[Inject]
	public var view:MainView;

	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var macroSequenceSignal:MacroSequenceSignal;

	override public function initialize():void
	{
		super.initialize();
		trace("initialize");
		macroSequenceSignal.dispatch();
	}

	override public function destroy():void
	{
		super.destroy();
	}
}
}
