//
//  File.swift
//  
//
//  Created by Thomas Lee on 20/03/2021.
//


import Foundation
import XCTest

@testable import FruitRepository


final class FruitFactoryTests: XCTestCase {
    var factory: IFruitFactory!
    
    override func setUp() {
        self.factory = FruitFactory()
    }
    
    func testDictGoodValues() {
        let fruit = factory.createFruit(fromDict:[
            "type":"apple",
            "price":300,
            "weight":100
        ])
        XCTAssertNotNil(fruit)
    }
    
    func testDictBadPrice() {
        var fruit = factory.createFruit(fromDict:[
            "type":"apple",
            "price":"z",
            "weight":"100"
        ])
        XCTAssertNil(fruit)
        
        fruit = factory.createFruit(fromDict:[
            "type":"apple",
            "price":"100kg",
            "weight":"100"
        ])
        XCTAssertNil(fruit)
    }
}
