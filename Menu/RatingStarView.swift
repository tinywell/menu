//
//  RatingStarView.swift
//  Menu
//
//  Created by tinywell on 2021/10/05.
//

import SwiftUI

struct RatingStarView: View {
    @Binding var rating: Int

    var editAble = false
    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
        ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        if editAble{
                        self.rating = number
                        }
                    }
            }
            Spacer()
            Text(String(rating)+" 分")
        }.padding()
    }
    
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingStarView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarView(rating: .constant(4))
    }
}
