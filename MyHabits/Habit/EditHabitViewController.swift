//
//  EditHabitViewController.swift
//  MyHabits
//
//  Created by Shalopay on 06.07.2022.
//

import UIKit

class EditHabitViewController: UIViewController {
    
    private lazy var habitColor: UIColor = .black
    public let habit: Habit
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Править")
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButton))
        navItem.rightBarButtonItem = saveItem

        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButton))
        navItem.leftBarButtonItem = cancelItem

        navBar.setItems([navItem], animated: false)

        saveItem.tintColor = .purple
        cancelItem.tintColor = .purple
        return navBar
    }()
    
    private let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:a"
            dateFormatter.locale = Locale(identifier: "en_US")
            return dateFormatter
        }()
    
    private lazy var nameHabitLb: UILabel = {
        let nameHabitLb = UILabel()
        nameHabitLb.font = .systemFont(ofSize: 13, weight: .bold)
        nameHabitLb.text = "НАЗВАНИЕ"
        nameHabitLb.textColor = .black
        nameHabitLb.translatesAutoresizingMaskIntoConstraints = false
        return nameHabitLb
    }()
    
    private lazy var nameHabitTF: UITextField = {
       let nameHabitTF = UITextField()
        nameHabitTF.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameHabitTF.font = .systemFont(ofSize: 17)
        nameHabitTF.textColor = .black
        nameHabitTF.autocapitalizationType = .none
        nameHabitTF.returnKeyType = .done
        nameHabitTF.delegate = self
        nameHabitTF.translatesAutoresizingMaskIntoConstraints = false
        return nameHabitTF
    }()
    
    private lazy var nameColorLb: UILabel = {
        let nameColorLb = UILabel()
        nameColorLb.font = .systemFont(ofSize: 13, weight: .bold)
        nameColorLb.text = "ЦВЕТ"
        nameColorLb.textColor = .black
        nameColorLb.translatesAutoresizingMaskIntoConstraints = false
        return nameColorLb
    }()
    
    private lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.backgroundColor = habitColor
        colorView.isUserInteractionEnabled = true
        colorView.translatesAutoresizingMaskIntoConstraints = false
        return colorView
    }()
    
    private lazy var timeLb: UILabel = {
        let timeLb = UILabel()
        timeLb.font = .systemFont(ofSize: 13, weight: .bold)
        timeLb.text = "ВРЕМЯ"
        timeLb.textColor = .black
        timeLb.translatesAutoresizingMaskIntoConstraints = false
        return timeLb
    }()
    
    private lazy var habitTimeTextLb: UILabel = {
        let habitTimeTextLb = UILabel()
        habitTimeTextLb.font = .systemFont(ofSize: 17)
        habitTimeTextLb.text = "Каждый день в "
        habitTimeTextLb.textColor = .black
        habitTimeTextLb.translatesAutoresizingMaskIntoConstraints = false
        return habitTimeTextLb
    }()
    
    private lazy var habitTimeDateTextLb: UILabel = {
        let habitTimeDateTextLb = UILabel()
        habitTimeDateTextLb.font = .systemFont(ofSize: 17)
        habitTimeDateTextLb.textColor = UIColor.purple
        habitTimeDateTextLb.translatesAutoresizingMaskIntoConstraints = false
        return habitTimeDateTextLb
    }()
    
    private lazy var habitTimeDatePicker: UIDatePicker = {
        let habitTimeDatePicker = UIDatePicker()
        habitTimeDatePicker.datePickerMode = .time
        habitTimeDatePicker.preferredDatePickerStyle = .wheels
        habitTimeDatePicker.locale = Locale(identifier: "en_US")
        habitTimeDatePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        habitTimeDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return habitTimeDatePicker
    }()
    
    let deleteHabitButton: UIButton = {
        let deleteHabitButton = UIButton(type: .system)
        deleteHabitButton.setTitle("Удалить привычку", for: .normal)
        deleteHabitButton.setTitleColor(.red, for: .normal)
        deleteHabitButton.addTarget(self, action: #selector(showDeleteAlert(_:)), for: .touchUpInside)
        deleteHabitButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteHabitButton
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameHabitTF.text = habit.name
        habitTimeDatePicker.date = habit.date
        colorView.backgroundColor = habit.color
        habitTimeDateTextLb.text = dateFormatter.string(from: habit.date)
        
        setupTaping()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    private func setupTaping() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentColorPicker))
        colorView.addGestureRecognizer(tap)
        
        let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
        view.addGestureRecognizer(tapDissmis)
    }
    
    private func setupView(){
        view.addSubview(navBar)
        view.addSubview(nameHabitLb)
        view.addSubview(nameHabitTF)
        view.addSubview(nameColorLb)
        view.addSubview(colorView)
        view.addSubview(timeLb)
        view.addSubview(habitTimeTextLb)
        view.addSubview(habitTimeDateTextLb)
        view.addSubviews(habitTimeDatePicker)
        view.addSubview(deleteHabitButton)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            
            nameHabitLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameHabitLb.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 21),
            nameHabitLb.heightAnchor.constraint(equalToConstant: 18),
            
            nameHabitTF.topAnchor.constraint(equalTo: nameHabitLb.bottomAnchor, constant: 7),
            nameHabitTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameHabitTF.heightAnchor.constraint(equalToConstant: 22),
            nameHabitTF.widthAnchor.constraint(equalToConstant: 295),
            
            nameColorLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameColorLb.topAnchor.constraint(equalTo: nameHabitTF.bottomAnchor, constant: 15),
            nameColorLb.heightAnchor.constraint(equalToConstant: 18),
            
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorView.topAnchor.constraint(equalTo: nameColorLb.bottomAnchor, constant: 7),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            timeLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeLb.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            timeLb.heightAnchor.constraint(equalToConstant: 18),
            
            habitTimeTextLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            habitTimeTextLb.topAnchor.constraint(equalTo: timeLb.bottomAnchor, constant: 7),
            habitTimeTextLb.heightAnchor.constraint(equalToConstant: 22),
            
            habitTimeDateTextLb.leadingAnchor.constraint(equalTo: habitTimeTextLb.trailingAnchor),
            habitTimeDateTextLb.topAnchor.constraint(equalTo: timeLb.bottomAnchor, constant: 7),
            habitTimeDateTextLb.heightAnchor.constraint(equalToConstant: 22),
            
            habitTimeDatePicker.topAnchor.constraint(equalTo: habitTimeDateTextLb.bottomAnchor, constant: 15),
            habitTimeDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitTimeDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func showDeleteAlert(_ sender: Any) {
        let deleteAlertController = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку '\(habit.name)'?", preferredStyle: .alert)
        let cancelDeleteAction = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        let completeDeleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            if let oldHabit = HabitsStore.shared.habits.firstIndex(where: ({ $0.name == self.habit.name })) {
                HabitsStore.shared.habits.remove(at: oldHabit )
            }
//MARK: ERROR 1 Тут не получается вернуться на самый стартовый HarbitsViewController
            self.dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
// - КОНЕЦ //
        deleteAlertController.addAction(cancelDeleteAction)
        deleteAlertController.addAction(completeDeleteAction)
        self.present(deleteAlertController, animated: true, completion: nil)
    }
    
    @objc func presentColorPicker() {
        print(#function)
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = UIColor.black
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func dissmiskeyboard() {
        view.endEditing(true)
    }
    
    @objc func changeTime(sender: UIDatePicker) {
        print(#function)
        habitTimeDateTextLb.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButton() {
        if ((nameHabitTF.text?.isEmpty) != Optional(false)) {
            nameHabitTF.text = "Забыли заполнить поле"
        }
        
        let editedHabit = Habit(
            name: nameHabitTF.text ?? "NO DATA",
            date: habitTimeDatePicker.date,
            color: colorView.backgroundColor ?? habit.color
        )
        editedHabit.trackDates = habit.trackDates
        reloadInputViews()
        
        if let index = HabitsStore.shared.habits.firstIndex(where: { $0 == self.habit }) {
            HabitsStore.shared.habits[index] = editedHabit
        }
        self.dismiss(animated: true, completion: nil)

        }
        
}



extension EditHabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        nameHabitTF.resignFirstResponder()
        return true
    }
}

extension EditHabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        print(#function)
        let selectedColor = viewController.selectedColor
        habitColor = selectedColor
        colorView.backgroundColor = habitColor
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print(#function)
        let selectedColor = viewController.selectedColor
        habitColor = selectedColor
        colorView.backgroundColor = habitColor
    }
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect: UIColor, continuously: Bool) {
        print(#function)
    }
}
