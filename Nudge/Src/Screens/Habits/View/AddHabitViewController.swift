//
//  AddHabitViewController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

class AddHabitViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a Goal!"
        label.font = UIFont(name: "Nunito-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
