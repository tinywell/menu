//
//  RandomMenuView.swift
//  Menu
//
//  Created by tinywell on 2021/10/03.
//

import SwiftUI

struct RandomMenuView: View {
    @EnvironmentObject var appData:AppData
    @Binding var currentIndex: Int
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
            if isCompleted{
                Text("就是它了!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)
                    .padding()
            }
            ZStack{
                Image(uiImage: appData.menus[currentIndex].image)
                    .resizable()
                    .frame(
                        width: isCompleted ? Helper.MenuCardWidth:Helper.MenuCardMiniWidth,
                        height:isCompleted ? Helper.MenuCardHeight: Helper.MenuCardMiniHeight,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20)
                    .shadow(color:.gray,radius: 20)
               
                HStack{
                    Spacer()
                    Text(appData.menus[currentIndex].name)
                        .padding()
                        .font(.title2)
                        .foregroundColor(Color(white: 0.8))
                        .background(Rectangle().fill(blink ? Color.red:Color.blue).opacity(0.5))
                    Spacer()
                }
            }
            if isCompleted{
                
                Button(action: {
                    isCompleted=false
                    currentIndex=0
                    random()
                }){
                   Image(systemName: "repeat.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }.buttonStyle(BorderlessButtonStyle())
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
        var baseDelay = 0.3
        var seconds = DispatchTime.now()+0.5
        var randomCount = 0
        
        while randomCount < 30{
            let randomIndex = Int.random(in: 0..<appData.menus.count)
            DispatchQueue.main.asyncAfter(deadline: seconds) {
                self.currentIndex=randomIndex
                blink.toggle()
                print("async do,randomIndex:",randomIndex,"time:",DispatchTime.now())
            }
            print("random count:",randomCount,"random:",randomIndex," seconds:",seconds)
            randomCount+=1
            seconds=seconds + baseDelay
            if randomCount == 20{
                baseDelay = 0.5
            }
            if randomCount == 27{
                baseDelay = 0.8
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: seconds+0.5) {
            isCompleted=true
        }
       
            
        
        
    }
}

struct RandomMenuView_Previews: PreviewProvider {
    @State static var currentIndex=0
    static var previews: some View {
        RandomMenuView(currentIndex: $currentIndex).environmentObject(AppData(menus: Helper.getMenus()))
    }
}
