//
//  TextSelectionAPI.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/25.
//

import SwiftUI

struct TextSelectionAPI: View {
    @State private var text: String = "Hello World! Welcome to SwiftUI!"
    @State private var selection: TextSelection? = .init(insertionPoint: "".startIndex)
    
    var body: some View {
        VStack {
            TextEditor(text: $text, selection: $selection)
                .padding(15)
                .frame(height: 150)
                .background(.background, in: .rect(cornerRadius: 10))
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Button("Move Before Welcome") {
                        if let range = text.range(of: "Welcome") {
                            let endIndex = range.lowerBound
                            selection = .init(insertionPoint: endIndex)
                        }
                    }
                    
                    Button("Selection Hello") {
                        if let range = text.range(of: "Hello") {
                            selection = .init(range: range)
                        }
                    }
                }
                HStack(spacing: 15) {
                    Button("Move to first") {
                        selection = .init(insertionPoint: text.startIndex)
                    }
                    Button("Move to last") {
                        selection = .init(insertionPoint: text.endIndex)
                    }
                }
                let changeWorld = "Xiaofu"
                if let selectionTextRange, text[selectionTextRange] == "World" {
                    Button("Replace World With \(changeWorld)") {
                        text.replaceSubrange(selectionTextRange, with: changeWorld)
                        let startIndex = selectionTextRange.lowerBound
                        let endIndex = text.index(startIndex, offsetBy: changeWorld.count)
                        let newRange: Range<String.Index> = .init(uncheckedBounds: (startIndex, endIndex))
                        selection = .init(range: newRange)
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(15)
        .background(.gray.opacity(0.1))
        .navigationTitle("Text Selection")
    }
    
    var selectionTextRange: Range<String.Index>? {
        if let selection, !selection.isInsertion {
            switch selection.indices {
            case .selection(let range):
                return range
            default: return nil
            }
        }
        return nil
    }
}

#Preview {
    NavigationStack {
        TextSelectionAPI()
    }
}
