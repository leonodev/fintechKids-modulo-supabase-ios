//
//  GoalDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 15/3/26.
//

import Foundation
import FHKDomain

public struct GoalDto: BusinessModelProtocol {
    public let date_expiration: String
    public let name: String
    public let duration: String
    public let email_parent: String
    public let coins_rewards: Int
    public let time_reward: String
    public let status: String
}

extension GoalDto: MappeableToDomain {
    public func toDomain() throws -> GoalEntity {
        return GoalEntity(
            expirationDate: self.date_expiration,
            name: self.name,
            duration: self.duration,
            emailParent: self.email_parent,
            coinsReward: self.coins_rewards,
            timeReward: self.time_reward,
            status: self.status)
    }
}
