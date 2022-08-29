//
//  ApiClient.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 25.08.22.
//

import Foundation
import Moya

class ApiClient {
    let provider = MoyaProvider<Api>()
    
    func request<Output: Decodable>(_ target: Api, output: Output.Type, completion: @escaping ((Result<Output, RequestError>) -> Void)) {
        provider.request(target) { result in
            let decoder = ApiClient.decoder
            switch result {
            case let .success(response):
                do {
                    if 200 ..< 300 ~= response.statusCode {
                        let data = try response.map(Output.self, using: decoder)
                        completion(.success(data))
                    } else {
                        completion(.failure(.serializationError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
                
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
    }
}

extension ApiClient {
    // MARK: - Encoder and Decoder
    
    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
