//
//  AllNotesViewController.swift
//  Notes
//
//  Created by mac on 21.12.22.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    let labelNotes = UILabel()
    let button = UIButton(type: .system)
    var tableView = UITableView()
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupLayout()
        setupStyle()
        setupTableView()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        getData()
    }
    
    func addViews() {
        [tableView, labelNotes, button].forEach({ view.addSubview($0) })
    }
    
    func setupLayout() {
        setupLabelNotesLayout()
        setupTableViewLayout()
        setupButtonLayout()
        setupStyle()
    }
    
    func setupStyle() {
        labelNotes.text = "Заметки"
        labelNotes.numberOfLines = 0
        labelNotes.textAlignment = .center
        labelNotes.font = UIFont(name: "Thonburi ", size: 20.0)
        labelNotes.textColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 0.9113550782, blue: 0, alpha: 1)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        tableView.backgroundColor = .clear
    }
    
    func setupLabelNotesLayout() {
        labelNotes.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            labelNotes.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            labelNotes.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: labelNotes.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ])
    }
    
    func setupButtonLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        ])
    }
    
    private func getData() {
        notes.removeAll()
        let notesDB = CoreDataManager.shared.getFromDB()
        notes.append(contentsOf: notesDB)
        tableView.reloadData()
    }
    
    func setupAction() {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed() {
        guard let vc = NotesViewController.getInstanceViewController as? NotesViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllNotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

extension AllNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell") as? NotesTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.getNoteDB(with: notes[indexPath.row])
        cell.clickDeleteRow = { [weak self] in
            self?.getData() }
        
        guard let vc = NotesViewController.getInstanceViewController as? NotesViewController else { return UITableViewCell() }
        vc.textFieldHeader.text = cell.labelHeader.text
        vc.textField.text = cell.labelNote.text
        vc.textField.textColor = cell.labelNote.textColor
        
        cell.clickEditRow = { [weak self] in  self?.navigationController?.pushViewController(vc, animated: true) }
        return cell
    }
}



