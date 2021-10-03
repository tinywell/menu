//
//  ContentView.swift
//  Menu
//
//  Created by tinywell on 2021/10/01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData:AppData
    
    @State private var showAddMenu=false
    @State private var showConfirm=false
    @State private var showRandom=false
    
    var body: some View {
        
        NavigationView{
            VStack{
                MenuScrollView().environmentObject(appData)
                
                Button(action: {
                    showRandom=true
                }){
                    Image(systemName: "circle.circle")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
//                .offset(y:-100)
            }
            .sheet(isPresented: $showRandom, content: {
                RandomMenuView().environmentObject(appData)
            })
            .navigationBarItems(leading: HStack{
                Text("我的私人菜单")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
            },trailing:
                Button(action: {
                    self.showAddMenu.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .renderingMode(.original)
                }.sheet(isPresented: $showAddMenu) {
                    AddMenuView().environmentObject(self.appData)
                }
                .padding()
            )
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environmentObject(AppData(menus: Helper.getMenus()))
    }
}


class AppData: ObservableObject{
    @Published var menus = [MenuModel]()
    
    init(menus: [MenuModel]=[MenuModel]()) {
        self.menus=menus
    }
    //    init() {}
    //
    func updateMenu(menu: MenuModel)  {
        menus=menus.filter({$0.id != menu.id})
        menus.append(menu)
    }
}
