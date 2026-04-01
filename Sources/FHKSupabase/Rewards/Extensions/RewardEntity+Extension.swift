//
//  RewardEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 1/4/26.
//


import FHKDomain

extension RewardEntity: MappeableToSupabase {
    public func toDto() throws -> RewardDto {
        return RewardDto(
            created_at: self.createdAt,
            name: self.name,
            time_requiered: self.timeRequiered,
            coins_required: self.coinsRequiered,
            email_parent: self.emailParent
        )
    }
}
