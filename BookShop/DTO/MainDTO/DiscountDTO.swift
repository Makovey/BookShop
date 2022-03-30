//
//  DiscountDTO.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 27.03.2022.
//

struct DiscountDTO: Codable {
    let name: String
    let description: String
    let oldPrice: String
    let newPrice: String
    let image: String
}
