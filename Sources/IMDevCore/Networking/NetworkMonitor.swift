//
//  NetworkMonitor.swift
//  IMDevCore
//
//  Created by Ike Mattice on 11/20/24.
//

import Network

public final class NetworkMonitor {
    public static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor = NWPathMonitor()

    public var status: NWPath.Status = .requiresConnection
    public var unsatisfiedReason: NWPath.UnsatisfiedReason?
    public var isReachableOnCellular: Bool = true

    public var isReachable: Bool {
        status == .satisfied
    }

    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            guard path.status == .satisfied else {
                self?.unsatisfiedReason = path.unsatisfiedReason

                return
            }

            self?.unsatisfiedReason = nil
        }

        let queue: DispatchQueue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}
