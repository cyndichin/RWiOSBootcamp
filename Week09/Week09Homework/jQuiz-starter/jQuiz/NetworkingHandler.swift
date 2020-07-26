//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {
    
    static let sharedInstance = Networking()
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    enum Endpoints {
        static let base = "http://www.jservice.io/api"
        static let homeImage = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
           
        case random
        case cluesCategory(Clue)
        case image
        
        var stringValue: String {
            switch self {
            case .random:
                return Endpoints.base + "/random"
            case .cluesCategory(let clue):
                return Endpoints.base + "/clues?category=\(clue.categoryId)&offset=\(clue.category.numOfClues - 4)"
            case .image:
                return Endpoints.homeImage
            }
        }
        
        var url: URL {
            // URLs cannot contain spaces; need percent encodings
            return URL(string: stringValue)!
        }
    }
    
    func getRandomCategory(completion: @escaping (Clue?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.random.url) { (response, error) in
            if let clue = response?.first {
                print(clue)
                completion(clue, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func getAllCluesInCategory(clue: Clue, completion: @escaping ([Clue], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.cluesCategory(clue).url) { (response, error) in
            print(Endpoints.cluesCategory(clue).url)
            if let response = response {
                completion(response, nil)
            } else {
                completion([], nil)
            }
        }
    }
    
    func downloadImage(completion: @escaping (Data?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.image.url) { (data, response, error) in
             DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    
    
    func taskForGETRequest(url: URL, completion: @escaping([Clue]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            print(data)
            do {
                let responseObject = try decoder.decode([Clue].self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    
//    func getRandomCategory() {
//        // 1
//        dataTask?.cancel()
//
//        // 2
//        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//            urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
//            // 3
//            guard let url = urlComponents.url else {
//                return
//            }
//            // 4
//            dataTask =
//                defaultSession.dataTask(with: url) { [weak self] data, response, error in
//                    defer {
//                        self?.dataTask = nil
//                    }
//                    // 5
//                    if let error = error {
//                        self?.errorMessage += "DataTask error: " +
//                            error.localizedDescription + "\n"
//                    } else if
//                        let data = data,
//                        let response = response as? HTTPURLResponse,
//                        response.statusCode == 200 {
//                        self?.updateSearchResults(data)
//                        // 6
//                        DispatchQueue.main.async {
//                            completion(self?.tracks, self?.errorMessage ?? "")
//                        }
//                    }
//            }
//            // 7
//            dataTask?.resume()
//        }
//    }
//
    
}
