//
//  GoalEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 15/3/26.
//


import FHKDomain

extension GoalEntity: MappeableToSupabase {
    public func toDto() throws -> GoalDto {
        return GoalDto(date_expiration: self.expirationDate,
                       name: self.name,
                       duration: self.duration,
                       email_parent: self.emailParent,
                       coins_rewards: self.coinsReward,
                       time_reward: self.timeReward,
                       status: self.status
        )
    }
}
