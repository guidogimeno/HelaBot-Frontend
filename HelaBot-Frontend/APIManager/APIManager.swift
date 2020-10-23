//
//  APIManager.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 21/10/2020.
//

import Foundation

class APIManager {
    
    static let sharedInstance = APIManager()
    
    let baseURL = "http://192.168.0.16:8090"
    //let baseURL = "http://192.168.1.24:8090"
    
    func get<T: Decodable> (endPoint: String, completion: @escaping (Result<T, HttpError>) -> Void) {
        createAndSendRequest(endPoint: endPoint, method: "GET") { (result: Result<T, HttpError>) in
            completion(result)
        }
    }
    
    func post<T: Encodable, U: Decodable> (endPoint: String, object: T, completion: @escaping (Result<U, HttpError>) -> Void) {
        createAndSendRequest(endPoint: endPoint, method: "POST", object: object) { (result: Result<U, HttpError>) in
            completion(result)
        }
    }
    
    func delete<T: Encodable, U: Decodable> (endPoint: String, object: T, completion: @escaping (Result<U, HttpError>) -> Void) {
        createAndSendRequest(endPoint: endPoint, method: "DELETE", object: object) { (result: Result<U, HttpError>) in
            completion(result)
        }
    }
    
    private func createAndSendRequest<T: Encodable, U: Decodable> (endPoint: String, method: String, object: T, completion: @escaping (Result<U, HttpError>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(object) else {
            print("Failed to encode object")
            return
        }
        
        createAndSendRequest(endPoint: endPoint, method: method, body: encoded) { (result: Result<U, HttpError>) in
            completion(result)
        }
    }
    
    private func createAndSendRequest<T: Decodable> (endPoint: String, method: String, body: Data? = nil, completion: @escaping (Result<T, HttpError>) -> Void) {
        let request = createRequest(endPoint: endPoint, method: method, body: body)

        sendRequest(request) { (result: Result<T, HttpError>) in
            completion(result)
        }
    }
    
    private func createRequest(endPoint: String, method: String, body: Data? = nil) -> URLRequest {
        guard let url = URL(string: baseURL + endPoint) else {
            fatalError()
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = body
        
        return request
    }
    
    private func sendRequest<T: Decodable> (_ request: URLRequest, completion: @escaping (Result<T, HttpError>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                         
            if let error = error {
                completion(.failure(HttpError.communicationFailed(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(HttpError.emptyData))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(HttpError.statusCode(httpResponse.statusCode)))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch {
                completion(.failure(HttpError.failedParsingJson))
            }
        }.resume()
    }
    
}
