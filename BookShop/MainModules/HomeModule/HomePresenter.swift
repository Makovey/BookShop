//
//  HomePresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import UIKit

class HomePresenter {
    private weak var viewController: HomeViewControllerInput?
    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput
    
    init(viewController: HomeViewControllerInput, router: HomeRouterInput, interactor: HomeInteractorInput) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomeViewControllerOutput {
    func decodeImage(base64String: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            guard let imageData = Data(base64Encoded: base64String) else {
                completion(UIImage(systemName: "book.closed.fill"))
                return
            }
            
            completion(UIImage(data: imageData))
            return
        }
    }
    
    func viewDidLoad() {
        interactor.getCurrentDiscounts(sizeOfDiscounts: 4)
    }
}

extension HomePresenter: HomeInteractorOutput {
    func getDiscountResponse(discounts: [DiscountDTO]) {
        viewController?.fetchDiscountData(discountsData: discounts)
    }
    
    func errorFromService(error: ServiceError) {
        viewController?.showBannerError(error)
    }
}
