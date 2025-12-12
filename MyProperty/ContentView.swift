//
//  ContentView.swift
//  WorkOrders
//
//  Created by Maurício Fonseca on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    private let properties = ["HOUSE 123", "HOUSE 456", "HOUSE 789"]
    @State private var selectedProperty = "HOUSE 123"
    @State private var workOrderCount = 0
    @State private var operatorName = ""
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    Picker("Select the property", selection: $selectedProperty){
                        ForEach(properties, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                        TextField("Field Operators", text: $operatorName)
                }
                Section{
                    VStack{
                        HStack{
                            Button("Add Work Order"){
                                workOrderCount += 1
                            }
                            Spacer()
                            Text("Number of WOs: \(workOrderCount)")
                        }
                        
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            Button("Reset"){
                workOrderCount = 0
                operatorName = ""
            }
        }
    }
}

//Para termos o preview ao lado ->
#Preview {
    ContentView()
}
