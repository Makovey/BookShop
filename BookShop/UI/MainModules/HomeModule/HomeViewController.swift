//
//  HomeViewController.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import Foundation
import UIKit

protocol HomeViewControllerInput: AnyObject {
    func showBannerError(_ error: ServiceError)
    func fetchedDiscountData(discountsData: [DiscountDTO])
}

protocol HomeViewControllerOutput {
    func viewDidLoad()
}

class HomeViewController: UIViewController {
    var output: HomeViewControllerOutput?
    
    var name: String?
    
    var discounts: [DiscountDTO]?
    
    lazy var nameLabel = Label(withText: String(format: "Welcome, %@".localized(), name ?? ""), fontSize: Constant.biggestFontSize)
    var wishLabel: Label {
        let wishLabel = Label(withText: "Have a nice day :)".localized(), fontSize: Constant.middleFontSize)
        wishLabel.textColor = .systemGray
        
        return wishLabel
    }
    
    lazy var greetingStack: UIStackView = {
        greetingStack = UIStackView(arrangedSubviews: [nameLabel, wishLabel])
        greetingStack.axis = .vertical
        greetingStack.distribution = .equalSpacing
        
        greetingStack.translatesAutoresizingMaskIntoConstraints = false
        return greetingStack
    }()
    
    let discountLabel = Label(withText: "best deal of the week".localized(), fontSize: Constant.middleFontSize)
    
    lazy var discountCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(DiscountViewCell.self, forCellWithReuseIdentifier: "DiscountCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureGreetingsStack()
        configureDiscountLabel()
        configureDiscountCollectionView()
        
        output?.viewDidLoad()
    }
    
    private func configureGreetingsStack() {
        view.addSubview(greetingStack)
        
        NSLayoutConstraint.activate([
            greetingStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            greetingStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            greetingStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            greetingStack.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }
    
    private func configureDiscountLabel() {
        view.addSubview(discountLabel)
        
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            discountLabel.topAnchor.constraint(equalTo: greetingStack.bottomAnchor, constant: Constant.topDistance),
            discountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            discountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            discountLabel.heightAnchor.constraint(equalToConstant: Constant.stackHeight)
        ])
    }
    
    private func configureDiscountCollectionView() {
        view.addSubview(discountCollectionView)
        
        NSLayoutConstraint.activate([
            discountCollectionView.topAnchor.constraint(equalTo: discountLabel.bottomAnchor),
            discountCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            discountCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            discountCollectionView.heightAnchor.constraint(equalToConstant: Constant.Discount.discountBlockHeight)
        ])
    }
    
    var productTagsInCart = [Int]()
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discounts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountCell", for: indexPath) as? DiscountViewCell else {
            return UICollectionViewCell()
        }
        
        stylizeCell(cell)
        
        if let data = discounts?[indexPath.row] {
            cell.bookImage.image = UIImage(systemName: "book.closed.fill")
            
            data.decodeImageToData { decodedImage in
                if let safetyDecoded = decodedImage {
                    if let safetyImage = UIImage(data: safetyDecoded) {
                        DispatchQueue.main.async {
                            cell.bookImage.image = safetyImage
                        }
                    }
                }
            }
            
            cell.title.text = data.name
            cell.descriptionOfBook.text = data.description
            cell.oldPrice.attributedText = data.oldPrice.strikeThrough()
            cell.newPrice.text = data.newPrice
            
            if productTagsInCart.contains(indexPath.row) {
                cell.toCartButton.changeButtonStateToInCart()
            } else {
                cell.toCartButton.changeButtonStateToNotInCart()
            }
            
            cell.toCartButton.tag = indexPath.row
            cell.toCartButton.addTarget(self, action: #selector(toCartButtonTapped), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc private func toCartButtonTapped(button: Button) {
        if productTagsInCart.contains(button.tag) {
            if let index = productTagsInCart.firstIndex(of: button.tag) {
                productTagsInCart.remove(at: index)
            }
            button.changeButtonStateToNotInCart()
        } else {
            productTagsInCart.append(button.tag)
            button.changeButtonStateToInCart()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        
        return CGSize(width: frameSize.width - 20, height: frameSize.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func stylizeCell(_ cell: UICollectionViewCell) {
        cell.backgroundColor = .systemBackground
        
        cell.layer.cornerRadius = 20
        
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 2
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.label.cgColor
    }
    
}

extension HomeViewController: HomeViewControllerInput {
    func fetchedDiscountData(discountsData: [DiscountDTO]) {
        discounts = discountsData
        discountCollectionView.reloadData()
    }
    
    func showBannerError(_ error: ServiceError) {
        ErrorManager.showErrorBanner(text: error.title)
    }
}
