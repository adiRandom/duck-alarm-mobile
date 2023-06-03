//
//  AlarmEntity.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 03.06.2023.
//
import CoreData

extension AlarmEntity {
	convenience init(model: AlarmModel, context: NSManagedObjectContext) {
		self.init(entity: NSEntityDescription.entity(
			forEntityName: "AlarmEntity",
			in: context)!,
		insertInto: context)
		self.hour = Int16(model.hour)
		self.minute = Int16(model.min)
		self.isActive = model.isActive
		self.repeatingDays = model.repeatingDays
		self.id = Int64(model.id)
		self.isPm = model.isPm
	}

	func toModel() -> AlarmModel {
		return AlarmModel(id: Int(self.id),
		                  hour: Int(self.hour),
		                  min: Int(self.minute),
		                  isPm: self.isPm,
		                  repeatingDays: self.repeatingDays ?? [Int](),
		                  active: self.isActive)
	}
}
