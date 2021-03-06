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
    @Binding var currentIndex: Int
    
    public let width:CGFloat=350
    public let height:CGFloat=263
    
    @State private var showConfirm=false
    @State private var showAction=false
    @State private var showDetail=false
    @State private var showEdit=false
    
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    Image(uiImage: menu.image)
                        .resizable()
                    
                }
                VStack{
                    Spacer()
                    HStack{
                        VStack{
                            HStack{
                                Text(menu.name)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack{
                                Text(menu.addr)
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding()
                        Spacer()
                    }.background(Rectangle().opacity(0.5))
                }
            }.frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            if showDetail {
                HStack{
                    RatingStarView(rating: $menu.score)
                    Spacer()
                }
                HStack{
                    Text(menu.detail)
                        .padding()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button("??????",action:{self.showEdit=true})
                        .padding()
                        .font(.footnote)
                }
                
            }
            
        }.frame(width:width)
        //        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .background(Color(white: 0.99))
        .cornerRadius(15)
        .shadow(color: .gray,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .onTapGesture {
            self.showDetail.toggle()
        }
        .animation(.easeInOut)
        .onLongPressGesture {
            //            self.showConfirm=true
            self.showConfirm = true
        }
        .onChange(of: currentIndex, perform: { value in
//            print("currentIndex change: ",currentIndex)
            self.showDetail=false
        })
        .sheet(isPresented: $showEdit){
            AddMenuView(menu:$menu,isNew:false).environmentObject(self.appData)
//            MenuDetailView(menu: menu)
        }
        .actionSheet(isPresented: $showAction) {
            ActionSheet(title: Text("????????????"),
                        message: Text("????????????????????????"),
                        buttons: [
                            .cancel(),
                            .destructive(Text("????????????"),action: {self.showConfirm=true}),
                            .default(Text("????????????"),action: {})
                        ]
            )
        }
        .alert(isPresented: $showConfirm) {
            Alert(
                title: Text("??????"),
                message: Text("?????????????????????,??????????????????????????????"),
                primaryButton: .default(
                    Text("??????"),
                    action: {print("??????",menu.id,menu.name)}
                ),
                secondaryButton: .destructive(
                    Text("??????"),
                    action: {
                        print("??????")
                        self.appData.menus.removeAll { $0 == menu }
                        Helper.saveMenus(menus: self.appData.menus)
                    }
                )
            )
        }
    }
}

struct MenuCardView_Previews: PreviewProvider {
    @State static var currentIndex = 0
    static var previews: some View {
        MenuCardView(menu:Helper.getMenus()[0],currentIndex:$currentIndex)
    }
}
