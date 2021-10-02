//
//  TestScrollView.swift
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
            //        ScrollView(.horizontal, showsIndicators: false, content: {
            
            HStack(spacing:spacing){
                ForEach(appData.menus){menu in
                    //                ForEach(0..<appData.menus.count){_ in
                    HStack{
                        MenuCardView(menu: menu)
                            //                        MenuCardView(menu: appData.menus[$0])
                            .onLongPressGesture {
                                self.showConfirm=true
                            }
                            .alert(isPresented: $showConfirm) {
                                Alert(
                                    title: Text("此操作不可撤回"),
                                    message: Text("确定删除这个项目吗？"),
                                    primaryButton: .default(
                                        Text("取消"),
                                        action: {print("取消")}
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
                    .offset(x: dragOffset - currentOffset)
                    .gesture(dragGesture)
//                    .animation(isAnimation ?.spring():.none)
                    .animation(.spring())
                    //                    .onChange(of: currentIndex, perform: { value in
                    //                        isAnimation = true
                    //                        /// 第一张的时候
                    //                        if value == 0 {
                    //                            isAnimation.toggle()
                    //                            currentIndex = appData.menus.count - 2
                    //                            /// 最后一张的时候currentIndex设置为1关闭动画
                    //                        }else if value == appData.menus.count - 1 {
                    //
                    //                            isAnimation.toggle()
                    //                            currentIndex = 1
                    //                        }
                    //                    })
                }
            }
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
