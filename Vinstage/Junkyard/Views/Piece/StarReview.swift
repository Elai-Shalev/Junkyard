//
//  StarReview.swift
//  Vinstage
//
//  Created by Roee Kleiner on 09/06/2023.
//

import SwiftUI

struct StarReview: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1..<maximumRating + 1) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

struct StarReview_Previews: PreviewProvider {
    static var previews: some View {
        
        StarReview(rating: .constant(4))
    }
}
