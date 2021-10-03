//
//  MenuScrollView.swift
//  Menu
//
//  Created by tinywell on 2021/10/02.
//

import SwiftUI

struct MenuScrollView: View {
    @EnvironmentObject var appData:AppData
    @State private var showConfirm=false
    
    /// 拖拽的偏移量
    @State var dragOffset: CGFloat = .zero
    /// 当前显示的位置索引,
    /// 这是实际数据中的1就是数据没有被处理之前的0位置的图片
    /// 所以这里默认从1开始
    @State var currentIndex: Int = 0
    
    @State var isAnimation: Bool = true
    
    let spacing: CGFloat = 10
    let menuWidth:CGFloat = 350
    
    var body: some View {
        let currentOffset = CGFloat(currentIndex) * (menuWidth + spacing)-spacing
        
        GeometryReader(content: { geometry in
            HStack(spacing:spacing){
                ForEach(appData.menus){menu in
                    MenuCardView(menu: menu).environmentObject(appData)
                }
            }.offset(x: dragOffset - currentOffset)
            .gesture(dragGesture)
            .animation(.spring())
            .onChange(of: currentIndex, perform: { value in
                print("onChange currentIndex:",currentIndex)
                //                currentIndex = max(min(currentIndex, appData.menus.count - 1), 0)
            })
            .onChange(of: appData.menus.count, perform: { value in
                print("onChange menus.count:",appData.menus.count)
                currentIndex = max(min(currentIndex, appData.menus.count - 1), 0)
            })
        })
        
    }
}

extension MenuScrollView{
    
    /// 定义拖拽手势
    private var dragGesture: some Gesture{
        
        DragGesture()
            /// 拖动改变
            .onChanged {
                isAnimation = true
                dragOffset = $0.translation.width
            }
            /// 结束
            .onEnded {
                dragOffset = .zero
                /// 拖动右滑，偏移量增加，显示 index 减少
                if $0.translation.width > 50{
                    currentIndex -= 1
                }
                /// 拖动左滑，偏移量减少，显示 index 增加
                if $0.translation.width < -50{
                    currentIndex += 1
                }
                /// 防止越界
                currentIndex = max(min(currentIndex, appData.menus.count - 1), 0)
            }
    }
}

struct TestScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MenuScrollView().environmentObject(AppData(menus: Helper.getMenus()))
    }
}
