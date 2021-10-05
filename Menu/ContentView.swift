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
    @State var currentIndex = 0
    
    var body: some View {
        
        NavigationView{
            VStack{
                MenuScrollView(currentIndex: $currentIndex).environmentObject(appData)
                
                Button(action: {
                    showRandom=true
                }){
                    Image(systemName: "circle.circle")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
//                .offset(y:-100)
            }
            .sheet(isPresented: $showRandom, content: {
                RandomMenuView(currentIndex: $currentIndex).environmentObject(appData)
            })
            .navigationTitle("")
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
