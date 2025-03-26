//
//  HTTPRequestService.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Foundation
import Alamofire
import OSLog

// MARK: - Protocol
protocol HTTPRequestServiceProtocol {
    func performRequest<T: Decodable>(requestURL: URL?,
                                      requestHeaders: HTTPHeaders?,
                                      responseType: T.Type) async throws -> T
}

// MARK: - Class
/// This class is responsible for performing the httpRequests
final class HTTPRequestService: HTTPRequestServiceProtocol {

    // MARK: Properties
    private let session: Session

    // MARK: Init
    init(session: Session = AF) {
        self.session = session
    }

    // MARK: Public Methods
    func performRequest<T>(requestURL: URL?,
                           requestHeaders: HTTPHeaders?,
                           responseType: T.Type) async throws -> T where T: Decodable {
        guard let requestURL else {
            throw RequestError.invalidURL
        }

        do {
            return try await session.request(requestURL, headers: requestHeaders)
                .validate()
                .serializingDecodable(responseType)
                .value
        } catch {
            let requestError = switch error.asAFError {
            case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
                switch code {
                case 400, 401, 403, 404:
                    RequestError.requestError
                case 500, 503:
                    RequestError.serverError
                default:
                    RequestError.unknownError
                }
            case .responseSerializationFailed:
                RequestError.decodingError
            default:
                RequestError.unknownError
            }

            Logger.networking.error("Request failed: \(error)")
            throw requestError
        }
    }
}

// MARK: - Custom Errors
extension HTTPRequestService {
    enum RequestError: Error, CustomStringConvertible {
        case invalidURL
        case requestError
        case serverError
        case decodingError
        case unknownError

        var description: String {
            return switch self {
            case .requestError: Strings.Errors.requestError
            case .serverError: Strings.Errors.serverError
            case .decodingError: Strings.Errors.decodingError
            case .invalidURL, .unknownError: Strings.Errors.unknownError
            }
        }
    }
}
