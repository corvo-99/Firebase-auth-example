//
//  ConfirmationPopOverView.swift
//  login singup
//
//  Created by Dylan Corvo on 30/04/24.
//

import SwiftUI
// use SuccessPopoverView instead
struct ConfirmationPopOverView: View {
    @State var isShowingConfirmation : Bool
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 200, height: 200)
            .background(Material.thin)
            .cornerRadius(10)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isShowingConfirmation = false
                    }
                }
            }
            
    }
}

#Preview {
    ConfirmationPopOverView(isShowingConfirmation: false, text: "confirmed")
}
