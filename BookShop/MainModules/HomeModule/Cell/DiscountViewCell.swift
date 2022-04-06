//
//  DiscountView.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 29.03.2022.
//

import Foundation
import UIKit

class DiscountViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configreImage()
        configureTextContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: Label = {
        let title = Label(fontSize: Constant.Discount.biggestFontSize)
        title.numberOfLines = 2
        
        return title
    }()
    
    lazy var descriptionOfBook: Label = {
        let description = Label(fontSize: Constant.Discount.middleFontSize)
        description.numberOfLines = 2
        description.textColor = .systemGray
        
        return description
    }()
    
    lazy var oldPrice: Label = {
        let oldPrice = Label(fontSize: Constant.Discount.smallestFontSize)
        
        return oldPrice
    }()
    
    lazy var newPrice: Label = {
        let newPrice = Label(fontSize: Constant.Discount.smallestFontSize)
        newPrice.textColor = .systemRed
        
        return newPrice
    }()
    
    lazy var toCartButton: Button = {
        let button = Button(title: "To cart".localized(), fontSize: Constant.smallestFontSize)
        button.backgroundColor = .label
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(toCartButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private func configreImage() {
        self.addSubview(bookImage)
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.Discount.sideDistance),
            bookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.Discount.sideDistance),
            bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.Discount.sideDistance),
            bookImage.widthAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    private func configureTextContent() {
        let priceStack = UIStackView(arrangedSubviews: [oldPrice, newPrice, toCartButton])
        priceStack.axis = .horizontal
        priceStack.distribution = .fillProportionally
        
        let contentStack = UIStackView(arrangedSubviews: [title, descriptionOfBook, priceStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fillProportionally
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.Discount.sideDistance),
            contentStack.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: Constant.Discount.sideDistance),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.Discount.sideDistance),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.Discount.sideDistance)
        ])
    }
    
    @objc private func toCartButtonTapped() {
        if toCartButton.backgroundColor == .label {
            toCartButton.backgroundColor = .systemGreen
            toCartButton.setTitle("In cart".localized(), for: .normal)
        } else {
            toCartButton.backgroundColor = .label
            toCartButton.setTitle("To cart".localized(), for: .normal)
        }
    }
}
