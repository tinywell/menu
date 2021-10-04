//
//  RandomMenuView.swift
//  Menu
//
//  Created by tinywell on 2021/10/03.
//

import SwiftUI

struct RandomMenuView: View {
    @EnvironmentObject var appData:AppData
    @State var currentIndex: Int = 0
    @State var isCompleted=false
    @State var blink=false
    
    var body: some View {
        VStack{
            Spacer()
            if !isCompleted {
                HStack{
                    Text("今天吃什么？")
                        .font(.title)
                        .padding()
                }
            }
            ZStack{
                Image(uiImage: appData.menus[currentIndex].image)
                    .resizable()
                    .frame(
                        width: isCompleted ? Helper.MenuCardWidth:Helper.MenuCardMiniWidth,
                        height:isCompleted ? Helper.MenuCardHeight: Helper.MenuCardMiniHeight,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20)
//                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(blink ? Color.red:Color.blue, lineWidth: isCompleted ? 0:10).shadow(radius: 10))
                    .shadow(color:.gray,radius: 20)
               
                HStack{
                    Spacer()
                    Text(appData.menus[currentIndex].name)
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(white: 0.8))
                        .background(Rectangle().fill(blink ? Color.red:Color.blue).opacity(0.5))
                    Spacer()
                }
            }
            if isCompleted{
                Text("就是它了!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
        }
        .onAppear(perform: {
            random()
        })
        .animation(.easeInOut)
    }
    
    private func random()   {
        isCompleted=false
        var baseDelay = 0.5
        var seconds = 0.5
        var randomCount = 0
        
        while randomCount < 10{
            let randomIndex = Int.random(in: 0..<appData.menus.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.currentIndex=randomIndex
                blink.toggle()
                print("async do,randomIndex:",randomIndex)
            }
            print("random count:",randomCount,"random:",randomIndex," seconds:",seconds)
            randomCount+=1
            seconds=seconds + baseDelay
            if randomCount == 7{
                baseDelay = 0.8
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            isCompleted=true
        }
       
            
        
        
    }
}

struct RandomMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RandomMenuView().environmentObject(AppData(menus: Helper.getMenus()))
    }
}
