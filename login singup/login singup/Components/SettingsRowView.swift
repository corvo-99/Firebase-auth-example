//
//  SettingsRowView.swift
//  login singup
//
//  Created by Dylan Corvo on 08/04/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let textRight: String
    let textRightColor: Color
    let tintColor: Color
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .foregroundStyle(tintColor)
            Text(title)
            Spacer()
            Text(textRight)
                .foregroundStyle(textRightColor)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", textRight: "1.0", textRightColor: Color(.gray), tintColor: Color(.gray))
}
