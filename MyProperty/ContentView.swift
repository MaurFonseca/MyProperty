//
//  ContentView.swift
//  WorkOrders
//
//  Created by Maurício Fonseca on 11/12/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var workOrderViewModel = WorkOrderViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                NavigationLink(
                    destination: CreateWorkOrderView(
                        viewModel: workOrderViewModel
                    )
                ) {
                    Text("Create Work Order")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 55)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}


//Para termos o preview ao lado ->
#Preview {
    ContentView()
}
