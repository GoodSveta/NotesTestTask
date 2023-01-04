//
//  NotesViewController.swift
//  Notes
//
//  Created by mac on 21.12.22.
//

import UIKit

class NotesViewController: UIViewController {
    let buttonStackView = UIStackView()
    let buttonColorStackView = UIStackView()
    let label = UILabel()
    let textFieldHeader = UITextField()
    let textField = UITextView()
    let placeholderLabel = UILabel()
    let buttonSave = UIButton(type: .system)
    let buttonBack = UIButton(type: .system)
    let buttonBold = UIButton()
    let buttonItalics = UIButton()
    let buttonColor = UIButton()
    let buttonColorWhite = UIButton()
    let buttonColorBlack = UIButton()
    let buttonColorRed = UIButton()
    let buttonColorBlue = UIButton()
    let buttonColorYellow = UIButton()
    let buttonColorPurple = UIButton()
    var notes: [Note] = []
    var color = UIColor()
    var fontSave = UIFont()
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        buttonColorStackView.isHidden = true
        addViews()
        setupLayout()
        setupStyle()
        setupAction()
        buttonStack()
        buttonStackColor()
        textField.delegate = self
        textFieldView()
    }
    
    func addViews() {
        [label, buttonSave, buttonBack, textFieldHeader, textField, buttonStackView, buttonColorStackView].forEach({ view.addSubview($0) })
    }
    
    func setupLayout() {
        setupLabelLayout()
        setupButtonLayout()
        setupButtonBackLayout()
        setupTextFieldHeaderLayout()
        setupTextFieldLayout()
    }
    
    func setupLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: buttonSave.leadingAnchor, constant: -5),
            label.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: 5),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
    
    func setupButtonLayout() {
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            buttonSave.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            buttonSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonSave.heightAnchor.constraint(equalToConstant: 30),
            buttonSave.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupButtonBackLayout() {
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            buttonBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonBack.heightAnchor.constraint(equalToConstant: 30),
            buttonBack.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupTextFieldHeaderLayout() {
        textFieldHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            textFieldHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textFieldHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textFieldHeader.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        ])
    }
    
    func setupTextFieldLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            textField.leadingAnchor.constraint(equalTo: textFieldHeader.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: textFieldHeader.trailingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: textFieldHeader.bottomAnchor, constant: 15),
            textField.bottomAnchor.constraint(equalTo: buttonColorStackView.topAnchor, constant: 20)
        ])
    }
    
    func textFieldView() {
        textField.textAlignment = NSTextAlignment.justified
        textField.backgroundColor = .darkGray
        textField.layer.cornerRadius = 10
        textField.layer.backgroundColor = .init(gray: 1.0, alpha: 0.5)
        textField.font = UIFont(name: "Thonburi", size: 14)
        fontSave = textField.font ?? .systemFont(ofSize: 14)
        textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        textField.isSelectable = true
        textField.dataDetectorTypes = UIDataDetectorTypes.link
        textField.layer.cornerRadius = 10
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.spellCheckingType = UITextSpellCheckingType.yes
        textField.isEditable = true
        placeholderLabel.text = "Начните ввод..."
        placeholderLabel.font = .italicSystemFont(ofSize: (textField.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y:(textField.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !textField.text.isEmpty
    }
    
    func setupStyle() {
        label.text = "Новая заметка"
        label.textAlignment = .center
        label.font = UIFont(name: "Thonburi ", size: 20.0)
        label.textColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        buttonSave.setImage(UIImage(systemName: "paperclip"), for: .normal)
        buttonBack.setImage(UIImage(systemName: "chevron.backward.2"), for: .normal)
        buttonSave.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        buttonBack.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        textFieldHeader.attributedPlaceholder = NSAttributedString(string: "Заголовок", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textFieldHeader.layer.cornerRadius = 10
    }
    
    //MARK: ACTION
    func setupAction() {
        buttonSave.addTarget(self, action: #selector(buttonSavePressed), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(buttonBackPressed), for: .touchUpInside)
        buttonBold.addTarget(self, action: #selector(buttonPressedBold), for: .touchUpInside)
        buttonItalics.addTarget(self, action: #selector(buttonPressedItalics), for: .touchUpInside)
        buttonColor.addTarget(self, action: #selector(buttonPressedColor), for: .touchUpInside)
        buttonColorBlack.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
        buttonColorWhite.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
        buttonColorYellow.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
        buttonColorPurple.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
        buttonColorBlue.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
        buttonColorRed.addTarget(self, action: #selector(buttonColorSelection), for: .touchUpInside)
    }
    
    @objc func buttonSavePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        date = dateFormatter.string(from: Date.now)
        
        let myColorData = color.encode()
        let myFont = fontSave.encode()
        
        notes.append(Note(header: textFieldHeader.text, note: textField.text, date: date, color: myColorData, font: myFont))
        CoreDataManager.shared.saveNoteInDB(notes: notes)
    }
    
    @objc func buttonBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonPressedBold() {
        if buttonBold.tintColor == #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1) {
            textField.font = .boldSystemFont(ofSize: (textField.font?.pointSize)!)
            buttonBold.tintColor = .lightGray
            fontSave = textField.font ?? .systemFont(ofSize: 14)
        } else {
            textField.font = .systemFont(ofSize: (textField.font?.pointSize)!)
            buttonBold.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
            fontSave = textField.font ?? .systemFont(ofSize: 14)
        }
    }
    
    @objc func buttonPressedItalics() {
        if buttonItalics.tintColor == #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1) {
            textField.font = .italicSystemFont(ofSize: (textField.font?.pointSize)!)
            buttonItalics.tintColor = .lightGray
            fontSave = textField.font ?? .systemFont(ofSize: 14)
        } else {
            textField.font = .systemFont(ofSize: (textField.font?.pointSize)!)
            buttonItalics.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
            fontSave = textField.font ?? .systemFont(ofSize: 14)
        }
    }
    
    @objc func buttonPressedColor() {
        buttonColorStackView.isHidden = false
    }
    
    @objc func buttonColorSelection() {
        if buttonColorBlack.isHighlighted {
            textField.textColor = .black
            color = .black
        } else if buttonColorWhite.isHighlighted {
            textField.textColor = .white
            color = .white
        } else if buttonColorRed.isHighlighted {
            textField.textColor = .red
            color = .red
        } else if buttonColorBlue.isHighlighted {
            textField.textColor = .blue
            color = .blue
        } else if buttonColorYellow.isHighlighted {
            textField.textColor = .yellow
            color = .yellow
        } else if buttonColorPurple.isHighlighted {
            textField.textColor = .purple
            color = .purple
        }
        buttonColorStackView.isHidden = true
    }
}



