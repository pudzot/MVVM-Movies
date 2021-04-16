//
//  MovieStore.swift
//  MoviesApp-MVVM
//
//  Created by Damian Piszcz on 15/04/2021.
//

import Foundation



public class MovieStore: MovieService {
    
    
    func fetchMovies(from endpoint: Endpoint, completion: @escaping (Result<MoviesResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLandDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLandDecode(url: url, params: [
                                "append_to_response": "videos,credits"],
                              completion: completion)
    }
    
    
    
    public static let shared = MovieStore()
    init() {}
    private let apiKey = "1da9cbad4bfc574c3ecc17edf43251ab"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    
   private func loadURLandDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) ->()) {
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
        return
    }
    
    var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    if let params = params {
        queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
    }
    
    urlComponents.queryItems = queryItems
    
    guard let finalUrl = urlComponents.url else {
        completion(.failure(.invalidEndpoint))
        return
    }
    
    urlSession.dataTask(with: finalUrl) { (data, response, error) in
        if error != nil {
            self.executeCompletionHandler(with: .failure(.apiError), completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode  else {
            self.executeCompletionHandler(with: .failure(.invalidResponse), completion: completion)
            return
        }
        
        guard let data = data else {
            self.executeCompletionHandler(with: .failure(.noData), completion: completion)
            return
        }
        
        do {
            let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
            DispatchQueue.main.async {
            self.executeCompletionHandler(with: .success(decodedResponse), completion: completion)
            }
          
        } catch {
            self.executeCompletionHandler(with: .failure(.serializationError), completion: completion)
        }
    }.resume()
   }
    
    
    private func executeCompletionHandler<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
