//
//  HomeView.swift
//  realcool
//
//  Created by Andrej Kling on 09.12.21.
//

import SwiftUI

struct FlatView: View {
    var body: some View {
        ScrollView {
            
            VStack {
                
                ForEach(1 ..< 15) { item in
                    Image("p\(item)")
                        .resizable()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FlatView()
    }
}
