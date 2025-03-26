//
//  PhotosRepository.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 01/11/2024.
//

import OSLog
import Alamofire
import Factory

// MARK: - Protocol
protocol PhotosRepositoryProtocol {
    func fetchPhotos() async throws -> [Photo]
    func fetchAdditionalInfosForPhoto(_ photo: Photo) async throws -> Photo.AdditionalInformations
}

// MARK: - Class
/// This class is the repository responsible for fetching photos from Unsplash and returning domain objects
final class PhotosRepository: PhotosRepositoryProtocol {

    // MARK: Constants
    enum Constants {
        static let perPageQueryKey: String = "per_page"
        static let perPageValue: Int = 30
        static let unsplashEndPoint: String = "https://api.unsplash.com/photos"
    }

    // MARK: Properties
    private let requestHeaders: HTTPHeaders = makeHTTPHeaders()

    // MARK: DI
    @Injected(\.httpRequestService) private var requestService: HTTPRequestServiceProtocol

    // MARK: Public Methods
    func fetchPhotos() async throws -> [Photo] {
        let requestURL = URL(string: Constants.unsplashEndPoint)?
            .appending(queryItems: [URLQueryItem(name: Constants.perPageQueryKey,
                                                 value: "\(Constants.perPageValue)")])

        let photos = try await requestService.performRequest(requestURL: requestURL,
                                                             requestHeaders: requestHeaders,
                                                             responseType: [PhotoDTO].self)
            .map { Photo(with: $0) }

        Logger.repository.info("Photos fetched successfully.")
        return photos
    }

    func fetchAdditionalInfosForPhoto(_ photo: Photo) async throws -> Photo.AdditionalInformations {
        let requestURL = URL(string: Constants.unsplashEndPoint)?.appendingPathComponent(photo.id)
        let additionalInfosDTO = try await requestService.performRequest(requestURL: requestURL,
                                                                         requestHeaders: requestHeaders,
                                                                         responseType: AdditionalInformationsDTO.self)

        Logger.repository.info("Additional infos fetched successfully.")

        let additionalInfos = Photo.AdditionalInformations(with: additionalInfosDTO)
        return additionalInfos
    }

    // MARK: Private Methods
    private static func makeHTTPHeaders() -> HTTPHeaders {
        var headers = [HTTPHeader]()

        if let accessKey = Bundle.main.infoDictionary?["UnsplashAccessKey"] as? String {
            headers.append(HTTPHeader(name: "Authorization", value: "Client-ID \(accessKey)"))
        } else {
            Logger.repository.warning("UnsplashAccessKey not found in Info.plist")
        }
        return HTTPHeaders(headers)
    }
}
