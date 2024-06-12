//
//  ProfileModel.swift
//  SwiftUI_iOS17_Demo
//
//  Created by Lurich on 2023/7/24.
//

import SwiftUI

/// Sample Profile Model
struct ProfileModel: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

var profiles = [
    ProfileModel(userName:"iJustine", profilePicture: "user1", lastMsg: "Hi Kavsoft !!!", lastActive: "10:25 PM"),
    ProfileModel(userName:"Jenna Ezarik", profilePicture: "user2", lastMsg: "Nothing!", lastActive: "06:25 AM"),
    ProfileModel(userName:"Emily", profilePicture: "user3", lastMsg: "Binge Watching...", lastActive: "10:25 PM"),
    ProfileModel(userName:"Julie", profilePicture: "user4", lastMsg: "404 Page not Found!", lastActive: "10:25 PM"),
    ProfileModel(userName:"Kaviya", profilePicture: "user5", lastMsg: "Do not Disturb.", lastActive: "10:25 PM"),
]

