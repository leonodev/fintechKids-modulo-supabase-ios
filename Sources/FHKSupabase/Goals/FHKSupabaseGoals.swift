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
            
            if response.status >= 400 {
                throw OperationError.creationError
            }

            Logger.info("Status Code: \(response.status)")
        } catch {
            if let postgrestError = error as? PostgrestError {
               
                let myPgError = FHKPostgresError(
                    code: postgrestError.code ?? "",
                    message: postgrestError.message,
                    hint: postgrestError.hint
                )
                
                Logger.error("Capturado error de Postgres: \(myPgError.code)")
                
                switch myPgError.code {
                case "22007":
                    throw OperationError.invalidDate
                default:
                    throw OperationError.databaseError(myPgError.message)
                }
            }
            
            // Si no es un error de Postgres, lanzamos el genérico
            throw OperationError.networkError(error.localizedDescription)
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
