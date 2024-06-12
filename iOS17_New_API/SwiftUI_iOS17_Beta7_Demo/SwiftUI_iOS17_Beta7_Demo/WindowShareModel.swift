//
//  WindowShareModel.swift
//  SwiftUI_iOS17_Beta7_Demo
//
//  Created by Lurich on 2023/8/28.
//

import SwiftUI

@Observable
class WindowShareModel {
    var sourceRect: CGRect = .zero
    var previousSourceRect: CGRect = .zero
    var hideNativeView: Bool = false
    var selectedProfile: ProfileModel? = nil
    var cornerRadius: CGFloat = 0
    var showGradient: Bool = false
    
    func reset() {
        sourceRect = .zero
        previousSourceRect = .zero
        hideNativeView = false
        selectedProfile = nil
        cornerRadius = 0
        showGradient = false
    }
    
    
    var activeTab: FindAPP_Tab = .devices
}
