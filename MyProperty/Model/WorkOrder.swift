//
//  WorkOrder.swift
//  MyProperty
//
//  Created by Maurício Fonseca on 12/12/25.
//

import Foundation
import SwiftData

@Model
class WorkOrder {
    @Attribute(.unique)var id: UUID
    var fieldOperator: String
    var house: String
    var createdAt: Date
    var scheduleDate: Date?
    var completedAt: Date?
    var notes: String?
    
    init(
        id: UUID = UUID(),
        fieldOperator: String,
        house: String,
        createdAt: Date = Date(),
        scheduleDate: Date? = nil,
        completedAt: Date? = nil,
        notes: String? = nil
    ){
        self.id = id
        self.fieldOperator = fieldOperator
        self.house = house
        self.createdAt = createdAt
        self.scheduleDate = scheduleDate
        self.completedAt = completedAt
        self.notes = notes
    }
}
