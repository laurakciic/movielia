//
//  ScheduleServiceProtocol.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import Foundation

protocol ScheduleServiceProtocol: AnyObject {
    
    func fetchSchedule(completionHandler: @escaping (Result<[ScheduleResponse], Error>) -> Void)
}
