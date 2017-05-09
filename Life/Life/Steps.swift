//
//  Steps.swift
//  Life
//
//  Created by Tyler Wilson on 4/13/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import Foundation
import HealthKit

class Steps {
    
    let today = Date()

    
    private func getSteps (){
        if HKHealthStore.isHealthDataAvailable() {
//            let healthStore = HKHealthStore()
//            
//            let predicate = HKQuery.predicateForSamples(withStart: today, end: today, options: .strictStartDate)
//            let steps = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
//            let interval: NSDateComponents = NSDateComponents()
//            interval.day = 1
//            
//            let query = HKStatisticsCollectionQuery(quantityType: steps!, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: today, intervalComponents: interval as DateComponents)
//            
            
        }
    }
    
    
    
}
