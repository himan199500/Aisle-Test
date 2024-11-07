//
//  Model.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
//
//class Response{
//    var invites = Invites()
//    var likes = Likes()
//
//    
//    convenience init(json Response:[String:Any]){
//        self.init()
//        answerId = Response["answer_id"] as? Int ?? 0
//        id = Response["answer"] as? Int ?? 0
//        value = Response["value"] as? Int ?? 0
//        preferenceQuestion = PreferenceQuestion.init(json: Response["preference_question"] as? [String:Any] ?? [:])
//    }
//}
//
//




// MARK: - Preference Model
class Preference {
    var answerId: Int = 0
    var id: Int = 0
    var value: Int = 0
    var preferenceQuestion = PreferenceQuestion()

    convenience init(json Response:[String:Any]){
        self.init()
        answerId = Response["answer_id"] as? Int ?? 0
        id = Response["answer"] as? Int ?? 0
        value = Response["value"] as? Int ?? 0
        preferenceQuestion = PreferenceQuestion.init(json: Response["preference_question"] as? [String:Any] ?? [:])
    }
}


// MARK: - Preference Question Model
class PreferenceQuestion {
    var firstChoice: String = ""
    var secondChoice: String = ""

    convenience init(json Response:[String:Any]){
        self.init()
        firstChoice = Response["first_choice"] as? String ?? ""
        secondChoice = Response["second_choice"] as? String ?? ""
    }
}


// MARK: - Profile Data Model
class ProfileData {
    var question: String = ""
    var preferences = [ProfilePreference]()
    var invitationType: String = ""

    
    convenience init(json Response:[String:Any]){
        self.init()
        question = Response["question"] as? String ?? ""
        preferences = (Response["preferences"] as? [[String:Any]] ?? []).map({ preference in
            ProfilePreference.init(json: preference)
        })
        invitationType = Response["invitation_type"] as? String ?? ""
    }
}


class ProfilePreference {
    var answerId: Int = 0
    var answer: String = ""
    var firstChoice: String = ""
    var secondChoice: String = ""

    convenience init(json Response:[String:Any]){
        self.init()
        answerId = Response["answer_id"] as? Int ?? 0
        answer = Response["answer"] as? String ?? ""
        firstChoice = Response["first_choice"] as? String ?? ""
        secondChoice = Response["second_choice"] as? String ?? ""
    }
}

class Likes {

    var profiles = [LikedProfile]()
    var canSeeProfile: Bool = false
    var likesReceivedCount: Int = 0

    convenience init(json Response:[String:Any]){
        self.init()
        let profileArray = Response["profiles"] as? [[String:Any]] ?? []
        profiles = profileArray.map({ profile in
            LikedProfile.init(json: profile)
        })
        canSeeProfile = Response["can_see_profile"] as? Bool ?? false
        likesReceivedCount = Response["likes_received_count"] as? Int ?? 0
    }
}

class LikedProfile {
    var firstName: String = ""
    var avatar: String = ""

    convenience init(json Response:[String:Any]){
        self.init()
        firstName = Response["first_name"] as? String ?? ""
        avatar = Response["avatar"] as? String ?? ""
    }
}
