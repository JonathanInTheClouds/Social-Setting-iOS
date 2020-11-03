//
//  CreatePostViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/26/20.
//

import Foundation
import Combine

class CreatePostViewModel: BaseAuth, ObservableObject {
    
    private var createPostCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        print("Destroyed CreatePostViewModel")
        createPostCancellable?.cancel()
    }
    
    func createPost(postRequest: PostRequestModel, completion: @escaping (PostResponseModel) -> ()) {
        guard let authToken = token else { return }
        guard let postRequestJSON = try? JSONEncoder().encode(postRequest) else { return }
        component.path = "/api/post"
        guard let url = component.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Bearer": authToken, "Accept":"application/json", "Content-Type":"application/json"]
        request.httpBody = postRequestJSON
        
        createPostCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (element) -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 201 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: PostResponseModel.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (response) in
                switch response {
                case .finished:
                    print("Post Sent! 🚀")
                case .failure(_):
                    self.refreshAuthToken {
                        self.createPost(postRequest: postRequest, completion: completion)
                    }
                }
            } receiveValue: { (createdPost) in
                print("Post \(createdPost.id) Created:")
                print(createdPost)
                completion(createdPost)
            }

    }
    
}
