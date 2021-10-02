//
//  MenuCardView.swift
//  Menu
//
//  Created by tinywell on 2021/10/02.
//

import SwiftUI

struct MenuCardView: View {
    @State var menu:MenuModel
    public let width:CGFloat=350
    public let height:CGFloat=263
    
    var body: some View {
        ZStack{
            VStack{
                Image(uiImage: menu.image)
                    .resizable()
            }
            VStack{
                Spacer()
                HStack{
                    VStack{
                        Text(menu.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Text(menu.addr)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                    Spacer()
                }.background(Rectangle().opacity(0.5))
            }
        }.frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct MenuCardView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCardView(menu:Helper.getMenus()[0])
    }
}
