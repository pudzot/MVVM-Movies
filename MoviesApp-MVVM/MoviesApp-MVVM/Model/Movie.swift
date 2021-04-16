//
//  Movie.swift
//  MoviesApp-MVVM
//
//  Created by Damian Piszcz on 15/04/2021.
//

import Foundation


public struct MoviesResponse: Codable {
    public let page: Int?
    public let totalResults: Int?
    public let totalPages: Int?
    public var results: [Movie]
    
}


public struct Movie: Codable, Identifiable  {
    
    public var id: Int
    public var title: String
    public var backdropPath: String?
    public var posterPath: String
    public var overview: String
    public var releaseDate: Date?
    public var voteAverage: Double
    public var voteCount: Int
    public var tagline: String?
    
//    public init(result: [String: Any]) {
//        self.id = result["id"] as! Int
//        self.title = result["title"] as! String
//        self.backdropPath = result["backdropPath"] as! String
//        self.posterPath = result["posterPath"] as! String
//    }
     
  
    
}
