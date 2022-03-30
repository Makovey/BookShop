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
    func createDiscountBlock(discountsData: [DiscountDTO])
}

protocol HomeViewControllerOutput {
    func viewDidLoad()
}

class HomeViewController: UIViewController {
    var output: HomeViewControllerOutput?
    
    var name: String?
    
    lazy var nameLabel = Label(withText: "Welcome,".localized() + " \(name ?? "")", fontSize: Constant.biggestFontSize)
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
    
    lazy var discountScrollView: UIScrollView = {
        let discountScrollView = UIScrollView()
        discountScrollView.isPagingEnabled = true
        discountScrollView.showsHorizontalScrollIndicator = false
        
        discountScrollView.translatesAutoresizingMaskIntoConstraints = false
        return discountScrollView
    }()
    
    lazy var discountStack: UIStackView = {
        let discountStack = UIStackView()
        
        discountStack.translatesAutoresizingMaskIntoConstraints = false
        return discountStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        output?.viewDidLoad()
        
        configureGreetingsStack()
        configureDiscountLabel()
        configureDiscountScrollView()
        configureDiscountStack()
    }
    
    private func configureGreetingsStack() {
        view.addSubview(greetingStack)
        
        NSLayoutConstraint.activate([
            greetingStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -Constant.topDistance),
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
    
    private func configureDiscountScrollView() {
        view.addSubview(discountScrollView)
        
        NSLayoutConstraint.activate([
            discountScrollView.topAnchor.constraint(equalTo: discountLabel.bottomAnchor),
            discountScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.sideDistance),
            discountScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.sideDistance),
            discountScrollView.heightAnchor.constraint(equalToConstant: Constant.Discount.discountBlockHeight)
        ])
    }
    
    private func configureDiscountStack() {
        discountScrollView.addSubview(discountStack)
        
        NSLayoutConstraint.activate([
            discountStack.topAnchor.constraint(equalTo: discountScrollView.topAnchor),
            discountStack.bottomAnchor.constraint(equalTo: discountScrollView.bottomAnchor),
            discountStack.leadingAnchor.constraint(equalTo: discountScrollView.leadingAnchor),
            discountStack.trailingAnchor.constraint(equalTo: discountScrollView.trailingAnchor)
        ])
        
    }
    
    private func createContainerForDiscount() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        discountStack.addArrangedSubview(container)

        container.heightAnchor.constraint(equalTo: discountScrollView.heightAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: discountScrollView.widthAnchor).isActive = true
        
        return container
    }
    
}

extension HomeViewController: HomeViewControllerInput {
    func createDiscountBlock(discountsData: [DiscountDTO]) {
        discountsData.forEach { (discountData) in
            let container = createContainerForDiscount()
            
            let discountView = DiscountView(discountData: discountData)
            
            discountView.assemblyAndEdgeTo(container)
            
        }
    }
    
    func showBannerError(_ error: ServiceError) {
        ErrorManager.showErrorBanner(text: error.title)
    }
}
