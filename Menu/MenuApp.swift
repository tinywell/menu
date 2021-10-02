//
//  MenuApp.swift
//  Menu
//
//  Created by tinywell on 2021/10/01.
//

import SwiftUI

@main
struct MenuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppData(menus: Helper.getMenus()))
        }
    }
}
