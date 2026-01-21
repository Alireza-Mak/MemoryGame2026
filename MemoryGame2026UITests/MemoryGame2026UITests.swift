//
//  MemoryGame2026UITests.swift
//  MemoryGame2026UITests
//
//  Created by  on 2026-01-08.
//

import XCTest

final class MemoryGame2026UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    */
    
    @MainActor
    func testRowsColsStepper() throws {
        let numberOfTap: Int = 7
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let plusButton = app/*@START_MENU_TOKEN@*/.buttons["SettingsStepper-Increment"]/*[[".steppers[\"6 Rows\/Cols\"].buttons",".steppers",".buttons[\"6 Rows\/Cols, Increment\"]",".buttons[\"SettingsStepper-Increment\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        for _ in 1...numberOfTap {
            plusButton.tap()
        }
        
        let minusButton = app.buttons["SettingsStepper-Decrement"].firstMatch
        for _ in 1...numberOfTap {
            minusButton.tap()
        }
    }
    
    @MainActor
    func testRowsColsStepperV2() throws {
        let numberOfTap: Int = 7
        let minValue = 5
        let maxValue = 10
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let plusButton = app/*@START_MENU_TOKEN@*/.buttons["SettingsStepper-Increment"]/*[[".steppers[\"6 Rows\/Cols\"].buttons",".steppers",".buttons[\"6 Rows\/Cols, Increment\"]",".buttons[\"SettingsStepper-Increment\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        for i in 1...numberOfTap {
            let textRef = app/*@START_MENU_TOKEN@*/.staticTexts["SettingsRowsColsText"]/*[[".otherElements",".staticTexts[\"5 Rows\/Cols\"]",".staticTexts[\"SettingsRowsColsText\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
            plusButton.tap()
            if i + minValue <= maxValue{
                XCTAssertTrue(textRef.waitForExistence(timeout: 1), "Expected '\(i + minValue) Rows/Cols' label."
                )
                XCTAssertEqual(textRef.label,"\(i + minValue) Rows/Cols")
            }else{
                XCTAssertTrue(textRef.waitForExistence(timeout: 1), "Expected '(\(maxValue)) Rows/Cols' label."
                )
                XCTAssertEqual(textRef.label,"\(maxValue) Rows/Cols")
            }
        }
        
            
        let minusButton = app.buttons["SettingsStepper-Decrement"].firstMatch
        for i in 1...numberOfTap {
            let textRef = app/*@START_MENU_TOKEN@*/.staticTexts["SettingsRowsColsText"]/*[[".otherElements",".staticTexts[\"5 Rows\/Cols\"]",".staticTexts[\"SettingsRowsColsText\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
            minusButton.tap()
            if maxValue - i > minValue {
                XCTAssertTrue(textRef.waitForExistence(timeout: 1), "Expected '\(maxValue - i) Rows/Cols' label."
                )
                XCTAssertEqual(textRef.label,"\(maxValue - i) Rows/Cols")
            }else{

                XCTAssertTrue(textRef.waitForExistence(timeout: 1), "Expected '(\(minValue)) Rows/Cols' label."
                )
                XCTAssertEqual(textRef.label,"\(minValue) Rows/Cols")
            }
        }
    }
    
    @MainActor
    func testToggle() throws {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()

        let toggle = app.switches["SettingsBonusToggle"]
        XCTAssertTrue(toggle.waitForExistence(timeout: 1), "Bonus toggle should exist")
       
        for _ in 1...5 {
            let initialValue = toggle.value as! String
            if initialValue == "1" {
                XCTAssertEqual(initialValue, "1")
                
                app.switches[initialValue].firstMatch.tap()
                let secondValue = toggle.value as! String
                XCTAssertEqual(secondValue, "0")
            }
            else{
                XCTAssertEqual(initialValue, "0")
                
                app.switches[initialValue].firstMatch.tap()
                let secondValue = toggle.value as! String
                XCTAssertEqual(secondValue, "1")
            }
        }
    }
    @MainActor
    func testImagePicker () throws{
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
      
        let images: [String] = ["sun.max", "cloud.sun", "cloud.rain"]
        let next = app.buttons["NextImage"]
        let prev = app.buttons["PrevImage"]

        var initialImage = app.images["targetImage"].value as! String
        
            for _ in 0..<images.count {
            next.tap()
        }
        var finalImage = app.images["targetImage"].value as! String
        XCTAssertEqual(initialImage, finalImage)
        
        initialImage = app.images["targetImage"].value as! String
        for _ in 0..<images.count {
            prev.tap()
        }
        
        finalImage = app.images["targetImage"].value as! String
        XCTAssertEqual(initialImage, finalImage)
    }
    
    func testGameViewImageUpdatedByImagePicker() throws {
            let images = ["sun.max", "cloud.sun", "cloud.rain"]
        
            let app = XCUIApplication()
            app.activate()

        
            app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        

            let nextButton = app.buttons["NextImage"]
            let pickerImage = app.images["targetImage"]
            XCTAssertEqual(pickerImage.value as? String, images[0])
        
            app.buttons["house"].firstMatch.tap()
            var gameImage = app.images["GameImage"]
            XCTAssertEqual(gameImage.value as? String, images[0])

            app.buttons["gear"].firstMatch.tap()
            for i in 1..<images.count {
                nextButton.tap()
                XCTAssertEqual(pickerImage.value as? String, images[i],
                               "Picker image should be \(images[i])")
                
                app.buttons["house"].firstMatch.tap()
                gameImage = app.images["GameImage"]
                XCTAssertEqual(gameImage.value as? String, images[i],
                               "GameView image should be \(images[i])")
                
                app.buttons["gear"].firstMatch.tap()
            }

            nextButton.tap()
            XCTAssertEqual(pickerImage.value as? String, images[0])
        
            app.buttons["house"].firstMatch.tap()
            gameImage = app.images["GameImage"]
            XCTAssertTrue(gameImage.waitForExistence(timeout: 1.0))
            XCTAssertEqual(gameImage.value as? String, images[0])
        }
    
    
    @MainActor
    func testAppStorage ()throws{
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let next = app.buttons["NextImage"]
        next.tap()
        next.tap()
        
        let bonusToggle = app.switches["BonusToggle"].firstMatch.tap()
        
        let stepper = app.steppers["StepStepper"]
        stepper.buttons["Increment"].tap()
        stepper.buttons["Increment"].tap()
    }
    
}
