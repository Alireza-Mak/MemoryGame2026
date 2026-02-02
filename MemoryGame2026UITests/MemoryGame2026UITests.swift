//
//  MemoryGame2026UITests.swift
//  MemoryGame2026UITests
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-08.
//

import XCTest

/// UI tests for MemoryGame2026.
///
/// This suite validates Settings interactions (stepper, toggle, image picker),
/// persistence via AppStorage, and that Settings are reflected in the Game view.
/// Tests use `@MainActor` where UI synchronization is required.
final class MemoryGame2026UITests: XCTestCase {
    
    /// Prepares the UI test environment before each test.
    /// Stops on first failure and establishes a clean initial state.
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    /// Cleans up after each test method.
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Verifies the Settings rows/cols stepper can be incremented and then decremented
    /// a fixed number of times without exceeding limits, and returns to Home safely.
    ///
    /// Steps:
    /// 1. Open Settings from Home (gear button).
    /// 2. Tap the increment button a fixed number of times.
    /// 3. Tap the decrement button the same number of times.
    /// 4. Navigate back to Home (house button).
    ///
    /// This smoke test ensures the basic tap targets exist and respond, without
    /// asserting label values (covered more thoroughly in `testRowsColsStepperV2`).
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
    
    /// Validates the rows/cols stepper label updates within min/max bounds
    /// for a series of increments and decrements.
    /// Asserts the label value reflects clamping at the configured limits.
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
    
    /// Ensures the bonus toggle in Settings flips between on/off states reliably
    /// and can be restored to its initial state.
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
    
    /// Confirms that next/previous image controls cycle through the available images
    /// and that the selected image value corresponds to the picker index.
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
    
    /// Verifies that changing the selected image in Settings updates the Game view tiles
    /// to use the same image value.
    func testGameViewImageUpdatedByImagePicker() throws {
        let images = ["sun.max", "cloud.sun", "cloud.rain"]
        
        //Open the app
        let app = XCUIApplication()
        app.activate()
        
        //Navigate tp Setting View
        let gearButton = app.buttons["gear"].firstMatch
        XCTAssertTrue(gearButton.waitForExistence(timeout: 1.0), "Gear button should exist on Home")
        gearButton.tap()
        
        
        let nextImgButton = app.buttons["NextImage"]
        let prevImgButton = app.buttons["PrevImage"]
        XCTAssertTrue(nextImgButton.waitForExistence(timeout: 1.0), "Next image button should exist")
        
        let selectedImage = app.images["targetImage"]
        
        XCTAssertTrue(selectedImage.waitForExistence(timeout: 1.0), "Image should show up")
        
        XCTAssertEqual(selectedImage.value as? String, images[0])
        
        //Navigate tp Game View
        let homeButton = app.buttons["house"].firstMatch
        XCTAssertTrue(homeButton.waitForExistence(timeout: 1.0), "Home button should exist in Settings")
        homeButton.tap()
        
        // Check if the image in Game View as same as the selected image in Setting View
        let gameTile = app.buttons.matching(identifier: "GameButton")
        XCTAssertGreaterThan(gameTile.count, 0, "Game tiles should exist")
        var (gameTileValue, _) = foundValue(query: gameTile, expectedValue: images[0])
        XCTAssertEqual(gameTileValue, images[0], "Expected to find a tile with value \(images[0])")
        
        gearButton.tap()
        for _ in 1..<5 {
            nextImgButton.tap()
            XCTAssertEqual(selectedImage.value as? String, images[Int(nextImgButton.value as! String)!],
                           "Picker image should be \(images[Int(nextImgButton.value as! String)!])")
            let imageNameInSettingPage = selectedImage.value as! String
            
            //Navigate to Game View
            homeButton.tap()
            
            // Check if the image in Game View as same as the selected image in Setting View
            (gameTileValue, _) = foundValue(query: gameTile, expectedValue: imageNameInSettingPage)
            XCTAssertEqual(gameTileValue, imageNameInSettingPage,
                           "GameView image should be \(images[Int(nextImgButton.value as! String)!])")
            
            //Navigate to Setting View
            gearButton.tap()
        }
        
        for _ in 1..<5 {
            prevImgButton.tap()
            XCTAssertEqual(selectedImage.value as? String, images[Int(nextImgButton.value as! String)!],
                           "Picker image should be \(images[Int(nextImgButton.value as! String)!])")
            let imageNameInSettingPage = selectedImage.value as! String
            
            //Navigate to Game View
            homeButton.tap()
            
            // Check if the image in Game View as same as the selected image in Setting View
            (gameTileValue, _) = foundValue(query: gameTile, expectedValue: imageNameInSettingPage)
            XCTAssertEqual(gameTileValue, imageNameInSettingPage,
                           "GameView image should be \(images[Int(nextImgButton.value as! String)!])")
            
            //Navigate to Setting View
            gearButton.tap()
        }
        
        homeButton.tap()
        
        (gameTileValue, _) = foundValue(query: gameTile, expectedValue: images[0])
        XCTAssertEqual(gameTileValue, images[0], "Expected to find a tile with value \(images[0])")
    }
    
    /// Counts elements within a query whose accessibility value equals `expectedValue`.
    /// - Parameters:
    ///   - query: The query of elements to inspect.
    ///   - expectedValue: The target accessibility value to match.
    /// - Returns: A tuple containing the matched value (if found) and the number of matches.
    func foundValue(query: XCUIElementQuery,expectedValue: String) -> (String, Int) {
        var numberOfMatches: Int = 0
        var foundValue: String = ""
        for i in 0..<query.count {
            let element = query.element(boundBy: i)
            if element.value as! String == expectedValue {
                foundValue = expectedValue
                numberOfMatches += 1
            }
        }
        return (foundValue, numberOfMatches)
    }
    
    /// Validates that Settings (image index, bonus toggle, stepper) persist across app relaunch
    /// using AppStorage by setting values, terminating, relaunching, and asserting restoration.
    @MainActor
    func testAppStorage ()throws{
        let imagesLengtg = 3
        
        //Open the App
        let app = XCUIApplication()
        app.activate()
        
        //Navigate tp Setting View
        let gearButton = app.buttons["gear"].firstMatch
        XCTAssertTrue(gearButton.waitForExistence(timeout: 1.0), "Gear button should exist on Home")
        gearButton.tap()
        
        //Store the index of current Image
        let nextImgBtn = app.buttons["NextImage"]
        XCTAssertTrue(nextImgBtn.waitForExistence(timeout: 1.0), "Next image button should exist")
        var imgIndex = Int(nextImgBtn.value as! String)!
        
        //Store the default and current value of bonus toggle
        let bonusToggle = app.switches["SettingsBonusToggle"]
        XCTAssertTrue(bonusToggle.waitForExistence(timeout: 1.0), "Toggle button should exist")

        let defaultBounsToggleVal = bonusToggle.value as! String
        var currentBounsToggleVal = defaultBounsToggleVal
        
        //Get the current value of stepper
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
        
        //Navigate tp Game View
        let houseButton = app.buttons["house"].firstMatch
        XCTAssertTrue(houseButton.waitForExistence(timeout: 1.0), "House button should exist on Home")
        houseButton.tap()
        
        //Terminate the app
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
    
    /// Resets Settings to known defaults (image index, bonus toggle, stepper)
    /// to keep tests isolated and repeatable.
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
    
    /// End-to-end validation that Settings selections (image, bonus, rows/cols)
    /// are correctly applied in the Game view: total tiles, treasure distribution,
    /// and bonus count.
    @MainActor
    func testSettingsReflectedInGameView() throws {
        let images = ["sun.max", "cloud.sun", "cloud.rain"]
        
        //Open the app
        let app = XCUIApplication()
        app.activate()
        
        // Go to Setting Page
        let gearButton = app.buttons["gear"].firstMatch
        gearButton.tap()
        
        //Select treasure in Setting page
        let nextImgBtn = app.buttons["NextImage"]
        nextImgBtn.tap()
        let currentImageIndex = Int(nextImgBtn.value as! String)!
        let expectedTreasure = images[currentImageIndex]
        
        //Make bonus availabe for the game in Setting page
        let bonusToggle = app.switches["SettingsBonusToggle"]
        let defaultBonusValue = bonusToggle.value as! String
        app.switches[defaultBonusValue].tap()
        let currentBonusValue = bonusToggle.value as! String
        let expectedNumberOfBonus = Int(currentBonusValue)!
        
        //Set Row and tile for game in Setting page
        let incrementStepper = app.buttons["SettingsStepper-Increment"]
        let decrementStepper = app.buttons["SettingsStepper-Decrement"]
        incrementStepper.tap()
        let currentStepperVal = Int(app.staticTexts["SettingsRowsColsText"].value as! String)!
        let expectedNumberOfTiles = currentStepperVal * currentStepperVal
        let expectedNumberOfTreasures = Int((Double(expectedNumberOfTiles) * 0.25).rounded())
        
        // Go to Game Page
        let houseButton = app.buttons["house"].firstMatch
        houseButton.tap()
        
        // Check number of tiles in Game page
        let tileButtonContianer = app.buttons.matching(identifier: "GameButton")
        let numberOfTiles = tileButtonContianer.count
        XCTAssertTrue(tileButtonContianer.firstMatch.waitForExistence(timeout: 1.0), "At least there is One tile button should exist on Home")
        XCTAssertEqual(numberOfTiles, expectedNumberOfTiles)
        
        //Check the value of treasure
        let (gameTreasureValue, numberOfTreasures) = foundValue(query: tileButtonContianer, expectedValue: expectedTreasure)
        XCTAssertEqual(gameTreasureValue, expectedTreasure, "Expected to find a tile with value \(expectedTreasure)")
        
        //Check number of treasure
        XCTAssertEqual(numberOfTreasures, expectedNumberOfTreasures, "Expected to find treasuers a tile with value \(expectedNumberOfTreasures)")
        
        //Check number of bonus
        let expectedBonusSymbol = "bitcoinsign.circle"
        let (gameBonusValue, numberOfBonuses) = foundValue(query: tileButtonContianer, expectedValue: expectedBonusSymbol)
        XCTAssertEqual(gameBonusValue, expectedBonusSymbol, "Expected to find a tile with value \(expectedBonusSymbol)")
        XCTAssertEqual(numberOfBonuses, expectedNumberOfBonus, "Expected to find \(expectedNumberOfBonus) bonus a tile.")
        
        // Set the default setting
        gearButton.tap()
        defaultSetting(app: app, nextImageButton: nextImgBtn,decrementStepperButton: decrementStepper, currentImageIndexValue: String(currentImageIndex), currentBonusToggleValue: currentBonusValue, currentStepperValue: currentStepperVal )
    }
}
