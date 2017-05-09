//
//  CalendarEvents.swift
//  Life
//
//  Created by Tyler Wilson on 4/13/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import Foundation
import EventKit

protocol CalendarEventsDelegate: class {
    func receivedEvents(events: [String: Array<String>])
}

class CalendarEvents {
    
    weak var delegate:CalendarEventsDelegate?
    
    let eventStore = EKEventStore()
    let today = NSDate(timeIntervalSinceNow: 0)
    
    private var eventTitle = [String]()
    private var eventEndTime = [String]()
    private var eventInfo = [String: Array<String>]()

    
    func getEvents(){
//        eventStore.requestAccess(to: .event, completion: {_,_ in 
//            print("yes")
//        })
        let calendar = eventStore.calendars(for: .event)
        let predicate = eventStore.predicateForEvents(withStart: today as Date, end: today as Date, calendars: calendar)        
        let events = eventStore.events(matching: predicate)
        
        if events.isEmpty {
            eventTitle.append("No events scheduled today")
            eventEndTime.append("")
            delegate?.receivedEvents(events: eventInfo)
        }else{
            for event in events {
                eventTitle.append(event.title)
                eventEndTime.append(String(describing: event.endDate))
                if eventTitle.count == events.count {
                    eventInfo["title"] = eventTitle
                    eventInfo["endTime"] = eventEndTime
                    delegate?.receivedEvents(events: eventInfo)
                }
            }
        }
    }
    
    
}
