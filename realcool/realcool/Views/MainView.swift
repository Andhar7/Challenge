//
//  MainView.swift
//  realcool
//
//  Created by Andrej Kling on 10.12.21.
//

import SwiftUI

struct MainView: View {
    
    @State var showMenu : Bool = false
    @State var animatePath : Bool = false
    @State var animateBG : Bool = false
    
    @State var currentTab : String = "Home"
    @State var showMenuTab : Bool = false
  
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            BackTabView(currentTab: $currentTab)
            
            CustomTabView(currentTab: $currentTab, showMenuTab: $showMenuTab)
                .cornerRadius(self.showMenuTab ? 24 : 0)
                .rotation3DEffect(.init(degrees: self.showMenuTab ? -15 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                .offset(x: self.showMenuTab ? getRect().width / 2 : 0)
                .ignoresSafeArea()
             
            if showMenu, animatePath, animateBG  {
                
                ZStack {
                    
                    Color("blurBG")
                        .opacity(animateBG ? 0.69 : 0)
                        .ignoresSafeArea()
                    
                    SlideMenuView(showMenu: $showMenu, animatePath: $animatePath, animateBG: $animateBG)
                        .offset(x: showMenu ? 0 : -getRect().width)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
         MainView()
    }
}

extension MainView {
    
    @ViewBuilder
    func CustomTabView(currentTab: Binding<String>, showMenuTab: Binding<Bool>) -> some View {
        
        VStack(spacing: 0) {
            
            // Views for all pages...
            HStack(alignment: .top) {
                
                Button(action: {
                    withAnimation(.spring()){
                        self.showMenuTab = true
                    }
                }, label: {
                    
                    VStack(spacing: 7) {
                        Image(systemName: "gear")
                            .renderingMode(.template)
                            .font(.system(size: 31, weight: .regular, design: .serif))
                            .foregroundColor(.orange)
                        
                        Text("Menu")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                  
                })
                    .opacity(self.showMenuTab ? 0 : 1)
                    
                Spacer()
                
                Button(action: {
                    
                    withAnimation {
                        animateBG.toggle()
                    }
                    
                    withAnimation {
                        showMenu.toggle()
                    }
                    
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.4).delay(0.3)) {
                        animatePath.toggle()
                    }
                    
                }, label: {
                     
                    VStack(spacing: 5) {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 38, height: 38)
                            .clipShape(Circle())
                            .overlay(
                            
                                Circle()
                                    .strokeBorder(Color.orange, lineWidth: 1)
                        )
                        Text("Profile")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                  
                })
            }
            .padding(.horizontal, 21)
            .overlay(
            
                Text(self.currentTab)
                 .font(.system(size: 21, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .opacity(self.showMenuTab ? 0 : 1)
            )
            .padding(.bottom, 5)
            .padding(.top, getSaveArea().top)
            
            Divider()
                .background(Color.white)
            
            TabView(selection: $currentTab){
                
                FlatView()
                    .tag("Home")
                
                Text("Discover")
                    .tag("Discover")
                
                Text("Devices")
                    .tag("Devices")
                
                Text("Profile")
                    .tag("Profile")
            }
        }
        .disabled(self.showMenuTab)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            Button(action: {
                withAnimation(.spring()){
                    self.showMenuTab = false
                }
            }, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(.white)
            })
                .opacity(self.showMenuTab ? 1 : 0)
                .padding(.leading, 33)
                .padding(.top, 21)
            
            , alignment: .topLeading
        )
        .background(Color("blurBG"))
    }
}
