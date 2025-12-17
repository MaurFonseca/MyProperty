//
//  WorkOrderViewModel.swift
//  MyProperty
//
//  Created by Maurício Fonseca on 15/12/25.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

@Observable
class WorkOrderViewModel{
    
    private var context: ModelContext
    
    init(context: ModelContext){
        self.context = context
    }
    
    // Crud Operations
    
    func createWorkOrder(
        fieldOperator: String,
        house: String,
        scheduleDate: Date? = nil,
        notes: String? = nil
    ) throws {
        let workOrder = WorkOrder(
            fieldOperator: fieldOperator,
            house: house,
            scheduleDate: scheduleDate,
            notes: notes
        )
        context.insert(workOrder)
        try context.save()
    }
}
