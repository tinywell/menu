//
//  MenuModel.swift
//  Menu
//
//  Created by tinywell on 2021/10/01.
//

import UIKit


struct MenuModel:Hashable,Codable,Identifiable {
    var id=UUID()
    var name  :String = ""
    var addr  :String = ""
    var score :Int  = 0
    var imageData :Data?
    var detail: String
    var imageName : String=""
    
    var image: UIImage{
        if let dataImage=UIImage(data: imageData ?? Data()){
            return dataImage
        }else if let dataImage=UIImage(systemName: self.imageName){
            return dataImage
        }
        return UIImage()
    }
    
}
