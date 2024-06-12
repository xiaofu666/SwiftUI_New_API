//
//  ChartView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var type: Int = 0
    @State private var style: Bool = false
    
    var body: some View {
        VStack {
            Button {
                style.toggle()
            } label: {
                Text("切换单双线")
            }
            
            chartView()
        }
    }
    
    @ViewBuilder
    func chartView() -> some View {
        let barColors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
        if style {
            VStack {
                Group {
                    switch type {
                    case 0:
                        Text("BarMark")
                    case 1:
                        Text("LineMark - 曲线")
                    case 2:
                        Text("RectangleMark")
                    case 3:
                        Text("AreaMark")
                    case 4:
                        Text("PointMark")
                    case 5:
                        Text("RuleMark")
                    case 6:
                        Text("LineMark - 折线")
                    default :
                        Text("RuleMark")
                    }
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                Chart(data) { item in
                    switch type {
                    case 0:
                        BarMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("City", item.city))
                        .position(by: .value("City", item.date))
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%.1f", item.hoursOfSunshine))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    case 1:
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [5, 8], dashPhase: 0))
                        .interpolationMethod(.catmullRom)//平滑曲线，还有其他样式
        //                .shadow(color: .black.opacity(0.8), radius: 3) // iOS 16.4新增
        //                .symbol(by: .value("Month", item.date)) // 添加原点
        //                .foregroundStyle(.blue.opacity(0.6))
                        .foregroundStyle(by: .value("City", item.city))
                        .symbol(by: .value("City", item.city)) // 添加原点
                    case 2:
                        RectangleMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("City", item.city))
                    case 3:
                        AreaMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .interpolationMethod(.linear)
                        .foregroundStyle(.linearGradient(colors:[
                            Color.red.opacity(0.6),
                            Color.green.opacity(0.3),
                            .clear
                        ], startPoint: .top, endPoint: .bottom))
                        .foregroundStyle(by: .value("City", item.city))
                    case 4:
                        PointMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("City", item.city))
                    case 5:
                        BarMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("City", item.city))
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%.1f", item.hoursOfSunshine))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                        
                        RuleMark(
                            y: .value("Mid", 60)
                        )
                        .foregroundStyle(.red)
                    case 6:
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Hours", item.hoursOfSunshine)
                        )
                        .interpolationMethod(.linear)//平滑曲线，还有其他样式
                        .foregroundStyle(by: .value("City", item.city))
                    default:
                        RuleMark(
                            y: .value("Mid", 150)
                        )
                    }
                }
                .frame(height: 300)
                
                Button {
                    type = type > 5 ? 0 : (type + 1)
                } label: {
                    Text("切换类型")
                }
            }
        } else {
            VStack(spacing: 20) {
                Group {
                    switch type {
                    case 0:
                        Text("BarMark")
                    case 1:
                        Text("LineMark - 曲线")
                    case 2:
                        Text("RectangleMark")
                    case 3:
                        Text("AreaMark")
                    case 4:
                        Text("PointMark")
                    case 5:
                        Text("RuleMark")
                    case 6:
                        Text("LineMark - 折线")
                    default :
                        Text("RuleMark")
                    }
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                Chart(iOS16_sampleDownloads) { item in
                    switch type {
                    case 0:
                        BarMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .foregroundStyle(by: .value("Day", item.day))
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%.1f", item.downloads))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    case 1:
                        LineMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [5, 8], dashPhase: 0))
    //                    .symbol(by: .value("Day", item.day)) // 添加原点
                        .interpolationMethod(.catmullRom)//平滑曲线，还有其他样式
//                        .shadow(color: .black.opacity(0.8), radius: 3) // iOS 16.4新增
                        .foregroundStyle(.gray.opacity(0.6))
                        
                        PointMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .foregroundStyle(by: .value("Day", item.day))
                    case 2:
                        RectangleMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
//                        .shadow(color: .black.opacity(0.8), radius: 3) // iOS 16.4新增
                        .foregroundStyle(by: .value("Day", item.day))
                    case 3:
                        AreaMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.linearGradient(colors:[
                            Color.red.opacity(0.6),
                            Color.green.opacity(0.3),
                            .clear
                        ], startPoint: .top, endPoint: .bottom))
                    case 4:
                        PointMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .foregroundStyle(by: .value("Day", item.day))
                    case 5:
                        BarMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
                        .foregroundStyle(by: .value("Day", item.day))
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%.1f", item.downloads))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                        
                        RuleMark(
                            y: .value("Mid", 150)
                        )
                        .foregroundStyle(.red)
                    case 6:
                        LineMark(
                            x: .value("Day", item.day),
                            y: .value("Downloads", item.downloads)
                        )
    //                    .symbol(by: .value("Day", item.day)) // 添加原点
                        .interpolationMethod(.linear)//平滑曲线，还有其他样式
                        .foregroundStyle(.blue.opacity(0.6))
                    default :
                        RuleMark(
                            y: .value("Mid", 150)
                        )
                    }
                }
                .chartForegroundStyleScale(domain: iOS16_sampleDownloads.compactMap({ download -> String? in
                    download.day
                }), range: barColors)
                .frame(height: 300)
                
                Button {
                    type = type > 5 ? 0 : (type + 1)
                } label: {
                    Text("切换类型")
                }

            }
        }
        
    }
}

struct MonthlyHoursOfSunshine: Identifiable {
    var id: String = UUID().uuidString
    var city: String
    var date: Date
    var hoursOfSunshine: Double
    
    init(city: String, month: Int) {
        let calendar = Calendar.autoupdatingCurrent
        self.city = city
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = Double.random(in: 0...100)
    }
}

struct DownloadLoad: Identifiable {
    var id: String = UUID().uuidString
    var day: String
    var downloads: Double
    var downloadsString: String {
        get {
            String(downloads)
        }
    }
}

var data: [MonthlyHoursOfSunshine] = {
    var array: [MonthlyHoursOfSunshine] = []
    for i in 1...12 {
        array.append(MonthlyHoursOfSunshine(city: "Seattle", month: i))
        array.append(MonthlyHoursOfSunshine(city: "Cupertino", month: i))
    }
    return array
}()

var iOS16_sampleDownloads: [DownloadLoad] = [
    DownloadLoad(day: "Mon", downloads: 100),
    DownloadLoad(day: "Tue", downloads: 250),
    DownloadLoad(day: "Wed", downloads: 300),
    DownloadLoad(day: "Thu", downloads: 40),
    DownloadLoad(day: "Fri", downloads: 90),
    DownloadLoad(day: "Sat", downloads: 70),
    DownloadLoad(day: "Sun", downloads: 120),
]

struct ChartView2: View {
    @State private var type: Int = 0
    
    var data: [Student] = {
        var array: [Student] = []
        for i in 1...2 {
            var infos: [ScoreInfo] = []
            for j in 1...7 {
                infos.append(ScoreInfo(score: Int.random(in: 1...100), day: "星期\(j)"))
            }
            array.append(Student(name: "学生\(i)", infos: infos))
        }
        return array
    }()
    let barColors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
    
    var body: some View {
        VStack {
            Group {
                switch type {
                case 0:
                    Text("BarMark")
                case 1:
                    Text("LineMark - 曲线")
                case 2:
                    Text("RectangleMark")
                case 3:
                    Text("AreaMark")
                case 4:
                    Text("PointMark")
                case 5:
                    Text("RuleMark")
                case 6:
                    Text("LineMark - 折线")
                default :
                    Text("RuleMark")
                }
            }
            .font(.largeTitle)
            .fontWeight(.bold)
            
            Chart(data) { student in
                switch type {
                case 0:
                    ForEach(student.infos) { item in
                        BarMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%d", item.score))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    }
                    .foregroundStyle(by: .value("学生", student.name))
                    .position(by: .value("学生", student.name))
                    
                case 1:
                    ForEach(student.infos) { item in
                        LineMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                    }
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [5, 8], dashPhase: 0))
                    .interpolationMethod(.catmullRom)//平滑曲线，还有其他样式
    //                .shadow(color: .black.opacity(0.8), radius: 3) // iOS 16.4新增
    //                .symbol(by: .value("Month", item.date)) // 添加原点
    //                .foregroundStyle(.blue.opacity(0.6))
                    .foregroundStyle(by: .value("学生", student.name))
                    .symbol(by: .value("学生", student.name)) // 添加原点
                case 2:
                    ForEach(student.infos) { item in
                        RectangleMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                    }
                    .foregroundStyle(by: .value("学生", student.name))
                    .position(by: .value("学生", student.name))
                case 3:
                    ForEach(student.infos) { item in
                        AreaMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                    }
                    .interpolationMethod(.monotone)
                    .foregroundStyle(.linearGradient(colors:[
                        Color.red.opacity(0.6),
                        Color.yellow.opacity(0.3),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .foregroundStyle(by: .value("学生", student.name))
                case 4:
                    ForEach(student.infos) { item in
                        PointMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                    }
                    .foregroundStyle(by: .value("学生", student.name))
                    .position(by: .value("学生", student.name))
                case 5:
                    ForEach(student.infos) { item in
                        BarMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                        .annotation(position: .automatic) {
                            Text("".appendingFormat("%d", item.score))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    }
                    .foregroundStyle(by: .value("学生", student.name))
                    .position(by: .value("学生", student.name))
                    
                    RuleMark(
                        y: .value("Mid", 60)
                    )
                    .foregroundStyle(.red)
                case 6:
                    ForEach(student.infos) { item in
                        LineMark(
                            x: .value("星期", item.day),
                            y: .value("分数", item.score)
                        )
                    }
                    .interpolationMethod(.linear)//平滑曲线，还有其他样式
                    .foregroundStyle(by: .value("学生", student.name))
                
                default:
                    RuleMark(
                        y: .value("Mid", 150)
                    )
                }
            }
            .frame(height: 300)
            
            Button {
                type = type > 5 ? 0 : (type + 1)
            } label: {
                Text("切换类型")
            }
        }
    }
}
struct Student: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var infos: [ScoreInfo]
    
    init(name: String, infos: [ScoreInfo]) {
        self.name = name
        self.infos = infos
    }
}

struct ScoreInfo: Identifiable {
    var id: String = UUID().uuidString
    var score: Int
    var day: String
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView2()
    }
}
