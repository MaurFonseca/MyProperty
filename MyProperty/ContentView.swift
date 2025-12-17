//
//  ContentView.swift
//  WorkOrders
//
//  Created by Maurício Fonseca on 11/12/25.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var context
    
    @State private var showingCreateSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                creteButton
                
                Button("Mostrar caminho do banco"){
                    printDataBasePath()
                }

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
    
    private var creteButton: some View {
        Button{
            showingCreateSheet = true
        } label: {
            HStack{
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                Text("Create Work Order")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(width: 280, height: 55)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(15)
            .shadow(color: .blue.opacity(0.3), radius: 10, x:0, y: 5)
        }.navigationDestination(isPresented: $showingCreateSheet){
            CreateWorkOrderView()
        }
    }
    
    func printDataBasePath(){
        let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        if let files = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil){
            for file in files where file.pathExtension == "sqlite"{
                print("Arquivo: ")
                print("sqlite3 \"\(file.path)\"")
            }
        }
    }
}


//Para termos o preview ao lado ->
#Preview {
    ContentView()
        
}
