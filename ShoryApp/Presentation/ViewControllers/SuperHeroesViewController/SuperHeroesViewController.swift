//
//  SuperHeroesViewController.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import UIKit
@MainActor
class SuperHeroesViewController: UIViewController {

    private lazy var tableView = self.makeTableView()

    var viewModel: SuperHeroesListViewModel = SuperHeroesListViewModel()
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
        self.setUpViewModelBindings()
        self.viewModel.showListOfSuperHeroes()
    }

    //MARK: View Setup Methods
    
    private func setUpUI() {
        self.title = self.viewModel.screenTitle
        navigationItem.largeTitleDisplayMode = .always
        self.setUpConstraints()
    }
    
    private func setUpViewModelBindings() {
        self.viewModel.onError = { [weak self] (error) in
            self?.showError(error ?? NSError.appDefaultError)
        }
        
        self.viewModel.onLoader = { [weak self] (show) in
            if show {
                self?.showLoader()
            } else {
                self?.dismissLoader()
            }
        }
        
        self.viewModel.onSearchResultLoaded = { [weak self] (searchResult) in
            //Added delay as navigation was not happening due to alert view dismissing taking time.
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self?.navigateToMovieDetails()
            }
        }
    }

    
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.viewModel.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func setUpConstraints() {
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    private func showLoader() {
        let alert = UIAlertController(title: nil, message: self.viewModel.alertTitle, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    private func dismissLoader() {
        dismiss(animated: true, completion: nil)
    }
    
    private func navigateToMovieDetails() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let movie = self.viewModel.searchResult?.search.randomElement(), let viewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        
        let viewModel = MovieDetailsViewModel(movie: movie)
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: TableView Delegate and DataSource Methods

extension SuperHeroesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.superHeroesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifier, for: indexPath)
        let superHero = self.viewModel.superHeroesList[indexPath.row]
        cell.imageView?.image = UIImage(named: superHero.imageName)
        cell.textLabel?.text = superHero.name
        return cell
    }
}

extension SuperHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Fetch random movie based on selection
        let superHero = self.viewModel.superHeroesList[indexPath.row]
        self.viewModel.fetchMovies(searchText: superHero.searchText)
    }
}

