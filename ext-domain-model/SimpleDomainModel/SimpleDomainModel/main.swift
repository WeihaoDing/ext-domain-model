//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ from: Money) -> Money
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
  public var amount : Int
  public var currency : String
    
  public enum Currency : String {
    case GBP = "GBP"
    case EUR = "EUR"
    case CAN = "CAN"
    case USD = "USD"
  }
    
  public var description : String {
    return "\(currency)\(amount)"
  }
  
  
  public func convert(_ to: String) -> Money {
    var newAmount = 0
    if to == "USD" {
        if currency == "GBP" {
            newAmount = amount * 2
        } else if currency == "EUR" {
            newAmount = amount * 2/3
        } else if currency == "CAN" {
            newAmount = amount * 4/5
        } else {
            newAmount = amount
        }
    }
    if to == "GBP" {
        if currency == "USD" {
            newAmount = amount / 2
        } else if currency == "EUR" {
            newAmount = amount / 3
        } else if currency == "CAN" {
            newAmount = amount * 2/5
        } else {
            newAmount = amount
        }
    }
    if to == "EUR" {
        if currency == "GBP" {
            newAmount = amount * 3
        } else if currency == "USD" {
            newAmount = amount * 3/2
        } else if currency == "CAN" {
            newAmount = amount * 5/6
        } else {
            newAmount = amount
        }
    }
    if to == "CAN" {
        if currency == "GBP" {
            newAmount = amount * 5/2
        } else if currency == "EUR" {
            newAmount = amount * 6/5
        } else if currency == "USD" {
            newAmount = amount * 5/4
        } else {
            newAmount = amount
        }
    }
    return Money(amount: newAmount, currency: to)
  }
  
  public func add(_ to: Money) -> Money {
    return Money(amount: to.amount + convert(to.currency).amount, currency: to.currency)
  }
  
  public func subtract(_ from: Money) -> Money {
    return Money(amount: from.amount - convert(from.currency).amount, currency: from.currency)
  }
}

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
        
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
  fileprivate var title : String
  fileprivate var type : JobType
    
    
  public var description: String {
    return "\(title)\(type)"
  }

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let hourly):
        return Int(Double(hours) * hourly)
    case .Salary(let money):
        return money
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let hourly):
        type = JobType.Hourly(hourly + amt)
    case .Salary(let money):
        type = JobType.Salary(Int(Double(money) + amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0
    
  public var description: String {
    return "\(firstName)\(lastName)\(age)"
  }

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job }
    set(value) {
        if (age >= 16) {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
        if (age >= 18) {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
  }
}

////////////////////////////////////
// Family
//
open class Family: CustomStringConvertible {
  fileprivate var members : [Person] = []
  
  public var description: String {
    return "\(members)"
  }
  
  public init(spouse1: Person, spouse2: Person) {
    spouse1.spouse = spouse2
    spouse2.spouse = spouse1
    self.members.append(spouse1)
    self.members.append(spouse2)
  }
  
  open func haveChild(_ child: Person) -> Bool {
    child.age = 0
    members.append(child)
    return true
  }
  
  open func householdIncome() -> Int {
    var totalIncome = 0
    for member in members {
        if member._job != nil {
            totalIncome += member._job!.calculateIncome(2000)
        }
    }
    return totalIncome
  }
    
}





