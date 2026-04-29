//
//  GoalMemberEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 29/4/26.
//

import FHKDomain

extension GoalMemberEntity: MappeableToSupabase {
    public func toDto() throws -> GoalMemberDto {
        return GoalMemberDto(goal_id: self.goalId,
                             member_id: self.memberId,
                             rewards_system_value: self.rewardsSystemValue,
                             accumulated_value: self.taskWinnedValue, // It takes the value of the task and adds it to what is in the backend.
                             rewards_system_type: self.rewardsSystemType)
    }
}
