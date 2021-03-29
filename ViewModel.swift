//
//  ViewModel.swift
//  Movies_TuaiqCamp
//
//  Created by Abdullah Alnutayfi on 11/03/2021.
//
import SwiftUI
import Foundation

class MovieViewModel : ObservableObject{
    @Published var m_array : [Movie] = [Movie(id: UUID().uuidString, movieName: "A Beautiful Mind", category: "Biography, Drama", rank: "8.2", image: "A Beautiful Mind", image2: nil),
                                        Movie(id: UUID().uuidString, movieName: "Finding Nemo", category: "Animation, Adventure, Comedy", rank: "5.1", image: "Finding Nemo",image2: nil),
                                        Movie(id: UUID().uuidString, movieName: "When a Stranger Calls", category: "Horror, Thriller", rank: "8.1", image: "When a Stranger Calls",image2: nil),
                                        Movie(id: UUID().uuidString, movieName: "the pursuit of happyness", category: "Biography, Drama", rank: "8", image: "the pursuit of happyness",image2: nil),
                                        Movie(id: UUID().uuidString, movieName: "Inside Out", category: "Animation, Adventure, Comedy", rank: "8.2", image: "Inside Out",image2: nil),
                                        Movie(id: UUID().uuidString, movieName: "Inception", category: "Drama, Action, Adventure", rank: "9", image: "Inception",image2: nil)]
    
}

struct Movie : Identifiable{
    var id  = UUID().uuidString
    var movieName = ""
    var category = ""
    var rank : String
    var image : String?
    var image2 : UIImage?
}
