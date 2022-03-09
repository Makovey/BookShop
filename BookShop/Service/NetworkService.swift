//
//  NetworkService.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 02.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func authenticateWith(loginData: LoginDTO, completion:@escaping((ConfirmUserDTO?) -> Void))
    func registerWith(signUpData: SignUpDTO, competion:@escaping((ConfirmUserDTO?)) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    
    var token: String?
    
    func authenticateWith(loginData: LoginDTO, completion:@escaping((ConfirmUserDTO?) -> Void)) {
        performPostRequest(withUrl: URL(string: URLStorage.login)!, data: loginData) { (response: ConfirmUserDTO?) in
            completion(response)
        }
    }
    
    func registerWith(signUpData: SignUpDTO, competion: @escaping ((ConfirmUserDTO?)) -> Void) {
        performPostRequest(withUrl: URL(string: URLStorage.register)!, data: signUpData) { (response: ConfirmUserDTO?) in
            competion(response)
        }
    }
    
    private func performPostRequest<RequestModel: Codable, ResponseModel: Codable>(
        withUrl url: URL,
        data: RequestModel,
        completion:@escaping((ResponseModel?) -> Void)) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(data)
            
            if let token = token {
                request.setValue(token, forHTTPHeaderField: "Authorization")
            }
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(nil)
                    print("Got error in POST method method cause: \(error)")
                    return
                }
                
                if let safetyData = data {
                    if !safetyData.isEmpty {
                        let paresedData: ResponseModel? = parseJSON(safetyData)
                        completion(paresedData)
                        return
                    }
                    
                    completion(nil)
                    return
                }
                
            }.resume()
        }
    
    private func parseJSON<T: Codable>(_ data: Data) -> T? {
        var parsedResponse: T?
        
        let decoder = JSONDecoder()
        do {
            parsedResponse = try decoder.decode(T.self, from: data)
        } catch {
            print("Can't parse JSON cause: \(error)")
        }
        
        return parsedResponse
    }
}
