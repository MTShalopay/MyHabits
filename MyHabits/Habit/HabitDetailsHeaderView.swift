//
//  HabitDetailsHeaderView.swift
//  MyHabits
//
//  Created by Shalopay on 11.07.2022.
//

import UIKit

class HabitDetailsHeaderView: UITableViewHeaderFooterView {
    static let headerViewReuseIdentifier = "HabitDetailsHeaderView"
    
    private let habitLabel: UILabel = {
        let habitLabel = UILabel()
        habitLabel.text = "АКТИВНОСТЬ"
        habitLabel.font = .systemFont(ofSize: 13)
        habitLabel.textColor = .systemGray
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        return habitLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        contentView.addSubview(habitLabel)
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            habitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
