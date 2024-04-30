//
//  ButtonActionLabel.swift
//  login singup
//
//  Created by Dylan Corvo on 07/04/24.
//

import SwiftUI

struct ButtonActionLabel: View {
    let action: () -> Void
    let title: String
    let imageSFSymbol: String
    var body: some View {
        Button(action: action){
            //label
            HStack{
                Text(title)
                    .fontWeight(.semibold)
                Image(systemName: imageSFSymbol)
            }
            .foregroundStyle(Color.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemOrange))
        .cornerRadius(10)
    }
}

#Preview {
    ButtonActionLabel(action: {}, title: "Buttontext", imageSFSymbol: "arrow.right")
}
