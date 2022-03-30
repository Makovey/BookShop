//
//  DiscountView.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 29.03.2022.
//

import Foundation
import UIKit

class DiscountView: UIView {
    
    let data: DiscountDTO
    
    init(discountData: DiscountDTO) {
        self.data = discountData
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var discountView: UIView = {
        let discountView = UIView()
        discountView.backgroundColor = .systemBackground
        
        discountView.layer.cornerRadius = 20
        
        discountView.layer.shadowOffset = .zero
        discountView.layer.shadowOpacity = 2
        discountView.layer.shadowRadius = 4
        discountView.layer.shadowColor = UIColor.label.cgColor
        
        discountView.translatesAutoresizingMaskIntoConstraints = false
        return discountView
    }()
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.image = converBase64ToImage(base64String: data.image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func assemblyAndEdgeTo(_ container: UIView) {
        container.addSubview(discountView)
        
        NSLayoutConstraint.activate([
            discountView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            discountView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            discountView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            discountView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        
        configreImage()
        configureContentText()
    }
    
    func configreImage() {
        discountView.addSubview(bookImage)
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: discountView.topAnchor, constant: 20),
            bookImage.leadingAnchor.constraint(equalTo: discountView.leadingAnchor, constant: 20),
            bookImage.bottomAnchor.constraint(equalTo: discountView.bottomAnchor, constant: -20),
            bookImage.widthAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    func configureContentText() {
        let title = Label(withText: data.name, fontSize: Constant.Discount.biggestFontSize)
        let description = Label(withText: data.description, fontSize: Constant.Discount.middleFontSize)
        
        title.numberOfLines = 2
        description.numberOfLines = 2
        description.textColor = .systemGray
        
        let oldPrice = Label(fontSize: Constant.Discount.smallestFontSize)
        oldPrice.attributedText = data.oldPrice.strikeThrough()
        oldPrice.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let newPrice = Label(withText: data.newPrice, fontSize: Constant.Discount.middleFontSize)
        newPrice.textColor = .systemRed
        
        let priceStack = UIStackView(arrangedSubviews: [oldPrice, newPrice])
        priceStack.axis = .horizontal
        
        let textStack = UIStackView(arrangedSubviews: [title, description, priceStack])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.distribution = .fillEqually
        
        discountView.addSubview(textStack)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: discountView.topAnchor, constant: 15),
            textStack.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 15),
            textStack.bottomAnchor.constraint(equalTo: discountView.bottomAnchor, constant: -15),
            textStack.trailingAnchor.constraint(equalTo: discountView.trailingAnchor, constant: -5)
        ])
    }
    
    func converBase64ToImage(base64String: String) -> UIImage {
        guard let imageData = Data(base64Encoded: base64String) else { return UIImage() }
        let image = UIImage(data: imageData)
        return image!
    }
}
