//
//  TaskDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 12/3/26.
//

import Foundation
import FHKDomain

public struct TaskDto: BusinessModelProtocol {
    public let created_at: String
    public let name: String
    public let description: String
    public let time_granted: Int
    public let coins_granted: Int
    public let email_parent: String
    public var fhk_goal_duration: GoalDurationDto = GoalDurationDto(duration: "")

    public struct GoalDurationDto: Codable, Sendable {
        let duration: String
    }
}

extension TaskDto: MappeableToDomain {
    public func toDomain() throws -> TaskEntity {
        return TaskEntity(
            createdAt: self.created_at,
            name: self.name,
            description: self.description,
            timeGranted: self.time_granted,
            coinsGranted: self.coins_granted,
            emailParent: self.email_parent,
            durationType: self.fhk_goal_duration.duration
        )
    }
}
