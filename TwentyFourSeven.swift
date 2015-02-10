//
//  TwentyFourSeven.swift
//
//  Created by Dominik Heier on 09/02/15.
//  Copyright (c) 2015 Dominik Heier. All rights reserved.
//

private let _sharedInstance = TwentyFourSeven()

@objc public class TwentyFourSeven : NSObject {

  // Singleton via global constant
  public class var sharedInstance : TwentyFourSeven {
    return _sharedInstance
  }
  
  let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
  
  var dayOfTheWeek : Int {
    return calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: NSDate()).weekday
  }
  
  var hourOfTheDay : Int {
    return calendar.components(NSCalendarUnit.HourCalendarUnit, fromDate: NSDate()).hour
  }
  

  var shouldBeOpen : Bool {
    
    // Fetch default values from settings bundle
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let weekdayOpeningHour = defaults.integerForKey("weekdayOpeningHour")
    let weekdayClosingHour = defaults.integerForKey("weekdayClosingHour")
    let saturdayOpeningHour = defaults.integerForKey("saturdayOpeningHour")
    let saturdayClosingHour = defaults.integerForKey("saturdayClosingHour")
    
    /* TODO: Do the right thing when closing hours and to opening hour are the same */
    
    // Weekday units are the numbers 1 through n, where n is the number of days in the week.
    // In the Gregorian calendar, n is 7 and Sunday is represented by 1.

    switch dayOfTheWeek {
    case (2...6): // Monday to Friday
      let shouldInvertResult = ( weekdayClosingHour < weekdayOpeningHour ) ? true : false
      return ( hourOfTheDay >= weekdayClosingHour || hourOfTheDay <= weekdayOpeningHour ) ? shouldInvertResult : !shouldInvertResult
    case 7:       // Saturay
      let shouldInvertResult = ( saturdayClosingHour < saturdayOpeningHour ) ? true : false
      return ( hourOfTheDay >= saturdayClosingHour || hourOfTheDay <= saturdayOpeningHour ) ? shouldInvertResult : !shouldInvertResult
    case 1:       // Sunday
      return true
    default:
      fatalError("There should not be an eighth weekday!")
    }
  }
  
  
  override init() {
    super.init()
    
    // Code block to be called in a loop
    var completionHandler:(NSTimer!)->Void = {timer in
      UIApplication.sharedApplication().idleTimerDisabled = self.shouldBeOpen
      
      // DEBUG
      println("Checking opening hours... Weekday is \(self.dayOfTheWeek), Hour is \(self.hourOfTheDay) => Setting idleTimerDisabled to \"\(self.shouldBeOpen)\"")

    }
    
    // Set up loop
    let interval = NSTimeInterval(10) // Every 10 seconds
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), interval, 0, 0, completionHandler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
  }

}

