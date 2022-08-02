//
//  NewHabit.swift
//  MyHabits
//
//  Created by Shalopay on 28.06.2022.
//

import UIKit

class NewHabit: UIViewController {
    private let myTitle = "Создать"
    private lazy var habitColor: UIColor = .black
    
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
        nameHabitTF.layer.borderWidth = 0.5
        nameHabitTF.layer.borderColor = UIColor.lightGray.cgColor
        nameHabitTF.tintColor = UIColor.lightText
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
        habitTimeDateTextLb.text = dateFormatter.string(from: habitTimeDatePicker.date)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = myTitle
        self.navigationController?.navigationBar.tintColor = UIColor.systemPurple
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(addButton))
        setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentColorPicker))
        colorView.addGestureRecognizer(tap)
        
        let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
        view.addGestureRecognizer(tapDissmis)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    private func setupView() {
        
        view.addSubview(nameHabitLb)
        view.addSubview(nameHabitTF)
        view.addSubview(nameColorLb)
        view.addSubview(colorView)
        view.addSubview(timeLb)
        view.addSubview(habitTimeTextLb)
        view.addSubview(habitTimeDateTextLb)
        view.addSubview(habitTimeDatePicker)
        
        NSLayoutConstraint.activate([
            nameHabitLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameHabitLb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
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
        
        ])
    }
    
    
    @objc func cancelButton() {
        navigationController?.popViewController(animated: true)
    }
    @objc func addButton() {
        
        //((newHabitNameTextField.text?.isEmpty) != Optional(false))
        if ((nameHabitTF.text?.isEmpty) != false) {
            nameHabitTF.text = "Забыли заполнить поле"
            
        }
        let newHabit = Habit(name: nameHabitTF.text ?? "Пусто", date: habitTimeDatePicker.date, color: habitColor)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentColorPicker() {
        print(#function)
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = UIColor.black
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func changeTime(sender: UIDatePicker) {
        print(#function)
        habitTimeDateTextLb.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func dissmiskeyboard() {
        view.endEditing(true)
    }
    
}
extension NewHabit: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension NewHabit: UIColorPickerViewControllerDelegate {
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
