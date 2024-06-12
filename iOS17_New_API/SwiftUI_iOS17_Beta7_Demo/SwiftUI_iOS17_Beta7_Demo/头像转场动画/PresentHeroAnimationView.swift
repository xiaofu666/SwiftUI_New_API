//
//  PresentHeroAnimationView.swift
//  SwiftUI_iOS17_Demo
//
//  Created by Lurich on 2023/8/28.
//

import SwiftUI

struct PresentHeroAnimationView: View {
    var body: some View {
        NavigationStack {
            PresentHeroAnimation()
        }
    }
}

struct PresentHeroAnimation: View {
    @State private var selectedProfile: ProfileModel?
    @State private var showProfileView: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Environment(WindowShareModel.self) private var windowShareModel
    @Environment(SceneDelegate.self) private var sceneDelegate
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15, content: {
                ForEach(profiles) { profile in
                    HStack(spacing: 12, content: {
                        GeometryReader { geometry in
                            let size = geometry.size
                            let rect = geometry.frame(in: .global)
                            Image(profile.profilePicture)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.circle)
                                .contentShape(.circle)
                                .opacity(windowShareModel.selectedProfile?.id == profile.id ? (windowShareModel.hideNativeView || showProfileView ? 0 : 1) : 1)
                                .onTapGesture {
                                    Task {
                                        selectedProfile = profile
                                        windowShareModel.selectedProfile = profile
                                        windowShareModel.cornerRadius = size.width / 2
                                        windowShareModel.sourceRect = rect
                                        windowShareModel.previousSourceRect = rect
                                        
                                        try? await Task.sleep(for: .seconds(0))
                                        windowShareModel.hideNativeView = true
                                        showProfileView.toggle()
                                        
                                        try? await Task.sleep(for: .seconds(0.5))
                                        if windowShareModel.hideNativeView {
                                            windowShareModel.hideNativeView = false
                                        }
                                    }
                                }
                        }
                        .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text(profile.userName)
                                .fontWeight(.bold)
                            
                            Text(profile.lastMsg)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    })
                }
            })
            .padding(15)
            .padding(.horizontal, 5)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Chat View")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                }
            }
        })
        .sheet(isPresented: $showProfileView, content: {
            DetailProfileView(selectedProfile: $selectedProfile, showProfileView: $showProfileView)
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(25)
                .interactiveDismissDisabled()
                .presentationDragIndicator(.hidden)
        })
        .onAppear() {
            guard sceneDelegate.heroWindow == nil else { return }
            sceneDelegate.addHeroWindow(windowShareModel)
        }
    }
}

struct DetailProfileView: View {
    @Binding var selectedProfile: ProfileModel?
    @Binding var showProfileView: Bool
    @Environment(\.colorScheme) private var colorScheme
    @Environment(WindowShareModel.self) private var windowShareModel
    
    var body: some View {
        VStack {
            GeometryReader(content: { geometry in
                let size = geometry.size
                let rect = geometry.frame(in: .global)
                
                if let selectedProfile {
                    Image(selectedProfile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .overlay {
                            let color = colorScheme == .dark ? Color.black : Color.white
                            LinearGradient(colors: [
                                .clear,
                                .clear,
                                .clear,
                                color.opacity(0.1),
                                color.opacity(0.4),
                                color.opacity(0.7),
                                color,
                            ], startPoint: .top, endPoint: .bottom)
                        }
                        .clipped()
                        .opacity(windowShareModel.hideNativeView ? 0 : 1)
                        .preference(key: RectKey.self, value: rect)
                        .onPreferenceChange(RectKey.self) { rect in
                            if showProfileView {
                                windowShareModel.sourceRect = rect
                                windowShareModel.showGradient = true
                            }
                        }
                }
            })
            .frame(height: 330)
            .overlay(alignment: .topLeading) {
                Button(action: {
                    Task {
                        windowShareModel.hideNativeView = true
                        try? await Task.sleep(for: .seconds(0))
                        showProfileView = false
                        windowShareModel.showGradient = false
                        try? await Task.sleep(for: .seconds(0))
                        windowShareModel.sourceRect = windowShareModel.previousSourceRect
                        
                        try? await Task.sleep(for: .seconds(0.5))
                        if windowShareModel.hideNativeView {
                            windowShareModel.reset()
                            selectedProfile = nil
                        }
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding(10)
                        .contentShape(.circle)
                        .background(.black, in: .circle)
                })
                .padding([.leading, .top], 20)
                .scaleEffect(0.9)
                .opacity(windowShareModel.hideNativeView ? 0 : 1)
                .animation(.snappy, value: windowShareModel.hideNativeView)
            }
            
            Spacer()
        }
    }
}

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

#Preview {
    PresentHeroAnimationView()
}

struct CustomHeroAnimationView: View {
    @Environment(WindowShareModel.self) private var windowShareModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let sourceRect = windowShareModel.sourceRect
                if let selectedProfile = windowShareModel.selectedProfile, windowShareModel.hideNativeView {
                    Image(selectedProfile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sourceRect.width, height: sourceRect.height)
                        .overlay {
                            let color = colorScheme == .dark ? Color.black : Color.white
                            LinearGradient(colors: [
                                .clear,
                                .clear,
                                .clear,
                                color.opacity(0.1),
                                color.opacity(0.4),
                                color.opacity(0.7),
                                color,
                            ], startPoint: .top, endPoint: .bottom)
                            .opacity(windowShareModel.showGradient ? 1 : 0)
                        }
                        .clipShape(.rect(cornerRadius: windowShareModel.cornerRadius))
                        .offset(x: sourceRect.minX, y: sourceRect.minY)
                        .animation(.snappy(duration: 0.3), value: windowShareModel.showGradient)
                }
            }
            .animation(.snappy(duration: 0.3), value: windowShareModel.sourceRect)
            .ignoresSafeArea()
        }
    }
}
