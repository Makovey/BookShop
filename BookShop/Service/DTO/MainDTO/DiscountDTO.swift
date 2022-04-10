//
//  DiscountDTO.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 27.03.2022.
//

import Foundation

struct DiscountDTO: Codable {
    let name: String
    let description: String
    let oldPrice: String
    let newPrice: String
    let image: String
}

extension DiscountDTO {
    func decodeImageToData(completion: @escaping (Data?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let data = Data(base64Encoded: image)
            completion(data)
        }
    }
}
