//
//  APICaller.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsdata.io/api/1/news?apikey=pub_164868df3c7b76f7acb2dd212ab65fbc9814c&q=news&country=ru")
        static let searchUrlString = "https://newsdata.io/api/1/news?apikey=pub_164868df3c7b76f7acb2dd212ab65fbc9814c&q="
    }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.results.count )")
                    completion(.success(result.results))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                
        let urltring = Constants.searchUrlString + query
        guard let url = URL(string: urltring) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.results.count )")
                    completion(.success(result.results))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
