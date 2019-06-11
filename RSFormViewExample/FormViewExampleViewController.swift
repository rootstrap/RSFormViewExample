//
//  ViewController.swift
//  RSFormViewExample
//
//  Created by Germán Stábile on 6/10/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import UIKit
import RSFormView

class FormViewExampleViewController: UIViewController {
  //MARK: Models
  var formHelper = ExampleFormHelper()
  
  //MARK: UIComponents
  var formView = FormView()
  var submitButton = UIButton(type: .custom)
  var descriptionLabel = UILabel()
  var switchLabel = UILabel()
  var modeSwitch = UISwitch()

  //MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
  }

  //MARK: UI Configuration
  func configureViews() {
    view.backgroundColor = UIColor.white
    configureFormView()
    configureLabels()
    configureSubmitButton()
    configureSwitch()
    configureConstraints()
  }
  
  func configureFormView() {
    formView.delegate = self
    formView.viewModel = formHelper
    formView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(formView)
  }
  
  func configureSubmitButton() {
    updateSubmitButton(enabled: false)
    submitButton.layer.cornerRadius = 8
    submitButton.setTitle("SUBMIT", for: .normal)
    submitButton.setTitleColor(UIColor.white, for: .normal)
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    
    view.addSubview(submitButton)
  }
  
  func configureLabels() {
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textColor = UIColor.brightGray
    descriptionLabel.textAlignment = .center
    descriptionLabel.text = "This is an example of a RSFormView changing its aspect on an user triggered event"
    descriptionLabel.font = UIFont.systemFont(ofSize: 22,
                                              weight: .semibold)
    
    view.addSubview(descriptionLabel)
    
    switchLabel.textColor = UIColor.brightGray
    switchLabel.textAlignment = .left
    switchLabel.translatesAutoresizingMaskIntoConstraints = false
    switchLabel.text = "Enable dark mode"
    switchLabel.font = UIFont.systemFont(ofSize: 19)
    
    view.addSubview(switchLabel)
  }
  
  func configureSwitch() {
    modeSwitch.isOn = false
    modeSwitch.onTintColor = UIColor.dodgerBlue
    modeSwitch.translatesAutoresizingMaskIntoConstraints = false
    modeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
    view.addSubview(modeSwitch)
  }
  
  func configureConstraints() {
    let horizontalMargins: CGFloat = 32
    let verticalMargins: CGFloat = 10
    let submitButtonMargins: CGFloat = 24
    
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalMargins * 3),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins),
      descriptionLabel.bottomAnchor.constraint(equalTo: switchLabel.topAnchor, constant: -verticalMargins * 4),
      
      switchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
      switchLabel.trailingAnchor.constraint(equalTo: modeSwitch.leadingAnchor, constant: horizontalMargins),
      switchLabel.bottomAnchor.constraint(equalTo: formView.topAnchor, constant: -verticalMargins),
      
      modeSwitch.widthAnchor.constraint(equalToConstant: 49),
      modeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins),
      modeSwitch.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor),
      
      formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      formView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -verticalMargins),
      
      submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: submitButtonMargins),
      submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -submitButtonMargins),
      submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -submitButtonMargins),
      submitButton.heightAnchor.constraint(equalToConstant: 44)
      ])
  }
  
  func updateSubmitButton(enabled: Bool) {
    let backgroundColor = enabled ?
      UIColor.dodgerBlue : UIColor.brightGray.withAlphaComponent(0.4)
    submitButton.backgroundColor = backgroundColor
    submitButton.isUserInteractionEnabled = enabled
  }
  
  //MASK: Actions
  @objc
  func switchValueChanged(sender: UISwitch) {
    let isDarkMode = sender.isOn
    let configurator = isDarkMode ? DarkModeConfigurator() : FormConfigurator()
    formHelper.updateHeaders(isDarkMode: isDarkMode)
    formView.formConfigurator = configurator
    view.backgroundColor = isDarkMode ? UIColor.mineShaftGray : UIColor.white
    descriptionLabel.textColor = isDarkMode ? UIColor.white : UIColor.brightGray
    switchLabel.textColor = isDarkMode ? UIColor.white : UIColor.brightGray
  }
  
  @objc
  func submitButtonTapped() {
    var collectedData = ""
    for field in formHelper.fields() {
      collectedData += "\(field.name): \(field.value) \n"
    }
    let alert = UIAlertController(title: "Collected data",
                                  message: collectedData,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK",
                                  style: .cancel))
    present(alert, animated: true)
  }
}

extension FormViewExampleViewController: FormViewDelegate {
  func didUpdateFields(in formView: FormView, allFieldsValid: Bool) {
    updateSubmitButton(enabled: allFieldsValid)
  }
}

