//
//  CounterView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var store: Store<AppState, AppAction>

    @State private var showingModal = false
    @State private var showingAlert = false
    @State private var isNthPrimeButtonDisabled = false
    
    @State private var resultPrime: Int?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { self.store.send(.counter(.decreaseTapped)) }) { Text("-")}
                Text("\(self.store.value.count)")
                Button(action: { self.store.send(.counter(.increaseTapped)) }) { Text("+")}
            }
            
            Button(action: { showingModal.toggle() }) { Text("Ist das eine Primzahl?")}

            Button(action: {
                showingAlert.toggle()
                isNthPrimeButtonDisabled = true
                
                nthPrimeMock(self.store.value.count) { result in
                    self.resultPrime = result
                    isNthPrimeButtonDisabled = false
                }
            }) { Text("Was ist die \(self.store.value.count) Primzahl?")}
            .disabled(isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationTitle("Zähler")
        .sheet(isPresented: $showingModal) {
            IsPrimeModalView(store: self.store)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("The answer is always \(resultPrime ?? -1)"))
        }        
    }
}

