//
//  ViewController.swift
//  MoviesApp-MVVM
//
//  Created by Damian Piszcz on 15/04/2021.
//

import UIKit

final class ViewController: UIViewController {
    
  
    
    var viewModel : MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getMovieData()
        
    }


}


extension ViewController: MoviesViewModelDelegate {
    func delegateDidRetriveMovies(_ viewModel: [Movie]) {
        print(viewModel[0])
    }
    
    
    
}

