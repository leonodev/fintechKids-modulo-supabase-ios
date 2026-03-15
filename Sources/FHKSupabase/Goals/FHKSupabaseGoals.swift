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

public final class FHKSupabaseGoals: FHKSupabaseGoalProtocol {
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
            
            Logger.info("Status Code: \(response.status)")
        } catch {
            Logger.error("Error de Supabase: \(error.localizedDescription)")
            if let decodingError = error as? DecodingError {
                Logger.error("Error de decodificación: \(decodingError)")
            }
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
