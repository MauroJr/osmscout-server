// Parts of this file are generated by generate_language_gui.py

import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {

    id: main
    allowedOrientations : Orientation.All

    property string title
    property string comment
    property string value

    property var callback

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        Column {
            id: column

            width: parent.width
            spacing: Theme.paddingSmall
            anchors.margins: Theme.horizontalPageMargin

            DialogHeader {
                title: main.title
            }

            Label {
                text: main.comment
                x: Theme.horizontalPageMargin
                width: parent.width-2*x
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
            }

            // Language switches
	    // language selection switches
        }

        VerticalScrollDecorator {}
    }

    function add(a)
    {
        if (value.length < 1)
            value += a
        else
            value += ", " + a
    }

    onAccepted: {
        value = ""
	// language apply selection
	
        if (typeof callback == "function")
           callback(value);
     }

    Component.onCompleted:
    {
        var langs = value.split(',');
        for (var i=0; i < langs.length; ++i)
        {
            var l = langs[i].trim()
	    // language initialize
        }
    }
}


