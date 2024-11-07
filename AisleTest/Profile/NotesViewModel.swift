//
//  NotesViewModel.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
import Foundation

class NotesViewModel{
    
    
    func getNotes(){
        UserEndpoint.getUserProfile.execute() { [weak self] in
            switch $0 {
            case .success(let data):
                guard let response = data as? NSDictionary else { return }
                //handle Success Here.
            case .failure(let error):
                debugPrint(error)
                //handle error here.
            }
        }
    }
}
