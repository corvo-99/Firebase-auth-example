//
//  SuccessPopoverView.swift
//  login singup
//
//  Created by Dylan Corvo on 30/04/24.
//

import SwiftUI
struct SuccessPopoverView: View {
    
    let message: String
    
    init(message: String = "Action successful") {
        self.message = message
    }
    
    var body: some View {
        
        VStack (alignment: .center) {
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
                .padding()
                .fontWeight(.light)

            Text(message)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(width: 240)
        .background(.ultraThickMaterial)
        .cornerRadius(14)
        .shadow(
            color: .black.opacity(0.3),
            radius: 20
        )
    }
}

#Preview {
        SuccessPopoverView(
            message: "Added Outfit to\nStyle"
        )
    
}
