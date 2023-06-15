//
//  InteractiveChatsView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/15.
//

import SwiftUI
import Charts

struct InteractiveChartsView: View {
    @State private var graphType: GraphType = .donut
    @State private var barSelection: String?
    @State private var pieSelection: Double?
    
    var body: some View {
        VStack {
            Picker("", selection: $graphType) {
                ForEach(GraphType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            ZStack {
                if let hightDownloads = appDownloads.max(by: {
                    $0.downloads < $1.downloads
                }) {
                    if graphType == .bar {
                        ChartPopOverView(hightDownloads.downloads, hightDownloads.month, true)
                            .opacity(barSelection == nil ? 1 : 0)
                    } else {
                        if let barSelection, let selectionDownloads = appDownloads.findDownloads(barSelection) {
                            ChartPopOverView(selectionDownloads, barSelection, true, true)
                        } else {
                            ChartPopOverView(hightDownloads.downloads, hightDownloads.month, true)
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Chart {
                ForEach(appDownloads.sorted(by: { graphType == .bar ? false :
                    $0.downloads > $1.downloads
                })) { download in
                    if graphType == .bar {
                        BarMark(
                            x: .value("Month", download.month),
                            y: .value("Downloads", download.downloads)
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                    } else {
                        // iOS 17 New API, Pie/Donut Chart
                        SectorMark(
                            angle: .value("Downloads", download.downloads),
                            innerRadius: .ratio(graphType == .donut ? 0.61 : 0),
                            angularInset: graphType == .donut ? 6 : 1
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                        .opacity(barSelection == nil ? 1 : (barSelection == download.month ? 1 : 0.4))
                    }
                }
                
                if let barSelection {
                    RuleMark(x: .value("Month", barSelection))
                        .foregroundStyle(.gray.opacity(0.35))
                        .offset(y: -5)
                        .zIndex(-10)
                        .annotation(position: .top, alignment: .center, spacing: 0, overflowResolution: .init(x: .fit, y: .disabled)) {
                            if let downloads = appDownloads.findDownloads(barSelection) {
                                ChartPopOverView(downloads, barSelection, false)
                            }
                        }
                }
            }
            .chartXSelection(value: $barSelection)
            .chartAngleSelection($pieSelection)
            .chartLegend(position: .bottom, alignment: graphType == .bar ? .leading : .center, spacing: 20)
            .frame(height: 200)
            .padding(.top, 10)
            .animation(graphType == .bar ? .none : .snappy, value: graphType)
            
            Spacer(minLength: 0)
        }
        .padding()
        .navigationTitle("Interactive Chart's'")
        .onChange(of: pieSelection, initial: false) { oldValue, newValue in
            if let newValue {
                findDownload(newValue)
            } else {
                barSelection = nil
            }
        }
    }
    
    @ViewBuilder
    func ChartPopOverView(_ downloads: Double, _ month: String, _ isTitleView: Bool, _ isSelection: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text("\(isTitleView && !isSelection ? "Highest" : "App") Downloads")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(alignment: .center, spacing: 4, content: {
                Text(String(format: "%.0f", downloads))
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(month)
                    .font(.title3)
                    .textScale(.secondary)
            })
        })
        .padding(isTitleView ? [.horizontal] : [.all])
        .background(.gray.opacity(isTitleView ? 0 : 0.15), in: .rect(cornerRadius: 8))
        .frame(maxWidth: .infinity, alignment: isTitleView ? .leading : .center)
    }
    
    func findDownload(_ rangeValue: Double) {
        var initialValue: Double = 0.0
        let convertedArray = appDownloads.sorted(by: { graphType == .bar ? false :
            $0.downloads > $1.downloads
        }).compactMap { download -> (String, Range<Double>) in
            let rangeEnd = initialValue + download.downloads
            let tuple = (download.month, initialValue ..< rangeEnd)
            initialValue = rangeEnd
            return tuple
        }
        if let download = convertedArray.first(where: { tuple in
            tuple.1.contains(rangeValue)
        }) {
            barSelection = download.0
        }
    }
}

#Preview {
    NavigationStack {
        InteractiveChartsView()
    }
}

struct AppDownload: Identifiable {
    var id: UUID = .init()
    var date: Date
    var downloads: Double
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}
extension [AppDownload] {
    func findDownloads(_ on: String) -> Double? {
        if let download = self.first(where: {
            $0.month == on
        }) {
            return download.downloads
        }
        return nil
    }
    
    func index(_ on: String) -> Int {
        if let index = self.firstIndex(where: {
            $0.month == on
        }) {
            return index
        }
        return 0
    }
}

var appDownloads: [AppDownload] = [
    .init(date:.createDate(1, 1, 2023), downloads: 2508),
    .init(date:.createDate(1, 2, 2023), downloads: 3500),
    .init(date:.createDate(1, 3, 2023), downloads: 1500),
    .init(date:.createDate(1, 4, 2023), downloads: 9500),
    .init(date:.createDate(1, 5, 2023), downloads: 1950),
    .init(date:.createDate(1, 6, 2023), downloads: 5100)
]

extension Date {
    static func createDate(_ day: Int, _ month: Int, _ year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        let calendar = Calendar.current
        let date = calendar.date(from: components) ?? .init()
        
        return date
    }
}

enum GraphType: String, CaseIterable {
    case bar = "Bar Chat"
    case pie = "Pie Chat"
    case donut = "Donut Chat"
}
