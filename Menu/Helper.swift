//
//  Helper.swift
//  Menu
//
//  Created by tinywell on 2021/10/01.
//

import Foundation
import UIKit

struct Helper {
    static var MenuCardWidth:CGFloat = 350
    static var MenuCardHeight:CGFloat = 263
    
    static var MenuCardMiniWidth:CGFloat = 333
    static var MenuCardMiniHeight:CGFloat = 250
    
    static func saveMenus(menus: [MenuModel]) {
        let data = try! JSONEncoder().encode(menus)
        UserDefaults.standard.set(data, forKey: "menus")
    }
    

    static func getMenus(filter: String = "") -> [MenuModel] {
        
        if let data = UserDefaults.standard.data(forKey: "menus") {
            let array = try! JSONDecoder().decode([MenuModel].self, from: data)
            return array
        }
        return [MenuModel]()
    }
    
    static func mockMenus() -> [MenuModel] {
        var menus: [MenuModel] = load("menus.json")
        menus.append(contentsOf: getMenus())
        return menus
    }
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
