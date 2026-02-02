//
//  MemoryGame2026UITests.swift
//  MemoryGame2026UITests
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-08.
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
        app.buttons["house"].firstMatch.tap()
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
        app.buttons["house"].firstMatch.tap()
    }
    
    @MainActor
    func testToggle() throws {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["gear"]/*[[".otherElements",".buttons[\"Settings\"]",".buttons[\"gear\"]",".buttons"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let toggle = app.switches["SettingsBonusToggle"]
        let defaultValue = toggle.value as! String
        XCTAssertTrue(toggle.waitForExistence(timeout: 1), "Bonus toggle should exist")
        
        for _ in 1...3 {
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
        
        if defaultValue != toggle.value as! String{
            app.switches[toggle.value as! String].firstMatch.tap()
        }
        app.buttons["house"].firstMatch.tap()
    }
    
    @MainActor
    func testImagePicker () throws{
        let images = ["sun.max", "cloud.sun", "cloud.rain"]
        let app = XCUIApplication()
        app.activate()
        
        let gearButton = app.buttons["gear"].firstMatch
        XCTAssertTrue(gearButton.waitForExistence(timeout: 1.0), "Gear button should exist on Home")
        gearButton.tap()
        
        let nextImgButton = app.buttons["NextImage"]
        XCTAssertTrue(nextImgButton.waitForExistence(timeout: 1.0), "Next image button should exist")
        
        let prevImgButton = app.buttons["PrevImage"]
        XCTAssertTrue(prevImgButton.waitForExistence(timeout: 1.0), "Next image button should exist")
        
        let selectedImgage = app.images["targetImage"]
        XCTAssertTrue(selectedImgage.waitForExistence(timeout: 1.0), "Image should show up")
        
        let selectedImgValue = selectedImgage.value as! String
        let currentImageIndex = Int(nextImgButton.value as! String)!
        
        for _ in 0..<4 {
            nextImgButton.tap()
            XCTAssertEqual(selectedImgValue, images[currentImageIndex])
        }
        
        for _ in 0..<4 {
            prevImgButton.tap()
            XCTAssertEqual(selectedImgValue, images[currentImageIndex])
        }
        
        app.buttons["house"].firstMatch.tap()
    }
    
    func testGameViewImageUpdatedByImagePicker() throws {
        let images = ["sun.max", "cloud.sun", "cloud.rain"]
        let app = XCUIApplication()
        app.activate()
        
        let gearButton = app.buttons["gear"].firstMatch
        XCTAssertTrue(gearButton.waitForExistence(timeout: 1.0), "Gear button should exist on Home")
        gearButton.tap()
        
        let nextImgButton = app.buttons["NextImage"]
        let prevImgButton = app.buttons["PrevImage"]
        XCTAssertTrue(nextImgButton.waitForExistence(timeout: 1.0), "Next image button should exist")
        
        let selectedImage = app.images["targetImage"]
        
        XCTAssertTrue(selectedImage.waitForExistence(timeout: 1.0), "Image should show up")
        
        XCTAssertEqual(selectedImage.value as? String, images[0])
        
        let homeButton = app.buttons["house"].firstMatch
        XCTAssertTrue(homeButton.waitForExistence(timeout: 1.0), "Home button should exist in Settings")
        homeButton.tap()
        
        var gameTile = app.buttons.matching(identifier: "GameButton")
        XCTAssertGreaterThan(gameTile.count, 0, "Game tiles should exist")
        
        var gameTileValue = foundValue(query: gameTile, expectedValue: images[0])
        
        XCTAssertEqual(gameTileValue, images[0], "Expected to find a tile with value \(images[0])")
        
        gearButton.tap()
        for _ in 1..<5 {
            nextImgButton.tap()
            XCTAssertEqual(selectedImage.value as? String, images[Int(nextImgButton.value as! String)!],
                           "Picker image should be \(images[Int(nextImgButton.value as! String)!])")
            let imageNameInSettingPage = selectedImage.value as! String
            homeButton.tap()
            
            gameTileValue = foundValue(query: gameTile, expectedValue: imageNameInSettingPage)
            XCTAssertEqual(gameTileValue, imageNameInSettingPage,
                           "GameView image should be \(images[Int(nextImgButton.value as! String)!])")
            
            gearButton.tap()
        }
        
        for _ in 1..<5 {
            prevImgButton.tap()
            XCTAssertEqual(selectedImage.value as? String, images[Int(nextImgButton.value as! String)!],
                           "Picker image should be \(images[Int(nextImgButton.value as! String)!])")
            let imageNameInSettingPage = selectedImage.value as! String
            homeButton.tap()
            
            gameTileValue = foundValue(query: gameTile, expectedValue: imageNameInSettingPage)
            XCTAssertEqual(gameTileValue, imageNameInSettingPage,
                           "GameView image should be \(images[Int(nextImgButton.value as! String)!])")
            
            gearButton.tap()
        }
        
        homeButton.tap()
        gameTileValue = foundValue(query: gameTile, expectedValue: images[0])
        
        XCTAssertEqual(gameTileValue, images[0], "Expected to find a tile with value \(images[0])")
    }
    
    func foundValue(query: XCUIElementQuery,expectedValue: String) -> String? {
        for i in 0..<query.count {
            let element = query.element(boundBy: i)
            if element.value as? String == expectedValue {
                return expectedValue
            }
        }
        return nil
    }
    
    @MainActor
    func testAppStorage ()throws{
        let imagesLengtg = 3
        let app = XCUIApplication()
        app.activate()
        let gearButton = app.buttons["gear"].firstMatch
        XCTAssertTrue(gearButton.waitForExistence(timeout: 1.0), "Gear button should exist on Home")
        gearButton.tap()
        
        //Next Image button functionality
        let nextImgBtn = app.buttons["NextImage"]
        XCTAssertTrue(nextImgBtn.waitForExistence(timeout: 1.0), "Next image button should exist")
        var imgIndex = Int(nextImgBtn.value as! String)!
        
        //Toggle button functionality
        let bonusToggle = app.switches["SettingsBonusToggle"]
        XCTAssertTrue(bonusToggle.waitForExistence(timeout: 1.0), "Toggle button should exist")
        //Store the default value of the Toggle button
        let defaultBounsToggleVal = bonusToggle.value as! String
        var currentBounsToggleVal = defaultBounsToggleVal
        
        //Increment Stepper button functionality
        let incrementStepper = app.buttons["SettingsStepper-Increment"]
        let decrementStepper = app.buttons["SettingsStepper-Decrement"]
        XCTAssertTrue(incrementStepper.waitForExistence(timeout: 1.0), "Toggle button should exist")
        var currentStepperVal = Int(app.staticTexts["SettingsRowsColsText"].value as! String)!
        
        for _ in 1..<2{
            nextImgBtn.tap()
            imgIndex = (imgIndex + 1) % imagesLengtg
            
            app.switches[currentBounsToggleVal].tap()
            currentBounsToggleVal = currentBounsToggleVal == "1" ? "0" : "1"
            
            incrementStepper.tap()
            currentStepperVal = currentStepperVal >= 10 ? currentStepperVal : currentStepperVal + 1
        }
        
        let houseButton = app.buttons["house"].firstMatch
        XCTAssertTrue(houseButton.waitForExistence(timeout: 1.0), "House button should exist on Home")
        houseButton.tap()
        app.terminate()
        
        // Relaunch the app
        app.launch()
        gearButton.tap()
        
        // Check the set values with current values
        XCTAssertEqual(String(imgIndex), nextImgBtn.value as! String)
        XCTAssertEqual(String(currentBounsToggleVal), bonusToggle.value as! String)
        let newStepperVal = Int(app.staticTexts["SettingsRowsColsText"].value as! String)!
        XCTAssertEqual(currentStepperVal, newStepperVal)
        
        // Set the default setting
        defaultSetting(app: app, nextImageButton: nextImgBtn,decrementStepperButton: decrementStepper, currentImageIndexValue: String(imgIndex), currentBonusToggleValue: currentBounsToggleVal, currentStepperValue: currentStepperVal )
    }
    
    private func defaultSetting(
        app: XCUIApplication,
        nextImageButton: XCUIElement,
        decrementStepperButton: XCUIElement,
        currentImageIndexValue: String,
        currentBonusToggleValue: String,
        currentStepperValue: Int
    ) {
        
        let defaultImageIndex = "0"
        let defaultBonusToggleValue = "0"
        let defaultStepperValue: Int = 5
        
        // Reset Image to default if needed
        var imageIndex = currentImageIndexValue
        while imageIndex != defaultImageIndex {
            nextImageButton.tap()
            imageIndex = nextImageButton.value as? String ?? imageIndex
        }
        
        // Reset bonus toggle to default if needed
        if currentBonusToggleValue != defaultBonusToggleValue {
            app.switches[currentBonusToggleValue].firstMatch.tap()
        }
        
        // Decrement stepper until it reaches defaultStepperValue
        var stepperValue = currentStepperValue
        while defaultStepperValue != stepperValue{
            decrementStepperButton.tap()
            stepperValue = Int(app.staticTexts["SettingsRowsColsText"].value as! String)!
        }
        app.buttons["house"].firstMatch.tap()
    }
    
    
}
