//
//  WorkOrderViewModel.swift
//  MyProperty
//
//  Created by Maurício Fonseca on 15/12/25.
//

import Foundation
import SwiftUI
import Combine

class WorkOrderViewModel: ObservableObject{
    
    @Published var workOrders: [WorkOrder] = []
    
    init(){
        loadMockData()
    }
    
    func createWorkOrder(
        fieldOperator: String,
        house: String,
        scheduleDate: Date? = nil,
        notes: String? = nil
    ){
        let newWorkOrder = WorkOrder(
            fieldOperator: fieldOperator,
            house: house,
            scheduleDate: scheduleDate,
            notes: notes
        )
        workOrders.append(newWorkOrder)
    }
    
    private func loadMockData(){
        
    }
}
