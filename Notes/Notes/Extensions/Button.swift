//
//  Button.swift
//  Notes
//
//  Created by mac on 27.12.22.
//

import UIKit

extension NotesViewController {
    
    func buttonStack() {
        buttonBold.backgroundColor = #colorLiteral(red: 0.3095400929, green: 0.2906931341, blue: 0.2904594541, alpha: 1)
        buttonBold.layer.cornerRadius = 10
        buttonBold.setImage(UIImage(systemName: "bold"), for: .normal)
        buttonBold.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        
        buttonItalics.backgroundColor = #colorLiteral(red: 0.3095400929, green: 0.2906931341, blue: 0.2904594541, alpha: 1)
        buttonItalics.layer.cornerRadius = 10
        buttonItalics.setImage(UIImage(systemName: "italic"), for: .normal)
        buttonItalics.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        
        buttonColor.backgroundColor = #colorLiteral(red: 0.3095400929, green: 0.2906931341, blue: 0.2904594541, alpha: 1)
        buttonColor.layer.cornerRadius = 10
        buttonColor.setImage(UIImage(systemName: "paintpalette"), for: .normal)
        buttonColor.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)

        [buttonBold, buttonItalics, buttonColor,  buttonStackView   ].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            buttonStackView.widthAnchor.constraint(equalToConstant: 20.0),
            buttonStackView.topAnchor.constraint(equalTo: buttonColorStackView.bottomAnchor, constant: 0),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)])
        
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8.0
        
        buttonStackView.addArrangedSubview(buttonBold)
        buttonStackView.addArrangedSubview(buttonItalics)
        buttonStackView.addArrangedSubview(buttonColor)
    }
    
    func buttonStackColor() {
        buttonColorWhite.backgroundColor = .clear
        buttonColorWhite.layer.cornerRadius = 10
        buttonColorWhite.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorWhite.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        buttonColorBlack.backgroundColor = .clear
        buttonColorBlack.layer.cornerRadius = 10
        buttonColorBlack.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorBlack.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        buttonColorRed.backgroundColor = .clear
        buttonColorRed.layer.cornerRadius = 10
        buttonColorRed.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorRed.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        buttonColorBlue.backgroundColor = .clear
        buttonColorBlue.layer.cornerRadius = 10
        buttonColorBlue.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorBlue.tintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        buttonColorYellow.backgroundColor = .clear
        buttonColorYellow.layer.cornerRadius = 10
        buttonColorYellow.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorYellow.tintColor = #colorLiteral(red: 1, green: 0.9999905229, blue: 0, alpha: 1)
        
        buttonColorPurple.backgroundColor = .clear
        buttonColorPurple.layer.cornerRadius = 10
        buttonColorPurple.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        buttonColorPurple.tintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        
        [buttonColorBlack, buttonColorWhite,buttonColorRed, buttonColorYellow, buttonColorBlue, buttonColorPurple, buttonColorStackView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            buttonColorStackView.widthAnchor.constraint(equalToConstant: 20.0),
            buttonColorStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: -20),
            buttonColorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonColorStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: 0),
            buttonColorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)])
        
        buttonColorStackView.alignment = .fill
        buttonColorStackView.distribution = .fillEqually
        buttonColorStackView.spacing = 8.0
        
        buttonColorStackView.addArrangedSubview(buttonColorBlack)
        buttonColorStackView.addArrangedSubview(buttonColorWhite)
        buttonColorStackView.addArrangedSubview(buttonColorRed)
        buttonColorStackView.addArrangedSubview(buttonColorBlue)
        buttonColorStackView.addArrangedSubview(buttonColorYellow)
        buttonColorStackView.addArrangedSubview(buttonColorPurple)
    }
}
