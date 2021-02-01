//
//  CounterView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var state: AppState

    @State private var showingModal = false
    @State private var showingAlert = false
    @State private var isNthPrimeButtonDisabled = false
    
    @State private var resultPrime: Int?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { self.state.count -= 1 }) { Text("-")}
                Text("\(self.state.count)")
                Button(action: { self.state.count += 1 }) { Text("+")}
            }
            
            Button(action: { showingModal.toggle() }) { Text("Ist das eine Primzahl?")}

            Button(action: {
                showingAlert.toggle()
                isNthPrimeButtonDisabled = true
                
                nthPrimeMock(self.state.count) { result in
                    self.resultPrime = result
                    isNthPrimeButtonDisabled = false
                }
            }) { Text("Was ist die \(self.state.count) Primzahl?")}
            .disabled(isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationTitle("Zähler")
        .sheet(isPresented: $showingModal) {
            IsPrimeModalView(state: state)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("The answer is always \(resultPrime ?? -1)"))
        }        
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(state: AppState())
    }
}
