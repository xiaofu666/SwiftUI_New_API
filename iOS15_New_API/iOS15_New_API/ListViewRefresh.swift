//
//  ListViewRefresh.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ListViewRefresh: View {
    @State private var users: [UserModel] = []
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            List(results, id: \.id) { user in
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.username)
                        .font(.title2.bold())
                    Text(user.email)
                        .font(.body)
                }
                .listRowSeparatorTint(.red)
                .listRowSeparator(.hidden)
            }
            .refreshable {
                await fetchUsers()
            }
            .searchable(text: $searchText, prompt: "请下拉刷新数据", suggestions: {
                ForEach(results, id: \.id) { user in
                    Text(user.username)
                        .font(.title2.bold())
                        .searchCompletion(user.username)
                }
            })
            /*
             // iOS 16 新增  增加了分栏搜索。示例如下
             enum SearchScope: String, CaseIterable {
                 case it = "it"
                 case market = "market"
             }

             @State private var searchScope = SearchScope.it
             
             .searchScopes($searchScope)  {
                 ForEach(SearchScope.allCases, id: \.self) { scope in
                   Text(scope.rawValue)
               }
             }
             
             .onChange(of: searchScope) { _ in
                // 更新数据源
                if searchScope = .it {
                    results = it 数据源
                 } else {
                    results = 其他的 数据源
                 }
             }
             */
        }
    }
    var results: [UserModel] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.username.lowercased().contains(searchText.lowercased())}
        }
    }
    
    func fetchUsers() async {
        //这是普通的网络请求
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let session = URLSession(configuration: .default)
        do {
            let task = try await session.data(from: url)
            let users = try JSONDecoder().decode([UserModel].self, from: task.0)
            self.users = users
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ListViewRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ListViewRefresh()
    }
}


//MARK: - geo -

struct Geo: Codable {
    var lat: String?
    var lng: String?
}

//MARK: - address -

struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

//MARK: - company -

struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

//MARK: - UserModel -

struct UserModel: Codable {
    var id: Int
    var name: String?
    var username: String
    var email: String
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
}
