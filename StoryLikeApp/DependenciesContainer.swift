//
//  DependencyContainer.swift.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 01/11/2024.
//

import Factory

extension Container {
    var photosRepository: Factory<PhotosRepositoryProtocol> {
        Factory(self) { PhotosRepository() }
    }

    var httpRequestService: Factory<HTTPRequestServiceProtocol> {
        Factory(self) { HTTPRequestService() }
    }
}
