/**
 * Created by borisenki on 03.09.16.
 */
package editor.view.windows {
import com.bit101.components.ComboBox;
import com.bit101.components.InputText;
import com.bit101.components.Panel;
import com.bit101.components.Window;
import com.bit101.utils.MinimalConfigurator;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class QuestSettings extends Window {

    [Embed(source="../../../../assets/editor/windows/create_quest.xml", mimeType="application/octet-stream")]
    private var create_quest_Class:Class;

    private const CREATE_QUEST:String = "Свойства квеста";

    private var config:MinimalConfigurator;
    private var _typesList:ComboBox;
    private var _questIdLabel:InputText;
    private var _questLabel:InputText;

    private var _questId:int;

    private var _editQuest:Signal;

    public function QuestSettings(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
    {
        super(parent, xpos, ypos, CREATE_QUEST);
        _editQuest = new Signal();
        initComponents();
    }

    public function initComponents():void
    {
        config = new MinimalConfigurator(this);
        config.parseXML(XML(new create_quest_Class()));

        this.width = (config.getCompById("rootPanel") as Panel).width + 8;
        this.height = (config.getCompById("rootPanel") as Panel).height + 8;

        _typesList = config.getCompById("typesList") as ComboBox;
        _questIdLabel = config.getCompById("questIdLabel") as InputText;
        _questLabel = config.getCompById("questLabel") as InputText;
    }

    public function fillTypesList(questTypes:Object):void
    {
        for (var typeKey:String in questTypes)
        {
            _typesList.addItem(questTypes[typeKey]);
        }
        _typesList.selectedItem;
        _typesList.selectedIndex;
    }

    public function setQuestId(questId:int):void
    {
        _questId = questId;
        _questIdLabel.text = _questId.toString();
    }

    public function clickClose(event:MouseEvent = null):void {
        onClose(event);
        this.parent.removeChild(this);
    }

    public function clickSave(event:MouseEvent):void {
        _editQuest.dispatch();
    }

    public function getQuestLabel():String
    {
        return _questLabel.text;
    }

    public function get questId():int
    {
        return _questId;
    }

    public function getQuestType():String
    {
        return _typesList.selectedItem.id;
    }

    public function get editQuest():Signal
    {
        return _editQuest;
    }
}
}
