# ShoryMovieApp
Movie App used for viewing randomly selected movies based on your super heroes. 

# Content
* [How to build the application](#how-to-build-application)
* [Documentation](#documentation)

## How to build application
1. Download or clone the current repository using the command `git clone https://github.com/dhavalsoni28/ShoryMovieApp.git`.
2. Go to the project folder.
3. Open the project in Xcode.
4. Run the project.
Note: Project uses Swift package manager for 3rd party dependency. 

## Documentation
1. Movie App can be suggest movies based on your super hero selection from a list of movies from IMDB movie database. Select your super hero and be surprised with the suggestions shown by the app. Currently application is allowing selection of limited super heroes which can be expanded by adding items in superHeroes.json file of the project. 
2. App contains 2 screens which as listing of Super heroes and Movie details screen based on super hero selection. 
3. App is following Clean Architecture with native MVVM. Folder structure is as per presentation, data and domain layers. 
4. Structure of the Presentation layer is ViewController and it's associated ViewModel. 
5. ViewModels are handling view related callbacks using closures.
6. Contants.swift is used for maintaining all constants of the app. 
7. App is using Kingfisher library for image caching and the same is added using Swift package manager. 


