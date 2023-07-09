//
//  MoviewDetailsViewController.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.title = self.viewModel.screenTitle
        let url = URL(string: self.viewModel.movie.poster)
        self.movieImageView.kf.setImage(with: url)
        self.titleLabel.text = self.viewModel.createTitle()
        self.yearLabel.text = self.viewModel.createYear()
        self.typeLabel.text = self.viewModel.createType()
        self.idLabel.text = self.viewModel.createID()
    }
}
