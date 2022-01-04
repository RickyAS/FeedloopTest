//
//  Service.swift
//  Feedloop
//
//  Created by Ricky Austin on 04/01/22.
//

import Foundation

enum DatabaseError : Error{
    case invalidResponse
    case failedToDecode
    case noData
}

class UrlService{
    
    static let shared = UrlService()
    
    private let baseUrl = "https://swapi.dev/api/"
    
    func getPersonList(page: Int, completion: @escaping (Result<[PersonModel],DatabaseError>)->Void){
        var urlBuilder = URLComponents(string: "\(baseUrl)people/?")
        urlBuilder?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")]
        
        let url = urlBuilder?.url!
        let request = URLRequest(url: url!)
        
        URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                      completion(.failure(.noData))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(PageModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.failedToDecode))
            }
        }.resume()
    }
}
