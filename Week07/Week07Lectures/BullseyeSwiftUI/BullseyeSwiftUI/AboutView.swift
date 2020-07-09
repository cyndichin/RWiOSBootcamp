//
//  AboutView.swift
//  BullseyeSwiftUI
//
//  Created by cynber on 7/9/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    struct AboutHeadingStyle: ViewModifier {
      func body(content: Content) -> some View {
           return content.foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .padding(.top, 20)
            .padding(.bottom, 20)
      }
  }
    
    struct AboutBodyStyle: ViewModifier {
        func body(content: Content) -> some View {
             return content.foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
              .padding(.leading, 60)
              .padding(.trailing, 60)
             .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("Bullseye").modifier(AboutHeadingStyle()).lineLimit(nil).multilineTextAlignment(.center)
                Text("Summary").modifier(AboutBodyStyle()).lineLimit(nil).multilineTextAlignment(.center)
                Text("Enjoy!").modifier(AboutBodyStyle()).lineLimit(nil).multilineTextAlignment(.center)
            }.navigationBarTitle("Bullseye")
                .background(beige)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
