//
//  ExampleFormHelper.swift
//  RSFormViewExample
//
//  Created by Germán Stábile on 6/10/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import RSFormView

class ExampleFormHelper: FormViewModel {
  
  var items: [FormItem] = []
  
  lazy var nameItem: FormItem = {
    let firstNameField = FormField(name: "FIRST NAME",
                                   initialValue: "",
                                   placeholder: "FIRST NAME",
                                   fieldType: .regular,
                                   isValid: false,
                                   errorMessage: "First name can't be empty")
    let lastNameField = FormField(name: "LAST NAME",
                                  initialValue: "",
                                  placeholder: "LAST NAME",
                                  fieldType: .regular,
                                  isValid: false,
                                  errorMessage: "Last name can't be empty")
    
    return TwoTextFieldCellItem(firstField: firstNameField, secondField: lastNameField)
  }()
  
  lazy var emailItem: FormItem = {
    let emailField = FormField(name: "EMAIL",
                               initialValue: "",
                               placeholder: "EMAIL",
                               fieldType: .email,
                               isValid: false,
                               errorMessage: "Please enter a valid email")
    emailField.capitalizeValue = false
    
    return TextFieldCellItem(with: emailField)
  }()
  
  lazy var phoneNumberItem: FormItem = {
    let phoneField = FormField(name: "PHONE NUMBER",
                               initialValue: "",
                               placeholder: "PHONE NUMBER",
                               fieldType: .usPhone,
                               isValid: false,
                               errorMessage: "Please enter a valid US phone number")
    
    return TextFieldCellItem(with: phoneField)
  }()
  
  lazy var personalInfoHeaderItem: FormItem = {
    let headerItem = TextCellItem()
    headerItem.attributedText = personalInfoAttributedString(isDarkMode: false)
    return headerItem
  }()
  
  lazy var otherInfoHeaderItem: FormItem = {
    let headerItem = TextCellItem()
    headerItem.attributedText = otherInfoAttributedString(isDarkMode: false)
    return headerItem
  }()
  
  lazy var programmingLanguageItem: FormItem = {
    let languageField = FormField(name: "FAVORITE LANGUAGE",
                                  initialValue: "",
                                  placeholder: "SELECT YOUR FAVORITE LANGUAGE",
                                  fieldType: .picker,
                                  isValid: false,
                                  errorMessage: "Favorite language can't be empty")
    languageField.options = ["Swift", "Objective-C", "I don't code native iOS (booo)"]
    
    return TextFieldCellItem(with: languageField)
  }()
  
  lazy var bedToDeskDistance: FormItem = {
    let distanceField = FormField(name: "BED TO DESK DISTANCE (m)",
                                  initialValue: "",
                                  placeholder: "BED TO DESK DISTANCE",
                                  fieldType: .double(maxDecimalPlaces: 2),
                                  isValid: false,
                                  errorMessage: "Bed to desk distance can't be blank")
    
    return TextFieldCellItem(with: distanceField)
  }()
  
  init() {
   loadItems()
  }
  
  func loadItems() {
    items = [personalInfoHeaderItem, nameItem, emailItem,
             phoneNumberItem, otherInfoHeaderItem, programmingLanguageItem, bedToDeskDistance]
  }
  
  func updateHeaders(isDarkMode: Bool) {
    otherInfoHeaderItem.attributedText = otherInfoAttributedString(isDarkMode: isDarkMode)
    personalInfoHeaderItem.attributedText = personalInfoAttributedString(isDarkMode: isDarkMode)
  }
  
  func otherInfoAttributedString(isDarkMode: Bool) -> NSAttributedString {
    return NSAttributedString(string: "Enter other relevant info",
                              attributes: attributes(isDarkMode: isDarkMode))
  }
  
  func personalInfoAttributedString(isDarkMode: Bool) -> NSAttributedString {
    return NSAttributedString(string: "Enter your personal info",
                              attributes: attributes(isDarkMode: isDarkMode))
  }
  
  func attributes(isDarkMode: Bool) -> [NSAttributedString.Key: Any]{
    return [.foregroundColor: isDarkMode ? UIColor.white : UIColor.brightGray,
            .font: UIFont.systemFont(ofSize: 20)]
  }
}
