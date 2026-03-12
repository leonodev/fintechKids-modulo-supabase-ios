//
//  TaskEntity+Extension.swift.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 12/3/26.
//

import FHKDomain

extension TaskEntity: MappeableToSupabase {
    public func toDto() throws -> TaskDto {
        return TaskDto(created_at: self.createdAt,
                       name: self.name,
                       time_granted: self.timeGranted,
                       coins_granted: self.coinsGranted,
                       email_parent: self.emailParent)
    }
}
