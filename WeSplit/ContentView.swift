//
//  ContentView.swift
//  WeSplit
//
//  Created by Samar Kalra on 03/08/22.
//

import SwiftUI

struct ContentView: View {
    // Property wrappers
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    // Static array
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Computed property
    var perPersonShare: Double {
        let tip = checkAmount / 100 * Double(tipPercentage)
        let total = checkAmount + tip
        let amountPerPerson = total / Double(noOfPeople)
        return amountPerPerson
    }
    
    let currentType = Locale.current.currencyCode ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currentType))
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                    
                    Stepper("No of people: \(noOfPeople)", value: $noOfPeople, in: 2...100)
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip you want to leave?")
                }
                
                Section {
                    Text(perPersonShare, format: .currency(code: currentType))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button(role: .destructive, action: {
                        print("Trash pressed")
                    }) {
                        Label("", systemImage: "trash")
                    }
                    
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
