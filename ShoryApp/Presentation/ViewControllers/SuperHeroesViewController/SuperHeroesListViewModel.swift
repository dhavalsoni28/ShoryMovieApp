//
//  SuperHeroesListViewModel.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import Foundation

class SuperHeroesListViewModel {
    let screenTitle = "Super Heros"
    let alertTitle = "Please wait..."
    let cellIdentifier = "SuperHeroesCell"
    let jsonSuperHeroesFileName = "superHeroes"
    let dataLoader = DataLoader()
    var superHeroesList : [SuperHero] = [] {
        didSet {
            self.reloadView?()
        }
    }
    
    var showLoader: Bool = false {
        didSet {
            self.onLoader?(showLoader)
        }
    }
    
    var error: Error? {
        didSet {
            self.onError?(error)
        }
    }
    
    var searchResult: SearchResult? {
        didSet {
            self.onSearchResultLoaded?(searchResult)
        }
    }
    
    var reloadView: (() -> ())?
    var onLoader: ((Bool) -> Void)?
    var onError: ((Error?) -> Void)?
    var onSearchResultLoaded: ((SearchResult?) -> Void)?
    
    func showListOfSuperHeroes() {
        if let url = Bundle.main.url(forResource: self.jsonSuperHeroesFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([SuperHero].self, from: data)
                self.superHeroesList = jsonData
            } catch {
                print("error:\(error)")
                self.error = error
            }
        } else {
            self.error = NSError(domain: "FileNotFound", code: 100, description: "File Not Found. Please try again later.")
        }
    }
    
    func fetchMovies(searchText:String) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = String.omdbURL
        components.queryItems = [
            URLQueryItem(name: String.searchQueryString, value: searchText),
            URLQueryItem(name: String.omdbAPIKeyQueryString, value: String.omdbAPIKey)
        ]
        
        // Getting a URL from our components is as simple as
        // accessing the 'url' property.
        guard let url = components.url else { return }
        self.showLoader = true
        
        dataLoader.loadData(from: url) { result in
            DispatchQueue.main.async {
                self.showLoader = false
                switch result {
                case .success(let data):
                    // Handle the loaded data
                    debugPrint("Data loaded successfully:", String(data: data, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    let jsonData = try? decoder.decode(SearchResult.self, from: data)
                    if let data = jsonData {
                        //Able to parse the data
                        self.searchResult = data
                    } else {
                        self.error = NSError.appDefaultError
                    }
                case .failure(let error):
                    // Handle the error
                    print("Failed to load data:", error)
                    self.error = error
                }
            }
        }
    }
}
