//
//  AlarmEntity.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 03.06.2023.
//
import CoreData

extension AlarmEntity {
	convenience init(model: AlarmModel) {
		self.init()
		self.hour = Int16(model.hour)
		self.minute = Int16(model.min)
		self.isActive = model.isActive
		self.repeatingDays = model.repeatingDays
		self.id = Int64(model.id)
	}

	func toModel() -> AlarmModel {
		return AlarmModel(id: Int(self.id),
		                  hour: Int(self.hour),
		                  min: Int(self.minute),
		                  isPm: self.isPm,
		                  repeatingDays: self.repeatingDays ?? Array<Int>(),
		                  active: self.isActive)
	}
}
