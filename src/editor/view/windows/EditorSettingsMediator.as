/**
 * Created by borisenki on 12.09.16.
 */
package editor.view.windows
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class EditorSettingsMediator extends Mediator
{
	[Inject]
	public var view:EditorSettings;

	override public function initialize():void
	{
		super.initialize();
	}

	override public function destroy():void
	{
		super.destroy();
	}
}
}
