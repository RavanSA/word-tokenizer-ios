//
//  ViewController.swift
//  testproject
//
//  Created by Revan Sadigli on 7.01.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var dropdownTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Langauge"
        textField.borderStyle = .roundedRect
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar

        return textField
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text here"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private var segmentedStrings: [String] = []
    private var dropdownOptions: [String : SupportedLanguages] = ["English": .english, "Spanish" : .spanish, "Turkish" : .turkish]
    private var selectedLanguage: SupportedLanguages = .english
    private let tokenizer = Tokenizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dropdownTextField)
        view.addSubview(textField)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        dropdownTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dropdownTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dropdownTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dropdownTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: dropdownTextField.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
               
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = segmentedStrings[indexPath.row].capitalizedFirstLetter()
        
        return cell
    }
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let languageNames = Array(dropdownOptions.keys)
        
        let languageName = languageNames[row]
        return languageName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let languageNames = Array(dropdownOptions.keys)
        
        let selectedLanguageName = languageNames[row]
        
        if let selectedLanguage = dropdownOptions[selectedLanguageName] {
            self.selectedLanguage = selectedLanguage
        }
        
        dropdownTextField.text = selectedLanguageName
    }
    
    @objc func donePicker() {
        dropdownTextField.resignFirstResponder()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            segmentedStrings = tokenizer.tokenizeSentence(text, language: selectedLanguage)
            self.tableView.reloadData()
        }
        
        return true
    }
    
}
