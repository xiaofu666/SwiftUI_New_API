//
//  iPad_TableView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct iPad_TableView: View {
    var body: some View {
        iPad_TableView()
    }
    
    @State private var selectedDownload = Set<DownloadLoad.ID>()
    @State private var sortOrder = [KeyPathComparator(\DownloadLoad.downloads)]
    @ViewBuilder
    func iPad_TableView() -> some View {
        //针对iPad新增的Table
        Table(iOS16_sampleDownloads, selection: $selectedDownload, sortOrder: $sortOrder) {
            TableColumn("Day", value: \.day)
            TableColumn("Downloads", value: \.downloadsString)
        }
        .onChange(of: sortOrder) {
            iOS16_sampleDownloads.sort(using: $0)
        }
        
        Text("\(selectedDownload.count) download selected")
    }
}

struct iPad_TableView_Previews: PreviewProvider {
    static var previews: some View {
        iPad_TableView()
    }
}
