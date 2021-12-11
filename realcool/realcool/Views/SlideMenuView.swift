//
//  MenuView.swift
//  realcool
//
//  Created by Andrej Kling on 10.12.21.
//

import SwiftUI

struct SlideMenuView : View {
    
    @Binding var showMenu: Bool
    @Binding var animatePath: Bool
    @Binding var animateBG: Bool
  
    var body: some View {
        
        ZStack {
            
            BlurView(style: .systemMaterialDark)
            
            Color("blur")
                .opacity(0.8)
                .blur(radius: 15)
            
            MainMenuView()
     
        }
        .clipShape(MenuShape(value: animatePath ? 150 : 0))
        .background(
            
            MenuShape(value: animatePath ? 150 : 0)
                .stroke(
                    
                    .linearGradient(.init(colors: [
                        Color("blue"),
                        Color("blue")
                            .opacity(0.7),
                        Color("blue")
                            .opacity(0.5),
                        Color("blue")
                            .opacity(0.4),
                        Color("blue")
                            .opacity(0.1),
                        Color.clear
                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: animatePath ? 7 : 0 )
        )
        .opacity(0.8)
        .ignoresSafeArea()
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(showMenu: .constant(false), animatePath: .constant(false), animateBG: .constant(false))
    }
}


extension  SlideMenuView {
    
    @ViewBuilder
    func MainMenuView() -> some View {
        
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height < 750 ? 31 : 42) {
            
            Button(action: {
                
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                    animatePath.toggle()
                }
                
                withAnimation{
                    animateBG.toggle()
                }
                
                withAnimation(.spring().delay(0.1)){
                    showMenu.toggle()
                }
                
            }, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
            })
                .foregroundColor(Color.white.opacity(0.8))
    
             
            TabLabel( content: FlatView(), title: "Flat", image: "house.circle.fill", offset: 0)
                .padding(.top, 21)
             
            TabLabel( content: FlatView(),  title: "House", image: "house.circle", offset: 12)
              
            TabLabel( content: FlatView(),  title: "Account", image: "logo", offset: 31)
            
            TabLabel( content: FlatView(),  title: "Add own", image: "goforward.plus", offset: 12)
            
            TabLabel( content: FlatView(),  title: "Settings", image: "checkerboard.shield", offset: 0)
            
            Spacer(minLength: 10)
            
            TabLabel( content: FlatView(),  title: "LOGOUT", image: "rectangle.portrait.and.arrow.right", offset: 0)
               
        }
        .padding(.trailing,120)
        .padding(.leading, 33)
        .padding(.top, getSaveArea().top)
        .padding(.bottom, getSaveArea().bottom)
        .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    func TabLabel<Content: View> (content: Content, title: String, image: String, offset: CGFloat) -> some View {
        
        let isSmall = UIScreen.main.bounds.height < 750
     
       NavigationLink {
            
       
             content
//            Text("\(title)View")
              //  .navigationTitle(title)
            
        } label: {
            
            HStack(spacing: 18) {
                
                if image == "logo"{
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: isSmall ? 45 : 65, height: isSmall ? 45 : 65)
                        .clipShape(Circle())
                    
                } else {
                    
                    Image(systemName: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: isSmall ? 22 : 25, height: isSmall ? 22 : 25)
                        .foregroundColor(Color("blue").opacity(0.7))
                }
                
                Text(title)
                    .font(.system(size: isSmall ? 15 : 17))
                    .fontWeight(title == "LOGOUT" ? .semibold : .medium)
                    .kerning(title == "LOGOUT" ? 1.2 : 0.8)
                    .foregroundColor(Color.white.opacity(title == "LOGOUT" ? 0.9 : 0.81))
            }
            .offset(x: offset)
        }
       
    }
}
