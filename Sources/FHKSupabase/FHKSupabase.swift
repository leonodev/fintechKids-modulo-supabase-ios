// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct DB {
    
    public struct TABLE_FAMILY_MEMBER {
        public static let NAME: String = "fhk_family_members"
        
        public struct COLUMN {
            public static let email = "email_parent"
            public static let memberName = "member_name"
            public static let avatarName = "avatar_name"
            public static let identificationUUID = "identification_uuid"
        }
    }
    
    public struct TABLE_TASK {
        public static let NAME: String = "fhk_task_list"
        
        public struct COLUMN {
            public static let name = "name"
            public static let timeGranted = "time_granted"
            public static let coinsGranted = "coins_granted"
            public static let email = "email_parent"
        }
    }
    
    public struct TABLE_GOAL {
        public static let NAME: String = "fhk_goals_list"
        
        public struct COLUMN {
            public static let dateExpiration = "date_expiration"
            public static let name = "name"
            public static let emailParent = "email_parent"
            public static let value = "value"
            public static let measure_type = "measure_type"
            public static let status = "status"
        }
    }
    
    public struct TABLE_BALANCE {
        public static let NAME: String = "fhk_members_balance"
        
        public struct COLUMN {
            public static let memberId = "member_id"
            public static let coinsObtained = "coins_obtained"
            public static let timeObtained = "time_obtained"
        }
        
        public struct FUNCTION_RPC {
            public static let updateBalance = "update_balance"
        }
    }
    
    public struct TABLE_REWARDS {
        public static let NAME: String = "fhk_rewards_list"
        
        public struct COLUMN {
            public static let createdAt = "created_at"
            public static let name = "name"
            public static let timeRequiered = "time_requiered"
            public static let coinsRequired = "coins_required"
            public static let emailParent = "email_parent"
        }
    }
}
