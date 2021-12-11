//
//  MenuShape.swift
//  realcool
//
//  Created by Andrej Kling on 09.12.21.
//

import SwiftUI

struct MenuShape: Shape {
    
    var value : CGFloat
    
    var animatableData: CGFloat{
        
        get {return value}
        set {value = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            let width = rect.width - 100
            let height = rect.height
            
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            path.move(to: CGPoint(x: width, y: 0))
            
            path.addCurve(to: CGPoint(x: width, y: height + 100), control1: CGPoint(x: width + value, y: height / 3), control2: CGPoint(x: width - value, y: height / 2))
            
        }
    }
}
 
extension View {
    
    func getSaveArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
    
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}
