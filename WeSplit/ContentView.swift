//
//  ContentView.swift
//  WeSplit
//
//  Created by Milena Maia Araújo on 19/04/22.
//

import SwiftUI

struct ContentView: View {
    // the state makes the value update with every single change of the user!
    @State private var checkAmount = 0.0
    @State private var numberOfPeoples = 2
    @State private var tipPercentage = 20
    @FocusState private var amoutIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPersons: Double{
        // calculate the toral per person
        
        let peopleCount = Double(numberOfPeoples + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad)
                        .focused($amoutIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeoples){
                        ForEach(2..<100){
                            Text("\($0) people")
                        } // for each
                    } // picker
                } //section
                
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        } // for each
                    }.pickerStyle(.segmented) // picker
                } header: {
                    Text("How much tip do you want to leave? ")
                } // header // section
                
                Section {
                    Text(totalPerPersons, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } // section
            }.navigationTitle("We Split")
                .navigationBarTitleDisplayMode(.inline)// form
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer() // ios convention, mooves the "Done" button to the left
                        
                        Button("Done"){
                            amoutIsFocused = false
                        } // button
                    } // toolbar item group
                } // toolBar
        } // navigation view
    } // view
} // struct content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
