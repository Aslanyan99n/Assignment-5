//
//  NetworkConfiguration.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Alamofire
import Foundation
import Moya
import Pulse
import SwiftUI

/// Confige network
enum NetworkConfiguration {
    /// Logger for network
    /// - Default: Enable
    static let networkLogger = NetworkLoggerPlugin(
        configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))

    /// Configuration for session manager
    static var sessionManager: Session {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 90
        configuration.timeoutIntervalForResource = 90
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Alamofire.Session(customConfiguration: configuration, startRequestsImmediately: false)
    }

    /// Block for application network indicator
    typealias NetworkIndicator = (NetworkActivityChangeType, TargetType) -> Void

    static var networkActivityIndicator: NetworkIndicator {
        return { (change: NetworkActivityChangeType, _: TargetType) in
            switch change {
            case .began:
                Console.log("began")
            case .ended:
                Console.log("ended")
            }
        }
    }
}

public extension Alamofire.Session {
    convenience init(customConfiguration: URLSessionConfiguration = URLSessionConfiguration.af.default,
                     delegate: SessionDelegate = SessionDelegate(),
                     rootQueue: DispatchQueue = DispatchQueue(label: "org.alamofire.session.rootQueue"),
                     startRequestsImmediately: Bool = true,
                     requestQueue: DispatchQueue? = nil,
                     serializationQueue: DispatchQueue? = nil,
                     interceptor: RequestInterceptor? = nil,
                     serverTrustManager: ServerTrustManager? = nil,
                     redirectHandler: RedirectHandler? = nil,
                     cachedResponseHandler: CachedResponseHandler? = nil,
                     eventMonitors: [EventMonitor] = [])
    {
        precondition(customConfiguration.identifier == nil, "Alamofire does not support background URLSessionConfigurations.")

        // Retarget the incoming rootQueue for safety, unless it's the main queue, which we know is safe.
        let serialRootQueue = (rootQueue === DispatchQueue.main) ? rootQueue : DispatchQueue(label: rootQueue.label,
                                                                                             target: rootQueue)
        let delegateQueue = OperationQueue(maxConcurrentOperationCount: 1, underlyingQueue: serialRootQueue, name: "\(serialRootQueue.label).sessionDelegate")
        #if DEBUG
        let session: URLSessionProtocol = URLSessionProxy(configuration: customConfiguration, delegate: delegate, delegateQueue: delegateQueue)
        #else
        let session = URLSession(configuration: customConfiguration, delegate: delegate, delegateQueue: delegateQueue)
        #endif
        var urlSession: URLSession
        if let session = session as? URLSessionProxy {
            urlSession = session.session
        } else {
            urlSession = URLSession(configuration: customConfiguration, delegate: delegate, delegateQueue: delegateQueue)
        }
        self.init(session: urlSession,
                  delegate: delegate,
                  rootQueue: serialRootQueue,
                  startRequestsImmediately: startRequestsImmediately,
                  requestQueue: requestQueue,
                  serializationQueue: serializationQueue,
                  interceptor: interceptor,
                  serverTrustManager: serverTrustManager,
                  redirectHandler: redirectHandler,
                  cachedResponseHandler: cachedResponseHandler,
                  eventMonitors: eventMonitors)
    }
}

extension OperationQueue {
    /// Creates an instance using the provided parameters.
    ///
    /// - Parameters:
    ///   - qualityOfService:            `QualityOfService` to be applied to the queue. `.default` by default.
    ///   - maxConcurrentOperationCount: Maximum concurrent operations.
    ///                                  `OperationQueue.defaultMaxConcurrentOperationCount` by default.
    ///   - underlyingQueue: Underlying  `DispatchQueue`. `nil` by default.
    ///   - name:                        Name for the queue. `nil` by default.
    ///   - startSuspended:              Whether the queue starts suspended. `false` by default.
    convenience init(qualityOfService: QualityOfService = .default,
                     maxConcurrentOperationCount: Int = OperationQueue.defaultMaxConcurrentOperationCount,
                     underlyingQueue: DispatchQueue? = nil,
                     name: String? = nil,
                     startSuspended: Bool = false)
    {
        self.init()
        self.qualityOfService = qualityOfService
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
        self.underlyingQueue = underlyingQueue
        self.name = name
        isSuspended = startSuspended
    }
}
