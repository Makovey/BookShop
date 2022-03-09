//
//  HomeInteractor.swift
//  BookShop
//
//  Created by MAKOVEY Vladislav on 04.03.2022.
//

protocol HomeInteractorInput {}

protocol HomeInteractorOutput {}

class HomeInteractor {
    var output: HomeInteractorOutput?
}

extension HomeInteractor: HomeInteractorInput {}
