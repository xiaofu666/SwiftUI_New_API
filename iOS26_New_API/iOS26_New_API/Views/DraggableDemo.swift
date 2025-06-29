//
//  DraggableDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct DraggableDemo: View {
    @State private var selectedIDs: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                ForEach(colorItems) { item in
                    RoundedRectangle(cornerRadius:20)
                        .fill(item.color.gradient)
                        .frame(width: 80, height: 80)
                        .overlay {
                            if selectedIDs.contains(item.id) {
                                Image(systemName:"checkmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                            }
                        }
                        .onTapGesture {
                            if selectedIDs.contains(item.id) {
                                selectedIDs.removeAll { $0 == item.id }
                            } else {
                                selectedIDs.append(item.id)
                            }
                        }
                        .draggable(containerItemID: item.id)
                }
            }
            .dragContainer(for: String.self, selection: selectedIDs) { draggedItemID in
                return draggedItemID
            }
            
            RoundedRectangle(cornerRadius:20)
                .fill(.ultraThinMaterial)
                .overlay {
                    Text("Drop Area")
                }
                .dropDestination(for: String.self, isEnabled: true) { items, session in
                    print(items)
                }
                .onDropSessionUpdated { session in
                    print(session)
                }
        }
        .padding(20)
    }
}

#Preview {
    DraggableDemo()
}


struct ColorItem: Identifiable {
    var id: String = UUID().uuidString
    var color: Color
}

extension String: @retroactive Identifiable {
    public var id: String {
        return self
    }
}

let colorItems: [ColorItem] = [
    .init(color: .red),
    .init(color: .orange),
    .init(color: .yellow),
    .init(color: .green),
    .init(color: .cyan),
    .init(color: .blue),
]
