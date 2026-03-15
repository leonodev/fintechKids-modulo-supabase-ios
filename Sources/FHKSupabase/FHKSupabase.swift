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
            public static let duration = "duration"
            public static let emailParent = "email_parent"
            public static let coinsRewards = "coins_rewards"
            public static let timeReward = "time_reward"
            public static let status = "status"
        }
    }
}
