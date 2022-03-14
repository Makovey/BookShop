//
//  HomePresenter.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

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
    func viewDidLoad() {
        // WIP
    }
}

extension HomePresenter: HomeInteractorOutput {}
