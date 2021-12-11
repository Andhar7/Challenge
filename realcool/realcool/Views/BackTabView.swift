//
//  BackTabView.swift
//  realcool
//
//  Created by Andrej Kling on 10.12.21.
//

import SwiftUI

struct BackTabView: View {
    
    @Binding var currentTab : String
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top, spacing: 12) {
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(.orange,lineWidth: 1))
                    .padding(2)
                    .overlay(Circle().strokeBorder(.white,lineWidth: 0.5))
                
                Text("Reality\nestate")
                 .font(.system(size: 15, weight: .regular, design: .serif))
                 .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth:.infinity, alignment: .leading)
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 24){
                    
                    CustomTabButton(titleButton: "Home", icon: "theatermasks.fill")
                 
                    CustomTabButton(titleButton: "Discover", icon: "safari.fill")
                    
                    CustomTabButton(titleButton: "Devices", icon: "applewatch")
                    
                    CustomTabButton(titleButton: "Profile", icon: "person.fill")
                    
                    CustomTabButton(titleButton: "Setting", icon: "gearshape.fill")
                    
                    CustomTabButton(titleButton: "About", icon: "info.circle.fill")
                    
                    CustomTabButton(titleButton: "Help", icon: "questionmark.circle.fill")
                    
                    Spacer()
                    
                    // making Logout as costant button with orange color...
                    CustomTabButton(titleButton: "Logout", icon: "rectangle.portrait.and.arrow.right")
                }
                .padding()
                .padding(.top, 45)
            }
            .frame(width: getRect().width / 2, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 12)
        .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .top)
        .background(
        
            Color("blurBG")
        )
    }
}

struct BackTabView_Previews: PreviewProvider {
    static var previews: some View {
        BackTabView(currentTab: .constant(""))
    }
}

extension BackTabView {
    
    @ViewBuilder
    func CustomTabButton(titleButton: String, icon: String) -> some View {
        
        Button(action: {
            
            if titleButton == "Logout"{
                
                print("Logout")
            } else {
                
                withAnimation {
                    currentTab = titleButton
                }
            }
            
        }, label: {
            HStack(spacing: 12) {
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .frame(width: currentTab == titleButton ? 48 : nil, height: 48)
                    .foregroundColor(currentTab == titleButton ? Color.orange : titleButton == "Logout" ? Color.purple : .white)
                    .background(
                    
                        ZStack {
                            
                            if currentTab == titleButton {
                                
                                Color.white
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TABCIRCLE", in: animation)
                            }
                        }
                )
                
                Text(titleButton)
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                    .foregroundColor(titleButton == "Logout" ? Color.orange : .white)
            }
            .padding(.trailing, 18)
            .background(
            
                ZStack {
                    
                    if currentTab == titleButton {
                        
                        Color.orange
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "TABCAPSULE", in: animation)
                    }
                }
                
            )
        })
            .offset(x: currentTab == titleButton ? 18 : 0)
    }
}
