//
//  GaugeView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct GaugeView: View {
    var body: some View {
        let gradient = Gradient(colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple])
        
        List {
            Gauge(value: 0.5, in: 0.0...1.0, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50%")
            }, minimumValueLabel: {
                Text("0%")
            }, maximumValueLabel: {
                Text("100%")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.accessoryCircularCapacity)
            
            Gauge(value: 0.5, in: 0.0...1.0, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50%")
            }, minimumValueLabel: {
                Text("0%")
            }, maximumValueLabel: {
                Text("100%")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundColor(.gray)
            .tint(.green)
            
            Gauge(value: 50, in: 0...100, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50")
            }, minimumValueLabel: {
                Text("0")
            }, maximumValueLabel: {
                Text("100")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.accessoryCircular)
            
            Gauge(value: 0.5, in: 0.0...1.0, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50%")
            }, minimumValueLabel: {
                Text("0%")
            }, maximumValueLabel: {
                Text("100%")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.linearCapacity)
            
            Gauge(value: 0.5, in: 0.0...1.0, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50%")
            }, minimumValueLabel: {
                Text("0%")
            }, maximumValueLabel: {
                Text("100%")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.accessoryLinear)
            
            Gauge(value: 0.5, in: 0.0...1.0, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("50%")
            }, minimumValueLabel: {
                Text("0%")
            }, maximumValueLabel: {
                Text("100%")
            }, markedValueLabels: {
                Text("666")
            })
            .gaugeStyle(.automatic)
        }
        .tint(gradient)
        .padding()
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}
