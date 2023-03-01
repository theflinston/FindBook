//
//  SearchServiceImpl.swift
//  FindBook
//
//  Created by Tiago Santos on 27/02/2023.
//

import Foundation

final class SearchServiceImpl: SearchService {
    
    struct BookSearchResult: Decodable {
        let docs: [BookInfo]
    }
    
    private let searchPath = "search.json"
    
    private var urlSessionDataTask: URLSessionDataTask?
    
    private let restConfig: RestApiConfig
    init(restConfig: RestApiConfig) {
        self.restConfig = restConfig
    }
    
    func search(with searchValue: String, completionHandler: @escaping (Result<[BookInfo], Error>) -> Void) {
        
        urlSessionDataTask?.cancel()
        
        let search = searchValue.replacingOccurrences(of: " ", with: "+")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let search,
              let url = URL(string: "\(restConfig.host)/\(searchPath)?q=\(search)") else {
            assertionFailure("host does not present a valid url!")
            return
        }
        
        let request = URLRequest(url: url)
        
        urlSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error as? URLError {
                if error.code != .cancelled {
                    completionHandler(.failure(error))
                }
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode ,
               statusCode == 200,
               let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let searchResult = try decoder.decode(BookSearchResult.self, from: data)
                    
                    completionHandler(.success(searchResult.docs))
                } catch (let error) {
                    completionHandler(.failure(error))
                }
            }
            
        }
        urlSessionDataTask?.resume()
    }
    
    func cancel() {
        urlSessionDataTask?.cancel()
        urlSessionDataTask = nil
    }
    
}

