//
//  MovieService.swift
//  MoviesApp-MVVM
//
//  Created by Damian Piszcz on 15/04/2021.
//

import Foundation


protocol MovieService {
     
    //func fetchMovies(from endpoint: Endpoint, params: [String: String]?, successHandler: @escaping (_ response: MoviesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    
    func fetchMovies(from endpoint: Endpoint, completion: @escaping (Result<MoviesResponse, MovieError>) ->())
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) ->())
    
}

public enum Endpoint: String, CodingKey {
    case popular
    case upcoming
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
}


public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid Response "
        case .noData: return "No data"
        case .serializationError: return "Failed to decode"
        }
    }
}
