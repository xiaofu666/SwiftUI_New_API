//
//  GridView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        VStack(spacing: 30) {
            Grid(horizontalSpacing: 10,verticalSpacing: 10) {
                GridRow {
                    Color.red
                    Color.red
                    Color.red
                }
                GridRow {
                    Color.red
                        .gridCellColumns(2)
                    Color.red
                        .frame(width: 50, height: 50)
                        .gridCellAnchor(.trailing)
                }
            }
            .frame(height: 200)
            
            Grid {
                GridRow {
                    Color.blue
                    Color.blue
                    Color.blue
                }
                .frame(width: 50, height: 50)
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
//                    .gridColumnAlignment(.trailing)
                
                GridRow {
                    Color.blue
                        .frame(width: 30, height: 30)
                        .gridColumnAlignment(.leading)
                    Color.blue
                        .frame(width: 30, height: 30)
                        .gridColumnAlignment(.trailing)
                }
                
                GridRow {
                    Color.blue
                        .frame(width: 20, height: 20)
                        .gridCellAnchor(.topTrailing)
                    Color.blue
                        .frame(width: 20, height: 20)
                        .gridCellAnchor(.bottomLeading)
                    Color.blue
                        .frame(width: 50, height: 50)
                        .gridCellUnsizedAxes(.horizontal)
                        .gridCellUnsizedAxes(.vertical)
                }
            }
            .frame(height: 200)
            .background(.green)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
