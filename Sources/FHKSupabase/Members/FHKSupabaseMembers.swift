//
//  FHKSupabaseMembers.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 28/2/26.
//

import Foundation
import Supabase
import FHKDomain
import FHKUtils
import PostgREST

public final class FHKSupabaseMembers: FHKSupabaseErrorProtocol, FHKSupabaseMembersProtocol {
    let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func addMembers(members: [MemberEntity]) async throws {
        do {
            let membersDto = try members.toDto()
            
            let response = try await supabaseClient
                .from(DB.TABLE_FAMILY_MEMBER.NAME)
                .insert(membersDto)
                .execute()
            
            if response.status >= 400 {
                throw FHKSupabaseError.unknown("Error unknown: \(response.status)")
            }
        } catch let pgError as PostgrestError {
            let code = pgError.code ?? ""
            let errorToThrow = mapPostgresError(code, message: pgError.message)
            throw errorToThrow
        } catch {
            throw FHKSupabaseError.unknown(error.localizedDescription)
        }
    }
    
    public func fetchFamilyMembers(parentEmail: String) async throws -> [MemberEntity] {
        print(supabaseClient)
        let members: [MemberDto] = try await supabaseClient
            .from(DB.TABLE_FAMILY_MEMBER.NAME)
            .select()
            .eq(DB.TABLE_FAMILY_MEMBER.COLUMN.email, value: parentEmail)
            .execute()
            .value
        
        return try members.toDomain()
    }
    
    public func deleteMember(identification: UUID) async throws {
        try await supabaseClient.from(DB.TABLE_FAMILY_MEMBER.NAME)
            .delete()
            .eq(DB.TABLE_FAMILY_MEMBER.COLUMN.identificationUUID, value: identification)
            .execute()
    }
}
