//
//  FHKSupabaseGoals.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 15/3/26.
//

import Foundation
import Supabase
import FHKDomain
import FHKUtils
import PostgREST

public final class FHKSupabaseGoals: FHKSupabaseErrorProtocol, FHKSupabaseGoalProtocol {
    let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func createGoal(goal: GoalEntity) async throws {
        do {
            let goalDto = try goal.toDto()

            let response = try await supabaseClient
                .from(DB.TABLE_GOAL.NAME)
                .insert(goalDto)
                .execute()
            
            if response.status >= 400 {
                throw FHKSupabaseError.unknown("Error unknown: \(response.status)")
            }

        } catch let pgError as PostgrestError {
            let code = pgError.code ?? ""
            let errorToThrow = mapPostgresError(code, message: pgError.message)
            
            //Logger.error("Error Mapped of DB: \(code)")
            throw errorToThrow
        } catch {
            Logger.error("Error de DB: \(error)")
            throw OperationError.creationError
        }
    }
    
    public func getGoals(emailParent: String) async throws -> [GoalEntity] {
        let goalList: [GoalDto] = try await supabaseClient
            .from(DB.TABLE_GOAL.NAME)
            .select()
            .eq(DB.TABLE_GOAL.COLUMN.emailParent, value: emailParent)
            .execute()
            .value
        
        return try goalList.toDomain()
    }
}
