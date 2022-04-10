//
//  NetworkService.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 02.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func loginWith(loginData: LoginDTO, completion: @escaping (Result<ConfirmUserDTO, NetworkError>) -> Void)
    func signUpWith(signUpData: SignUpDTO, completion: @escaping (Result<ConfirmUserDTO, NetworkError>) -> Void)
    func getDiscounts(size: Int, completion: @escaping (Result<[DiscountDTO], NetworkError>) -> Void)
    func saveToken(from data: ConfirmUserDTO)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private init() {}
    
    private var token: String?
    
    func loginWith(loginData: LoginDTO, completion: @escaping (Result<ConfirmUserDTO, NetworkError>) -> Void) {
        guard let url = URL(string: URLStorage.login) else { return }
        
        performPostRequest(withUrl: url, isTokenNeeded: false, data: loginData) { result in
            completion(result)
        }
    }
    
    func signUpWith(signUpData: SignUpDTO, completion: @escaping (Result<ConfirmUserDTO, NetworkError>) -> Void) {
        guard let url = URL(string: URLStorage.register) else { return }
        
        performPostRequest(withUrl: url, isTokenNeeded: false, data: signUpData) { result in
            completion(result)
        }
    }
    
    func getDiscounts(size: Int, completion: @escaping (Result<[DiscountDTO], NetworkError>) -> Void) {
        guard let url = URL(string: URLStorage.discounts) else { return }
        
        let pathParameters = [
            URLQueryItem(name: "size", value: String(size))
        ]
        
        performGetRequest(withUrl: url, pathParameter: pathParameters, isTokenNeeded: true) { result in
            completion(result)
        }
    }
    
    private func performPostRequest<RequestModel: Codable, ResponseModel: Codable>(
        withUrl url: URL,
        isTokenNeeded: Bool,
        data: RequestModel,
        completion: @escaping (Result<ResponseModel, NetworkError>) -> Void) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(data)
            
            if isTokenNeeded {
                guard let token = token else {
                    completion(.failure(.unauthorizeError))
                    return
                }
                request.setValue(token, forHTTPHeaderField: "Authorization")
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.noInternetConnectionError))
                    print("Got error in POST method method cause: \(error)")
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.serverError))
                    return
                }
                
                if let safetyData = data, !safetyData.isEmpty {
                    let resultDecoding: Result<ResponseModel, NetworkError> = self.parseJSON(safetyData)
                    completion(resultDecoding)
                }
            }.resume()
            
        }
    
    private func performGetRequest<ResponseModel: Codable>(
        withUrl url: URL,
        pathParameter: [URLQueryItem]? = nil,
        isTokenNeeded: Bool,
        completion: @escaping (Result<ResponseModel, NetworkError>) -> Void) {
            guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            
            urlComponent.queryItems = pathParameter
            
            var request = URLRequest(url: urlComponent.url!)
            
            if isTokenNeeded {
                guard let token = token else {
                    completion(.failure(.unauthorizeError))
                    return
                }
                
                request.setValue(token, forHTTPHeaderField: "Authorization")
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.noInternetConnectionError))
                    print("Got error in GET method method cause: \(error)")
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.serverError))
                    return
                }
                
                if let safetyData = data, !safetyData.isEmpty {
                    let resultDecoding: Result<ResponseModel, NetworkError> = self.parseJSON(safetyData)
                    completion(resultDecoding)
                }
            }.resume()
            
        }
    
    private func parseJSON<T: Codable>(_ data: Data) -> Result<T, NetworkError> {
        var parsedResponse: T
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            parsedResponse = try decoder.decode(T.self, from: data)
        } catch {
            if (try? decoder.decode(ErrorDTO.self, from: data)) != nil {
                return .failure(.incorrectDataError)
            }
            print("Can't parse JSON cause: \(error)")
            return .failure(.serverError)
        }
        
        return .success(parsedResponse)
    }
    
    func saveToken(from data: ConfirmUserDTO) {
        token = data.token
    }
    
}

enum NetworkError: Error {
    case serverError
    case unauthorizeError
    case incorrectDataError
    case noInternetConnectionError
}

extension NetworkError {
    var failure: ServiceError {
        switch self {
        case .serverError:
            return .serverError
        case .unauthorizeError:
            return .unauthorized
        case .incorrectDataError:
            return .incorrectData
        case .noInternetConnectionError:
            return .noInternetConnection
        }
    }
}
