//
//  NetworkMonitor.swift
//  IMDevCore
//
//  Created by Ike Mattice on 11/20/24.
//

import Network

public final class NetworkMonitor {
    static let shared = NetworkMonitor()

    let monitor: NWPathMonitor = NWPathMonitor()

    var status: NWPath.Status = .requiresConnection
    var unsatisfiedReason: NWPath.UnsatisfiedReason?
    var isReachableOnCellular: Bool = true

    var isReachable: Bool {
        status == .satisfied
    }

    func startMonitoring() {
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

    func stopMonitoring() {
        monitor.cancel()
    }
}
