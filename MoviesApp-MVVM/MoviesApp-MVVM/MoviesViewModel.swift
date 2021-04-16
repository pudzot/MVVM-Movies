//
//  MovieViewModel.swift
//  MoviesApp-MVVM
//
//  Created by Damian Piszcz on 15/04/2021.
//

import Foundation


protocol MoviesViewModelDelegate: AnyObject {
    func delegateDidRetriveMovies(_ viewModel: [Movie])
}


protocol MoviesViewModelType  {
    
 
    var delegate: MoviesViewModelDelegate? { get set }
    var movieData: [Movie] { get }

    func getMovieData()

    
}

class MoviesViewModel {
    
 
    
    var delegate: MoviesViewModelDelegate?
    

    private var movieStore : MovieStore
    init(movieStore: MovieStore) {
        self.movieStore = movieStore
    }
    
    private(set) var movieData = [Movie]() 
      
    
  //  var MovieViewModelToController  : (() -> ()) = {}
    
    
    func getMovieData() {
        movieStore.fetchMovies(from: .popular) { (result) in
            switch result {
            case .success(let movies):
                self.movieData = movies.results
                self.delegate?.delegateDidRetriveMovies(self.movieData)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        
    }
}
