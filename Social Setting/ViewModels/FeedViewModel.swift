//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation
import SwiftKeychainWrapper

class FeedViewModel: BaseAuth, ObservableObject {
    
    @Published var postFeed:[PostResponseModel] = [PostResponseModel]()
    
    private var currentPage: Int = 1
    
    override init() {
        super.init()
        fetchFeed()
    }
    
    func fetchFeed() {
        guard let authToken = token else { return }
        guard let url = URL(string: "http://localhost:8086/api/post/feed?page=\(currentPage)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let headers = [
            "Bearer": authToken
        ]
        
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                print("error", error ?? "Unknown error")
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("Response = \(response)")
                return
            }
            
            guard let posts = try? self.decoder.decode([PostResponseModel].self, from: data) else { return }
            
            DispatchQueue.main.async {
                if !posts.isEmpty {
                    self.postFeed.append(contentsOf: posts)
                    self.currentPage += 1
                }
            }
            
        }
        
        task.resume()
        
    }
    
}
