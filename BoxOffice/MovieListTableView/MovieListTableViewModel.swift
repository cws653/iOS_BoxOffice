//
//  MovieListTableViewModel.swift
//  BoxOffice
//
//  Created by 최원석 on 2023/03/19.
//  Copyright © 2023 최원석. All rights reserved.
//

import Foundation

final class MovieListTableViewModel {
    
    private(set) var movieList: [Movies]?
    private(set) var imageData: [Data] = []
    
    let dispatchGroup = DispatchGroup()
}

extension MovieListTableViewModel {
    func getMovieList(movieMode: MovieSortMode, completion:@escaping () -> Void) {
        dispatchGroup.enter()
        MovieServiceProvider.shared.getMovieList(movieSortMode: movieMode) { [weak self] movies in
            guard let self = self else { return }
            self.movieList = movies
            self.getImageDatas(from: movies) {
                self.dispatchGroup.leave()
                completion()
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
