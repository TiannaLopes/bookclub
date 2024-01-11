//
//  InputView.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/11/24.
//

import SwiftUI

struct InputView: View{
    @Binding var text:String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    let darkMaroon = Color(hex: "3D0814")
    let paleYellow = Color(hex: "E7F9A9")
    let oliveGreen = Color(hex: "C9D3BE")
    let tan = Color(hex: "CDBB9E")
    let deepPurple = Color(hex: "442F38")
    let offWhite = Color(hex: "FDFDFD")
    
    var body: some View{
        VStack(alignment: . leading, spacing:12){
            Text(title)
             .foregroundColor(darkMaroon)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider{
    static var previews: some View{
        InputView(text: .constant(""), title: "Email Address: ", placeholder: "name@example.com")
    }
}
