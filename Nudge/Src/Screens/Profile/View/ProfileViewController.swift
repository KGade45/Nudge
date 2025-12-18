//
//  ProfileViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Data Model

    private let sectionsData: [[(name: String, info: String)]] = [
        [("Wake-up Time", "7:30 AM"),
         ("Work Start Time", "10:00 AM"),
         ("Dinner Time", "8:30 PM")],
        
        [("Home Location", "Set"),
         ("Office Location", "Set")],
        
        [("Notifications", "Allowed"),
         ("Location Access", "While Using")]
    ]
    
    private let sectionTitles = ["Routine", "Locations", "Permissions"]
    
    // MARK: - UI Components
    
    private lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // Grouped style for correct header spacing
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SectionContainerCell.self, forCellReuseIdentifier: SectionContainerCell.identifier)
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the custom profile header
        tableView.tableHeaderView = headerView
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView Delegate & DataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 // We use one container cell per section to get the card look
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionContainerCell.identifier, for: indexPath) as? SectionContainerCell else {
            return UITableViewCell()
        }
        cell.config(items: sectionsData[indexPath.section], section: indexPath.section)
        cell.delegate = self
        return cell
    }
    
    // MARK: - Section Headers

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = sectionTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold) // Match Screenshot Boldness
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between sections
    }
}

// MARK: - Actions Delegate

extension ProfileViewController: SectionContainerCellDelegate {
    func didTapItem(in section: Int, itemIndex: Int) {
        let item = sectionsData[section][itemIndex]
        print("Tapped: \(item.name)")
        // Navigate to details...
    }
}
