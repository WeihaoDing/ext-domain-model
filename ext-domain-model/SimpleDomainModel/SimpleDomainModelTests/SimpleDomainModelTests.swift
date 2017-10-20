//
//  SimpleDomainModelTests.swift
//  SimpleDomainModelTests
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class ExtDomainModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCustomStringConvertible() {
        let tenUSD = Money(amount: 30, currency:"USD")
        XCTAssert(tenUSD.description == "USD30")
        
        let job = Job(title: "Doctor", type: Job.JobType.Salary(1200))
        XCTAssert(job.description == "Doctor, Salary(1200)")
        let job2 = Job(title: "Doctor", type: Job.JobType.Hourly(1200))
        XCTAssert(job2.description == "Doctor, Hourly(1200.0)")
        
        let Sophie = Person(firstName: "Sophie", lastName: "Ding", age: 21)
        XCTAssert(max.description == "[Person: firstName:Sophie lastName:Ding age:21 job:nil spouse:nil]")
        
        let mary = Person(firstName: "mary", lastName: "Ding", age: 17)
        let family = Family(spouse1: Sophie, spouse2: mary)
        print(family.description)
        XCTAssert(family.description == "[Person: firstName:Sophie lastName:Ding age:21 job:nil  spouse:Mary Ding] [Person: firstName:Mary lastName:Ding age:17 job:nil spouse:Sophie Ding] ")
    }
    
    func testMathematics() {
        let money1 = Money(amount: 220, currency:"USD")
        let money2 = Money(amount: 1, currency:"USD")
        let test1 = money1.add(money2)
        XCTAssert(test1.amount == 221 && test1.currency == "USD")
        
        let test2 = money1.subtract(money2)
        XCTAssert(test2.amount == 219 && test2.currency == "USD")
    }
    
    func testExtention() {
        XCTAssert(50.USD.amount == 50)
        XCTAssert(50.USD.description == "USD50")
        XCTAssert(55.EUR.amount == 55 && 55.EUR.currency == "EUR")
    }
}

