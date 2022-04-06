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
    func decodeImage(base64String: String, completion: @escaping (Data?) -> Void) {
        DispatchQueue.main.async {
            completion(Data(base64Encoded: base64String))
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
