//
//  iPad_TipTable.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct iPad_TipTable: View {
    let currencyStyle = Decimal.FormatStyle.Currency(code: "USD")

    var body: some View {
        Table(of: Purchase.self) {
            TableColumn("Base price") { purchase in
                Text(purchase.price, format: currencyStyle)
            }
            TableColumn("With 15% tip") { purchase in
                Text(purchase.price * 1.15, format: currencyStyle)
            }
            TableColumn("With 20% tip") { purchase in
                Text(purchase.price * 1.2, format: currencyStyle)
            }
            TableColumn("With 25% tip") { purchase in
                Text(purchase.price * 1.25, format: currencyStyle)
            }
        } rows: {
            TableRow(Purchase(price: 20))
            TableRow(Purchase(price: 50))
            TableRow(Purchase(price: 75))
        }
        
        VStack {
            Text(String(format: "%@", Date() as CVarArg))
            Group {
                Text(Date(), format: Date.FormatStyle().era(.wide))
                Text(Date(), format: Date.FormatStyle().year())
                Text(Date(), format: Date.FormatStyle().quarter())
                Text(Date(), format: Date.FormatStyle().month())
                Text(Date(), format: Date.FormatStyle().week())
                Text(Date(), format: Date.FormatStyle().day())
                Text(Date(), format: Date.FormatStyle().dayOfYear())
            }
            Group {
                Text(Date(), format: Date.FormatStyle().weekday())
                Text(Date(), format: Date.FormatStyle().hour())
                Text(Date(), format: Date.FormatStyle().minute())
                Text(Date(), format: Date.FormatStyle().second())
                Text(Date(), format: Date.FormatStyle().secondFraction(.fractional(3)))
                Text(Date(), format: Date.FormatStyle().timeZone(.identifier(.long)))
            }
            Button("时间") {
                let birthday = Date()

                let dateStr = birthday.formatted(
                    Date.FormatStyle()
                        .year(.defaultDigits)
                        .month(.abbreviated)
                        .day(.twoDigits)
                        .hour(.defaultDigits(amPM: .abbreviated))
                        .minute(.twoDigits)
                        .timeZone(.identifier(.long))
                        .era(.wide)
                        .dayOfYear(.defaultDigits)
                        .weekday(.abbreviated)
                        .week(.defaultDigits)
                )
                print(dateStr)
            }
            Text(Date().formatted(Date.FormatStyle().month(.defaultDigits)))
        }
    }
}

struct Purchase: Identifiable {
    let price: Decimal
    let id = UUID()
}

struct iPad_TipTable_Previews: PreviewProvider {
    static var previews: some View {
        iPad_TipTable()
    }
}
