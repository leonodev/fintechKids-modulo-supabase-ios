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

public final class FHKSupabaseTask: FHKSupabaseTaskProtocol {
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
            
            Logger.info("Status Code: \(response.status)")
        } catch {
            Logger.error("Error de Supabase: \(error.localizedDescription)")
            if let decodingError = error as? DecodingError {
                Logger.error("Error de decodificación: \(decodingError)")
            }
        }
    }
    
    public func getTasks(parentEmail: String) async throws -> [TaskEntity] {
        let taskList: [TaskDto] = try await supabaseClient
            .from(DB.TABLE_TASK.NAME)
            .select("""
                        *,
                        fhk_goal_duration (
                            duration
                        )
                    """)
            .eq(DB.TABLE_TASK.COLUMN.email, value: parentEmail)
            .execute()
            .value
        
        return try taskList.toDomain()
    }
}
