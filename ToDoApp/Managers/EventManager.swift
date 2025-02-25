//
//  EventManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 15/12/2024.
//

import Foundation
import EventKit

final class EventManager {
    
    private let eventStore: EKEventStore = EKEventStore()
    //private let reminder: EKReminder
    private var isEventsAccessGranted: Bool?
    private var isRemindersAccessGranted: Bool?
    
    init () {
        //reminder = EKReminder(eventStore: eventStore)
    }
    
    func requestAccessToCalendar() async {
        do {
            try await isEventsAccessGranted = eventStore.requestFullAccessToEvents()
        } catch {
            isEventsAccessGranted = false
        }
    }
    
    func requestAccessToReminder() async {
        do {
            try await isRemindersAccessGranted = eventStore.requestFullAccessToReminders()
        } catch {}
    }
    
    func removeFromCalendar(_ eventId: String) {
        if let eventToDelete = eventStore.event(withIdentifier: eventId) {
            do {
                try eventStore.remove(eventToDelete, span: .thisEvent)
            } catch {}
        }
    }
    
    func removeFromReminder(_ reminderId: String) {
        if let reminderToDelete = eventStore.calendarItem(withIdentifier: reminderId) {
            do {
                try eventStore.remove(reminderToDelete as! EKReminder, commit: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addToReminder(_ toDo: ToDo) async throws -> String {
        
        if isRemindersAccessGranted == nil {
            await requestAccessToReminder()
        }
        
        if isRemindersAccessGranted != nil && isRemindersAccessGranted == true {
            let reminder = EKReminder(eventStore: eventStore)
            reminder.title = toDo.title
            reminder.notes = toDo.description_
            reminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date(timeIntervalSince1970: toDo.dueDate ?? 0))
            reminder.addAlarm(EKAlarm(relativeOffset: -900))
            reminder.calendar = eventStore.defaultCalendarForNewReminders()
            
            do {
                try eventStore.save(reminder, commit: true)
                let reminderId = reminder.calendarItemIdentifier
                return reminderId
            } catch {
                return ""
            }
        } else {
            return ""
        }
    }
    
    func addToCalendar(_ toDo: ToDo) async throws -> String {
        
        if isEventsAccessGranted == nil {
            await requestAccessToCalendar()
        }
        
        if isEventsAccessGranted != nil && isEventsAccessGranted == true {
            let event = EKEvent(eventStore: eventStore)
            event.title = toDo.title
            event.notes = toDo.description_
            event.startDate = Date(timeIntervalSince1970: toDo.dueDate ?? 0)
            event.endDate = event.startDate.addingTimeInterval(7200)
            event.addAlarm(EKAlarm(relativeOffset: -900))
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do {
                try eventStore.save(event, span: .thisEvent)
                let eventId = event.eventIdentifier ?? ""
                return eventId
            } catch {
                //
                return ""
            }
        } else {
            //
            return ""
        }
    }
}
