//
//  CreateWorkOrderView.swift
//  MyProperty
//
//  Created by Maurício Fonseca on 15/12/25.
//

import SwiftUI
import SwiftData

struct CreateWorkOrderView: View{
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    private var viewModel: WorkOrderViewModel {
        WorkOrderViewModel(context: context)
    }
    
    // Dados mockados para teste
    private let operadores: [String] = ["Maurício Fonseca", "Ana Oliveira", "José Pereira"]
    private let houses: [String] = ["HOUSE 123", "HOUSE 321", "HOUSE 567"]
    
    // Estados do formulário
    
    @State private var selectedOperator: String? = nil
    @State private var selectedHouse: String? = nil
    @State private var scheduleDate =  Date()
    @State private var hasScheduleDate = false
    @AppStorage("draft_workorder_notes") private var notes = ""
    
    // Estados de UI
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showAddOperator = false
    @State private var showAddHouse = false
    
    // Constantes
    private let notesLimit = 300
    
    var body: some View{
        NavigationStack{
            Form{
                operatorSection
                houseSection
                schedulingSection
                notesSection
            }
            .navigationTitle("Create new WorkOrder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Create") {
                        createWorkOrder()
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
            .alert("Error", isPresented: $showAlert){
                Button("OK", role: .cancel){}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var operatorSection: some View{
        Section("Operator"){
            Picker("Select Operator", selection: $selectedOperator){
                Text("Select an operator").tag(nil as String?)
                ForEach(operadores.sorted(), id: \.self){ operador in
                    Text(operador).tag(operador as String?)
                }
            }
        }
    }
    
    private var houseSection: some View{
        Section("House"){
            Picker("Select property", selection: $selectedHouse) {
                Text("Select a house").tag(nil as String?)
                ForEach(houses.sorted(), id: \.self) { house in
                    Text(house).tag(house as String?)
                }
            }.pickerStyle(.navigationLink)
        }
    }
    
    private var schedulingSection: some View {
        Section("Scheduling") {
            Toggle("Schedule date", isOn: $hasScheduleDate)

            if hasScheduleDate {
                DatePicker(
                    "Select date",
                    selection: $scheduleDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
        }
    }
    
    private var notesSection: some View {
        Section("Notes") {
            ZStack(alignment: .topLeading) {
                if notes.isEmpty {
                    Text("Enter notes for this work order...")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }

                TextEditor(text: $notes)
                    .frame(minHeight: 120)
                    .onChange(of: notes){ oldValue, newValue in
                        if newValue.count > notesLimit{
                            notes = String(newValue.prefix(notesLimit))
                        }
                    }
                HStack {
                    Spacer()
                    Text("\(notes.count)/\(notesLimit)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

            }
        }
    }
    
    private var isFormValid: Bool {
        selectedOperator != nil && selectedHouse != nil
    }
    
    private func createWorkOrder() {
        guard let operatorName = selectedOperator,
              let houseName = selectedHouse else {
            return
        }

        do{
            try viewModel.createWorkOrder(
                fieldOperator: operatorName,
                house: houseName,
                scheduleDate: hasScheduleDate ? scheduleDate : nil,
                notes: notes.isEmpty ? nil : notes
                )
            print("Created work order:  \(operatorName) - \(houseName) - \(notes) - \(scheduleDate)")
            
            notes = ""
            
            dismiss()
            
        }catch{
            alertMessage = "Failed to create work order. \(error.localizedDescription)"
            showAlert = true
            print("Error creating work order: \(error)")
        }
    
    }
    
}

#Preview {
    CreateWorkOrderView()
        .modelContainer(for: WorkOrder.self, inMemory: true)
}
