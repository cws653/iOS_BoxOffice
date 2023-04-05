//
//  Function.swift
//  BoxOffice
//
//  Created by 최원석 on 2020/09/04.
//  Copyright © 2020 최원석. All rights reserved.
//

import Foundation

class MovieServiceProvider {

    static let shared = MovieServiceProvider()
    
    private var baseURL: String {
        return "http://connect-boxoffice.run.goorm.io/"
    }
    
    func requestMovieList(movieSortMode: MovieSortMode,  completion:@escaping ([Movies]) -> Void) {
        let baseWithFilterTypeURL = baseURL + "movies?order_type=" + "\(movieSortMode.rawValue)"
        guard let url = URL(string: baseWithFilterTypeURL) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(datas, response, error) in
            if error != nil {
                print("Network Error")
            }
            guard let data = datas else {return}
            
            do {
                let order = try JSONDecoder().decode(MovieList.self, from: data)
                completion(order.movies)
            } catch {
                print("JSON Parising Error")
            }
        }
        dataTask.resume()
    }
    
    func requestMovieDetails(movieId: String, completion:@escaping ([DetailContents]) -> Void) {
        let baseWithFilterTypeURL = baseURL+"movie?id="+"\(movieId)"
        guard let url = URL(string: baseWithFilterTypeURL) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(datas, response, error) in
            if error != nil {
                print("Network Error")
            }
            guard let data = datas else {return}
            
            do {
                let order = try JSONDecoder().decode(DetailContents.self, from: data)
                completion([order])
            } catch {
                print("JSON Parising Error")
            }
        }
        dataTask.resume()
    }
    
    
    func requestCommentList(movieId: String, completion:@escaping (CommentList?) -> Void) {
        let baseWithFilterTypeURL = baseURL+"comments?movie_id="+"\(movieId)"
        
        guard let url = URL(string: baseWithFilterTypeURL) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(datas, response, error) in
            if error != nil {
                print("Network Error")
            }
            guard let data = datas else {return}
            do {
                let order = try JSONDecoder().decode(CommentList.self, from: data)
                
                completion(order)
            } catch {
                print("JSON Parising Error")
            }
        }
        dataTask.resume()
    }

    func postComment(postComment: PostComment, completion:@escaping () -> Void) {
        do {
            let newPostData = try JSONEncoder().encode(postComment)

            let baseWithFilterTypeURL = baseURL+"comment"
            guard let url = URL(string: baseWithFilterTypeURL) else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = newPostData

            let dataTask: URLSessionTask = URLSession.shared.dataTask(with: request) {(datas, response, error) in
                if error != nil {
                    print("Network Error")
                }
                do {
                    if let data = datas {
                        let parsed = try JSONDecoder().decode(Comment.self, from: data)
                        print("parsed \(parsed)")
                        completion()
                    }
                } catch {
                    print("Error")
                }
            }
            dataTask.resume()
        } catch {
            print("Encode data nil")
        }
    }
    
    func getMovieImageData(url: URL, completion:@escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            completion(data)
        }.resume()
    }
}
