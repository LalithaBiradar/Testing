import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.1

Window {
  id: dialogWindow
  width: 400
  height: 400
  flags: Qt.Dialog

  Button {
    id: closeButton
    onClicked: {
        dialogWindow.close();

        }

    }
  }

