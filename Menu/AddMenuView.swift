//
//  AddMenuView.swift
//  Menu
//
//  Created by tinywell on 2021/10/01.
//

import SwiftUI

struct AddMenuView: View {
    @State internal var name:String=""
    @State internal var addr:String=""
    @State internal var detail:String=""
    @State internal var score:Int=0
    
    @State internal var showingImagePicker = false
    @State private var libraryImage: UIImage?
    
    @Binding var menu: MenuModel
    var isNew = true
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack{
            
            
            HStack{
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("取消")
                }.padding()
                Spacer()
                Text(isNew ? "新增菜品":"编辑菜品")
                    .fontWeight(.heavy)
                Spacer()
                Button(action: {
                    self.saveRecipe()
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("保存")
                }.padding()
            }
            Form{
                
                Button(action: {
                    self.showingImagePicker.toggle()
                }) {
                    Image(uiImage: self.libraryImage ?? (UIImage(named: "placeholder-add-image") ?? UIImage()))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.purple, lineWidth: 3).shadow(radius: 10))
                        .frame(maxWidth: .infinity, maxHeight: 230)
                        .padding(6)
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: self.$libraryImage)
                }.buttonStyle(PlainButtonStyle())
                Section(header: Text("菜名")){
                    TextField("输入菜名",text:$name)
                }
                Section(header: Text("地址")){
                    TextField("输入地址",text:$addr)
                }
                Section(header:Text("评分")){
                    RatingStarView(rating:$score,editAble: true)
                }
                
                Section(header: Text("菜品备注")){
                    TextEditor(text: $detail)
                }
                
                
            }
        }
        .onAppear(perform: {
            self.initMenu()
        })
    }
    
    private func initMenu() {
        if !isNew {
            name = menu.name
            libraryImage = menu.image
            addr = menu.addr
            score = menu.score
            detail = menu.detail
        }
    }
    

    
    private func saveRecipe() {
        
        var menuImage = UIImage()
        if let libImage = libraryImage {
            menuImage = libImage
        }
        
        var newMenu = MenuModel(
            name: name,
            addr: addr,
            score: score,
            imageData: menuImage.jpegData(compressionQuality: 0.3) ?? Data(),
            detail: detail
            
        )
        if isNew {
            newMenu.id = UUID()
            appData.menus.append(newMenu)
        }else {
            newMenu.id = menu.id
                appData.updateMenu(menu: newMenu)
                menu=newMenu
        }
        
        // Update Local Saved Data
        Helper.saveMenus(menus:  appData.menus)
        
    }
    
    
}




struct AddMenuView_Previews: PreviewProvider {
    static var appData=AppData()
    static var menu=MenuModel()
    
    static var previews: some View {
        AddMenuView(menu: Binding.constant(menu)).environmentObject(appData)
    }
}
