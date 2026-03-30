//
//  BalanceEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 30/3/26.
//

import FHKDomain

extension BalanceEntity: MappeableToSupabase {
    public func toDto() throws -> BalanceDto {
        return BalanceDto(member_id: self.memberId,
                          coins_obtained: self.coinsObtained,
                          time_obtained: self.timeObtained
        )
    }
}
