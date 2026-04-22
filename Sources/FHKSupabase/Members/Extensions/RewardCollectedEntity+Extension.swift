//
//  RewardCollectedEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 21/4/26.
//

import FHKDomain

extension RewardCollectedEntity: MappeableToSupabase {
    public func toDto() throws -> RewardCollectedDto {
        return RewardCollectedDto(id: self.id,
                                  created_at: self.createdDate,
                                  parent_email: self.parentEmail,
                                  name_reward: self.nameReward,
                                  member: try self.member.toDto(),
                                  claimed_value: self.claimedValue,
                                  state: self.state,
                                  name_task: self.nameTask)
    }
}
