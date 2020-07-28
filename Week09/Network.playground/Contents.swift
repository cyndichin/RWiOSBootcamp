import UIKit

var str = "Hello, playground"


struct Clue: Decodable {
    var id: Int
    var answer: String
    var question: String
    var value: Int?
    var airdate: String
    var createdAt: String
    var updatedAt: String
    var categoryId: Int
    var gameId: Int?
    var invalidCount: Int?
    var category: Category
    
    enum CodingKeys: String, CodingKey {
        case id
        case answer
        case question
        case value
        case airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryId = "category_id"
        case gameId = "game_id"
        case invalidCount = "invalid_count"
        case category
    }
}

struct Category: Decodable {
    var id: Int
    var title: String
    var createdAt: String
    var updatedAt: String
    var numOfClues: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case numOfClues = "clues_count"
    }
}


let defaultSession = URLSession(configuration: .default)
var dataTask: URLSessionDataTask?

enum Endpoints {
    static let base = "https://www.jservice.io/api"
    static let image = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
    
    case random
    case search(String) //associated value
    
    var stringValue: String {
        switch self {
        case .random:
            return Endpoints.base + "/random"
        default:
            return Endpoints.base
            break
            //               case .search(let query): return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            
        }
    }
    
    var url: URL {
        // URLs cannot contain spaces; need percent encodings
        return URL(string: stringValue)!
    }
}

func getRandom(completion: @escaping ([Clue], Error?) -> Void) {
    taskForGETRequest(url: Endpoints.random.url) { (response, error) in
        if let response = response {
            //                Auth.requestToken = response.requestToken
            print(response)
            completion(response, nil)
        } else {
            completion([], nil)
        }
    }
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
            //            let jsonResponse = try JSONSerialization.jsonObject(with:
            //                                         data, options: [])
            //                  print(jsonResponse) //Response result
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

getRandom(completion: handleRequestTokenResponse(success:error:))

func handleRequestTokenResponse(success: [Clue], error: Error?) {
    // accessing UI elements on a completion handler
    if !success.isEmpty {
        let clues = success
        print(clues.first?.question)
    } else {
        print("Fail")
    }
}


import UIKit
let red = UIColor.red
let red2 = UIColor.red

print(red === red2) // proves this is a flyweight

let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
let color2 = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
print(color === color2) // memory address is not the same, proves this is NOT a flyweight

extension UIColor {
    public static var colorStore: [String: UIColor] = [:]
    public class func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) ->
        UIColor {
            let key = "\(red)\(green)\(blue)\(alpha)"
            if let color = colorStore[key] {
                return color
            }
            
            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            colorStore[key] = color
            return color
    }
}

let rgba = UIColor.rgba(1, 0, 0, 1)
let rgba2 = UIColor.rgba(1, 0, 0, 1)
print(rgba === rgba2)
