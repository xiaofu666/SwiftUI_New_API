//
//  NavigationHeroAnimationView.swift
//  SwiftUI_iOS17_Demo
//
//  Created by Lurich on 2023/7/24.
//

import SwiftUI

struct NavigationHeroAnimationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedProfile: ProfileModel?
    @State private var pushView: Bool = false
    @State private var hideView: (Bool, Bool) = (false, false)
    
    var body: some View {
        NavigationStack {
            NavigationHeroAnimation(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationDestination(isPresented: $pushView, destination: {
                    DetailView(selectedProfile: $selectedProfile, pushView: $pushView, hideView: $hideView)
                })
                .navigationTitle("Profile")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("关闭") {
                            dismiss()
                        }
                    }
                })
        }
        .overlayPreferenceValue(AnchorKey.self, { value in
            GeometryReader(content: { geometry in
                if let selectedProfile, let anchor = value[selectedProfile.id], !hideView.0 {
                    let rect = geometry[anchor]
                    ImageView(profile: selectedProfile, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: rect)
                }
            })
        })
    }
}
struct NavigationHeroAnimation: View {
    @Binding var selectedProfile: ProfileModel?
    @Binding var pushView: Bool
    
    var body: some View {
        List {
            ForEach(profiles) { profile in
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15, content: {
                        Color.clear
                            .frame(width: 60, height: 60)
                            .anchorPreference(key: AnchorKey.self, value: .bounds, transform: { anchor in
                                return [profile.id: anchor]
                            })
                        
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    })
                    .contentShape(.rect)
                })
            }
        }
        .overlayPreferenceValue(AnchorKey.self, { value in
            GeometryReader(content: { geometry in
                ForEach(profiles) { profile in
                    if let anchor = value[profile.id], selectedProfile?.id != profile.id {
                        let rect = geometry[anchor]
                        ImageView(profile: profile, size: rect.size)
                            .offset(x: rect.minX, y: rect.minY)
                            .allowsHitTesting(false)
                    }
                }
            })
        })
    }
}

struct ImageView: View {
    var profile: ProfileModel
    var size: CGSize
    
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .overlay(content: {
                LinearGradient(colors: [
                    .clear,
                    .clear,
                    .clear,
                    .white.opacity(0.1),
                    .white.opacity(0.5),
                    .white.opacity(0.9),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 60 ? 1 : 0)
            })
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}

struct DetailView: View {
    @Binding var selectedProfile: ProfileModel?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    
    var body: some View {
        if let selectedProfile {
            VStack {
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectedProfile, size: size)
                                .overlay(alignment: .topTrailing) {
                                    ZStack {
                                        Button(action: {
                                            pushView = false
                                            hideView = (false, false)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                self.selectedProfile = nil
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(.black, in: .circle)
                                                .contentShape(Circle())
                                        })
                                        .padding(15)
                                        .padding(.top, 30)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        Text(selectedProfile.userName)
                                            .font(.title).bold()
                                            .foregroundStyle(.black)
                                            .padding(15)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    }
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                }
                            
                        } else {
                            Color.clear
                        }
                    }
                    .anchorPreference(key: AnchorKey.self, value: .bounds, transform: { anchor in
                        return [selectedProfile.id: anchor]
                    })
                })
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer()
            }
            .toolbar(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    hideView.0 = true
                }
            }
        }
    }
}

#Preview {
//    NavigationStack {
        NavigationHeroAnimationView()
//    }
}
