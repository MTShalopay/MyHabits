//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Shalopay on 06.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    private lazy var editHabitViewController = EditHabitViewController(habit: habit) 
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(HabitDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: HabitDetailsHeaderView.headerViewReuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultcell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        title = habit.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.systemPurple
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButton))
        setupView()
    }
    
    func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editButton() {
        print(#function)
        self.navigationController?.present(editHabitViewController, animated: true, completion: nil)
        
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.trackDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: HabitsStore.shared.dates.count - 1 - indexPath.item)
        if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - 1 - indexPath.item]) == true {
            cell.accessoryType = .checkmark
            }
            cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HabitDetailsHeaderView.headerViewReuseIdentifier) as? HabitDetailsHeaderView else { return nil }
        return header
       
    }
    
}
