//
//  FHKSupabaseTask.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 12/3/26.
//

import Foundation
import Supabase
import FHKDomain
import FHKUtils
import PostgREST

public final class FHKSupabaseTask: FHKSupabaseErrorProtocol, FHKSupabaseTaskProtocol {
    let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func createTask(task: TaskEntity) async throws {
        do {
            let taskDto = try task.toDto()
            let response = try await supabaseClient
                .from(DB.TABLE_TASK.NAME)
                .insert(taskDto)
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
    
    public func getTasks(parentEmail: String) async throws -> [TaskEntity] {
        let taskList: [TaskDto] = try await supabaseClient
            .from(DB.TABLE_TASK.NAME)
            .select()
//            .select("""
//                        *,
//                        fhk_goal_duration (
//                            duration
//                        )
//                    """)
            .eq(DB.TABLE_TASK.COLUMN.email, value: parentEmail)
            .execute()
            .value
        
        return try taskList.toDomain()
    }
}
