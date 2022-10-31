//
//  Networking.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import Foundation

class Networking{
    static var shared = Networking()
    
    func request<T: Decodable>(contentType: ContentType, method: HTTPMethod,path: String, queryItem: [URLQueryItem], data: Data?, completion: @escaping(Result<T, Error>) -> Void){
        var components = URLComponents()
        components.scheme = "https"
        components.host = URLHelper.baseUrl
        components.path = path
        components.queryItems = queryItem
        
        guard let url = components.url else { return }
        print(url.absoluteString)
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(contentType.rawValue, forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        if let data = data{
            request.httpBody = data
        }
        URLSession.shared.dataTask(with: request) { data , response, error in
            if let error = error{
                completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let decoder = JSONDecoder()
                let error = try? decoder.decode(ErrorWrapper.self, from: data ?? Data())
                //TODO: Check if
                completion(.failure(CustomError.init(rawValue: error!.error) ?? CustomError.UnexpectedErrorOccured))
                return
            }
            guard let data = data else{return}
            let decoder = JSONDecoder()
            do{
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func login(username: String, password: String, completion: @escaping((Result<Token, Error>) -> Void)){
        let data : Data = "email=\(username)&password=\(password)".data(using: .utf8)!
        request(contentType: .urlEncoded, method: .post, path: URLHelper.login, queryItem: [], data: data) { (result: Result<Token, Error>) in
            completion(result)
        }
    }
    
    func getUser(completion: @escaping((Result<UserWrapper, Error>) -> Void)){
        request(contentType: .urlEncoded, method: .get, path: URLHelper.getUser, queryItem: [], data: nil) { (result: Result<UserWrapper, Error>) in
            completion(result)
        }
    }
}

enum ContentType: String{
    case urlEncoded = "application/x-www-form-urlencoded"
}

enum HTTPMethod: String{
    case post = "POST"
    case get = "GET"
}
