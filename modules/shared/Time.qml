// Time.qml
pragma Singleton

import Quickshell

Singleton {

  readonly property string currentTime: {
    Qt.formatDateTime(clock.date, " hh:mm")
  }

  readonly property string seconds: {
    Qt.formatDateTime(clock.date, "ss")
  }
  
  readonly property string date: {
    Qt.formatDateTime(clock.date, "ddd d/MMM/yy")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}