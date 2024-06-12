//
//  TipKit.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/8/29.
//

import SwiftUI
import TipKit

struct TipKit: View {
    var body: some View {
        TipKitContentView()
            .task {
                do {
                    try Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault),
                    ])
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}
struct TipKitContentView: View {
    private let tip = FavouriteTip()
    private let detailTip = FavouriteDetailTip()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("点击") {
                    VStack {
                        Text("进来三次会出来提示")
                    }
                    .onAppear() {
                        FavouriteDetailTip.numberOfRowClicks.sendDonation()
                    }
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                print(detailTip.status)
                            }, label: {
                                Image(systemName: "star")
                            })
                            .popoverTip(detailTip, arrowEdge: .top)
                        }
                    })
                }
            }
            .navigationTitle("Messages")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        FavouriteTip.showTip.toggle()
                        print(tip.status)
                    }, label: {
                        Image(systemName: "homekit")
                    })
                    .popoverTip(tip, arrowEdge: .top)
                }
            })
        }
    }
}

struct FavouriteTip: Tip {
    @Parameter
    static var showTip: Bool = false
    
    var title: Text {
        Text("首页提示")
    }
    
    var message: Text? {
        Text("点击就提示")
    }
    
    var image: Image? {
        Image(systemName: "star")
    }
    
    var rules: [Rule] {
        return [
            #Rule(Self.$showTip) { $0 == true },
        ]
    }
}

struct FavouriteDetailTip: Tip {
    static var numberOfRowClicks: Event = Event(id: "ListCellClicks")
    
    var title: Text {
        Text("详情页提示")
    }
    
    var message: Text? {
        Text("点击到三次了，我来提示了")
    }
    
    var image: Image? {
        Image(systemName: "star")
    }
    
    var options: [TipOption] {
        return [
            Tips.MaxDisplayCount(3)
        ]
    }
    
    var rules: [Rule] {
        return [
            #Rule(Self.numberOfRowClicks) { $0.donations.count >= 3},
        ]
    }
}

#Preview {
    TipKit()
}
