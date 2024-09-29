//
//  NetworkProvider.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Alamofire
import Combine
import CombineMoya
import Foundation
import Moya

final class Provider<T>: MoyaProvider<T> where T: MultiTargetType {
    typealias Target = T

    init() {
        super.init(
            endpointClosure: MoyaProvider.defaultEndpointMapping,
            requestClosure: MoyaProvider<Target>.defaultRequestMapping,
            stubClosure: MoyaProvider.neverStub,
            session: NetworkConfiguration.sessionManager,
            plugins: [NetworkActivityPlugin(
                networkActivityClosure: NetworkConfiguration.networkActivityIndicator),
            NetworkConfiguration.networkLogger],
            trackInflights: false)
    }

    func request<C>(_ target: Target) async throws -> C where C: Codable {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(response):
                    do {
                        let data = try response.map(C.self)
                        continuation.resume(returning: data)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
