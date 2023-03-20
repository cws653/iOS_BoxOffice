//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

final class MovieListTableViewModel {
    
    private var movieList: [Movies]?
    private var imageData: [Data] = []
    
    func getMovieList(movieMode: MovieSortMode, completion:@escaping () -> Void) {
        MovieServiceProvider.shared.getMovieList(movieSortMode: movieMode) { movies in
            DispatchQueue.main.async {
                self.movieList = movies
                self.getImageDatas(from: movies) {
                    completion()
                }
            }
        }
    }
    
    func getImageDatas(from movies: [Movies], completion:@escaping () -> Void) {
        movies.forEach { movie in
            guard let imageURL = URL(string: movie.thumb) else {
                return
            }
            
            MovieServiceProvider.shared.getMovieImageData(url: imageURL) { data in
                self.imageData.append(data)
            }
        }
        completion()
    }
}
