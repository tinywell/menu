//
//  MenuCardView.swift
//  Menu
//
//  Created by tinywell on 2021/10/02.
//

import SwiftUI

struct MenuCardView: View {
    @EnvironmentObject var appData:AppData
    
    @State var menu:MenuModel
    public let width:CGFloat=350
    public let height:CGFloat=263
    
    @State private var showConfirm=false
    
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
        .onLongPressGesture {
            self.showConfirm=true
        }
        .alert(isPresented: $showConfirm) {
            Alert(
                title: Text("此操作不可撤回"),
                message: Text("确定删除这个项目吗？"),
                primaryButton: .default(
                    Text("取消"),
                    action: {print("取消",menu.id,menu.name)}
                ),
                secondaryButton: .destructive(
                    Text("确定"),
                    action: {
                        print("删除")
                        self.appData.menus.removeAll { $0 == menu }
                        Helper.saveMenus(menus: self.appData.menus)
                    }
                )
            )
        }    
    }
}

struct MenuCardView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCardView(menu:Helper.getMenus()[0])
    }
}
