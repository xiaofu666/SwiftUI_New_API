//
//  ListViewRefresh.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ListViewRefresh: View {
    @State private var messages: [JonInfoStruct] = []
    @State private var searchTerm = ""
    @State private var searchScope = SearchScope.it
    
    var body: some View {
        LazyVStack {
            List(results) { user in
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.job)
                        .font(.title2.bold())
                    Text(user.desc)
                        .font(.body)
                }
                .listRowSeparatorTint(.red)
                .listRowSeparator(.hidden)
            }
            .refreshable {
                runSearch()
            }
            .searchable(text: $searchTerm, prompt: "请输入搜索内容")
            .searchScopes($searchScope)  {
                ForEach(SearchScope.allCases, id: \.self) { scope in
                  Text(scope.rawValue)
              }
            }
            .navigationTitle("找工作")
        }
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { _ in runSearch() }
        .onAppear() {
            runSearch()
        }
    }
    fileprivate var results: [JonInfoStruct] {
        if searchTerm.isEmpty {
            return messages
        } else {
            return messages.filter { $0.desc.localizedCaseInsensitiveContains(searchTerm) }
        }
    }
    
    func runSearch() {
        Task {
            let host = "https://be5de4c0-5749-4172-9c49-3b8280cd18e9.mock.pstmn.io"
            let requestUrl = "\(host)/webapi/\(searchScope.rawValue)"
            guard let url = URL(string: requestUrl) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([JonInfoStruct].self, from: data)
        }
    }
}

fileprivate enum SearchScope: String, CaseIterable {
    case it = "it"
    case market = "market"
}
fileprivate struct JonInfoStruct: Identifiable, Codable {
    let id: Int
    var job: String
    var desc: String
}

struct ListViewRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ListViewRefresh()
    }
}
