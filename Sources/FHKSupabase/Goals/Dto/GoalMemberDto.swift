//
//  GoalMemberDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 29/4/26.
//

import Foundation
import FHKDomain

public struct GoalMemberDto: BusinessModelProtocol {
    let goal_id: Int
    let member_id: UUID
    let rewards_system_value: Int
    let accumulated_value: Int
    let rewards_system_type: String
}

extension GoalMemberDto: MappeableToDomain {
    public func toDomain() throws -> GoalMemberEntity {
        
        return GoalMemberEntity(goalId: self.goal_id,
                                memberId: self.member_id,
                                rewardsSystemValue: self.rewards_system_value,
                                accumulatedValue: self.accumulated_value,
                                rewardsSystemType: self.rewards_system_type
        )
    }
}
