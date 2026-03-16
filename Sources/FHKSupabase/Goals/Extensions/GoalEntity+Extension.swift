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
                       email_parent: self.emailParent,
                       value: self.value,
                       measure_type: self.measureType,
                       status: self.status
        )
    }
}
