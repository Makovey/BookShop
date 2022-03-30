//
//  HomeInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

import Foundation

protocol HomeInteractorInput {
    func getCurrentDiscounts(sizeOfDiscounts: Int)
}

protocol HomeInteractorOutput {
    func getDiscountResponse(discounts: [DiscountDTO])
    func errorFromService(error: ServiceError)
}

class HomeInteractor {
    var output: HomeInteractorOutput?
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}

extension HomeInteractor: HomeInteractorInput {
    func getCurrentDiscounts(sizeOfDiscounts: Int) {
        networkService.getDiscounts(size: sizeOfDiscounts) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.output?.getDiscountResponse(discounts: data)
                case .failure(let networkError):
                    self?.output?.errorFromService(error: networkError.failure)
                }
            }
        }
    }
}
