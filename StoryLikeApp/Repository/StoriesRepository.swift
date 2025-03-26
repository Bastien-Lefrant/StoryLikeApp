//
//  StoriesRepository.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 01/11/2024.
//

import OSLog
import Alamofire
import Factory

// MARK: - Protocol
protocol StoriesRepositoryProtocol {
    func fetchStories() async throws -> [Story]
}

// MARK: - Class
/// This class is the repository responsible for fetching photos from Unsplash and returning domain objects
final class StoriesRepository: StoriesRepositoryProtocol {

    // MARK: Constants
    enum Constants {
        static let perPageQueryKey: String = "per_page"
        static let perPageQueryValue: Int = 10
        static let pageIndexQueryKey: String = "page"
        static let unsplashEndPoint: String = "https://api.unsplash.com/photos"
    }

    // MARK: Properties
    private let requestHeaders: HTTPHeaders = makeHTTPHeaders()
    private var currentPageIndex: Int = 1

    // MARK: DI
    @Injected(\.httpRequestService) private var requestService: HTTPRequestServiceProtocol

    // MARK: Public Methods
    func fetchStories() async throws -> [Story] {
        let requestURL = URL(string: Constants.unsplashEndPoint)?
            .appending(queryItems: [URLQueryItem(name: Constants.perPageQueryKey,
                                                 value: "\(Constants.perPageQueryValue)"),
                                    URLQueryItem(name: Constants.pageIndexQueryKey,
                                                 value: "\(currentPageIndex)")])
        
        let stories = try await requestService.performRequest(requestURL: requestURL,
                                                              requestHeaders: requestHeaders,
                                                              responseType: [StoryDTO].self)
            .map { Story(with: $0) }

        Logger.repository.info("Stories fetched successfully.")
        currentPageIndex += 1
        
        return stories
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
