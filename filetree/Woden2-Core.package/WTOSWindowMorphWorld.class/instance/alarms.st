alarm-scheduler
alarms

	^alarms ifNil: [alarms := Heap sortBlock: self alarmSortBlock]