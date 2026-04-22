//
//  RewardCollectDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 21/4/26.
//

import Foundation
import FHKDomain

public struct RewardCollectedDto: BusinessModelProtocol {
    public let id: Int
    public let created_at: String
    public let parent_email: String
    public let name_reward: String
    public let member: MemberDto
    public let claimed_value: String
    public let state: String
    public let name_task: String
}

extension RewardCollectedDto: MappeableToDomain {
    public func toDomain() -> RewardCollectedEntity {
        return RewardCollectedEntity(id: self.id,
                                     createdDate: self.created_at,
                                     member: self.member.toDomain(),
                                     parentEmail: self.parent_email,
                                     nameReward: self.name_reward,
                                     claimedValue: self.claimed_value,
                                     state: self.state,
                                     nameTask: self.name_task)
    }
}
