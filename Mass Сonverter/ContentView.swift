//
//  ContentView.swift
//  Mass Сonverter
//
//  Created by Johnnie Walker on 10/7/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var origin: String = ""
    @State var selectedUnit: Int = 0
    
    var units = ["gram", "kilogram", "centner", "ton"]
    
    var doubleOrigin: Double {
        return Double(origin) ?? 0
    }
    
    var baseUnit: Double {
        return doubleOrigin * 1000
    }
    
    var converted: Double {
        let multiplicator: Double
        
        switch self.selectedUnit {
        case 0:
            multiplicator = 1
        case 1:
            multiplicator = 0.001
        case 2:
            multiplicator = 0.00001
        case 3:
            multiplicator = 0.000001
        default:
            return 0
        }
        
        return baseUnit * multiplicator
    }
    
    var specifier: String {
        switch self.selectedUnit {
        case 0:
            return "%.0f"
        case 1:
            return "%.2f"
        case 2:
            return "%.3f"
        case 3:
            return "%.4f"
        default:
            return "%.2f"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From kg")) {
                    TextField("Enter value", text: $origin)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("What value should you convert to?")) {
                    Picker("Select Unit", selection: $selectedUnit) {
                        ForEach(0 ..< units.count) { unit in
                            Text("\(self.units[unit])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(footer: Text("in \(doubleOrigin, specifier: "%.2f") kg.")) {
                    Text("\(converted, specifier: self.specifier) \(units[selectedUnit])")
                }
                
            }
            .navigationTitle("Mass Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
