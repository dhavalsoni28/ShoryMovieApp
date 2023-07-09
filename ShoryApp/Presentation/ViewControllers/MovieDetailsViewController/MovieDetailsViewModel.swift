//
//  MovieDetailsViewModel.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import Foundation

class MovieDetailsViewModel {
    let screenTitle = "Movie Details"
    var movie: Search
    
    init(movie: Search) {
        self.movie = movie
    }
    
    func createTitle() -> String {
        return "Title: \(self.movie.title)"
    }
    
    func createYear() -> String {
        return "Year: \(self.movie.year)"
    }
    
    func createType() -> String {
        return "Type: \(self.movie.type.rawValue.capitalized)"
    }
    
    func createID() -> String {
        return "ID: \(self.movie.imdbID)"
    }
}
