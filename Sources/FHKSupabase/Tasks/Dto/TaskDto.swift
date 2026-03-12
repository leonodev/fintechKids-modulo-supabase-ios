//
//  TaskDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 12/3/26.
//

import Foundation
import FHKDomain

public struct TaskDto: BusinessModelProtocol {
    public let id: Int
    public let created_at: String
    public let name: String
    public let time_granted: Int
    public let coins_granted: Int
    public let email_parent: String
}

extension TaskDto: MappeableToDomain {
    public func toDomain() throws -> TaskEntity {
        return TaskEntity(
            id: self.id,
            createdAt: self.created_at,
            name: self.name,
            timeGranted: self.time_granted,
            coinsGranted: self.coins_granted,
            emailParent: self.email_parent)
    }
}
