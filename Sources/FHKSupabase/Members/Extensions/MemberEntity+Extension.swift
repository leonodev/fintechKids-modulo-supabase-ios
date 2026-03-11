//
//  MemberEntity+Extension.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 11/3/26.
//

import FHKDomain

extension MemberEntity: MappeableToSupabase {
    public func toDto() throws -> MemberDto {
        return MemberDto(
            identification_uuid: self.id,
            email_parent: self.emailParent,
            member_name: self.memberName,
            name_family: self.familyName,
            avatar_name: self.avatarName
        )
    }
}
