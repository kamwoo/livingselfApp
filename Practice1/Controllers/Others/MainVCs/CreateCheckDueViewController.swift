//
//  CreateCheckDueViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/24.
//

import UIKit

protocol CreateCheckDueViewControllerDelegate:AnyObject {
    func didTapComplete()
}

class CreateCheckDueViewController: UIViewController {
    
    weak var delegate : CreateCheckDueViewControllerDelegate?
    
    private var dates: [String] {
        var dates = [String]()
        for date in 1...31{
            dates.append("\(date)")
        }
        return dates
    }
    
    private var day: Int?
    
    private let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        view.layer.masksToBounds = true
        return view
    }()
    
    private let DueNameInputField : UITextField = {
       let field = UITextField()
        field.placeholder = "ex) 수도세, 월세"
        field.font = UIFont(name: "MapoPeacefull", size: 14)
        field.becomeFirstResponder()
        return field
    }()
    
    private let DueNameLabel: UILabel = {
       let label = UILabel()
        label.text = "내는 날"
        label.font = UIFont(name: "MapoPeacefull", size: 14)
        return label
    }()
    
    private let DueDateLabel: UILabel = {
        let label = UILabel()
         label.text = "매달"
         label.font = UIFont(name: "MapoPeacefull", size: 14)
         return label
    }()
    
    private let DatePickerView: UIPickerView = {
       let picker = UIPickerView()
        return picker
    }()
    
    private let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "일"
        label.font = UIFont(name: "MapoPeacefull", size: 14)
        return label
    }()
    
    private let completeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = UIFont(name: "MapoPeacefull", size: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont(name: "MapoPeacefull", size: 18)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        view.addSubview(cellView)
        cellView.addSubview(DueNameLabel)
        cellView.addSubview(DueNameInputField)
        cellView.addSubview(DueDateLabel)
        cellView.addSubview(DatePickerView)
        cellView.addSubview(dayLabel)
        DatePickerView.delegate = self
        DatePickerView.dataSource = self
        DatePickerView.selectRow(9, inComponent: 0, animated: true)
        view.addSubview(completeButton)
        view.addSubview(backButton)
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc private func didTapCompleteButton(){
        // 유저 디폴트, dismiss 후 컴플리션으로 reload
        if String(DueNameInputField.text!).count == 0 {
            DueNameInputField.shake()
            DueNameLabel.shake()
        }
        else{
            let dueName = String(DueNameInputField.text!)
            let day = dates[DatePickerView.selectedRow(inComponent: 0)]
            let userDefaults = UserDefaults.standard
            
            var dues = userDefaults.stringArray(forKey: "DuesList")
            dues?.append(dueName)
            userDefaults.set(dues, forKey: "DuesList")
            
            // dueName으로 날짜, 체크생성
            do {
                try userDefaults.setObject(checkDues(dueDate: day, dueCheck: false), forKey:dueName)
            }catch{
                print(error.localizedDescription)
            }
            delegate?.didTapComplete()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc private func didTapBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cellViewWidth = view.width*8/10
        let cellViewHeight = view.width/5
        cellView.frame = CGRect(x: view.width/2 - cellViewWidth/2,
                                y: view.height/2 - cellViewHeight/2,
                                width: cellViewWidth,
                                height: cellViewHeight)
        cellView.layer.cornerRadius = view.width/20
        DueNameInputField.frame = CGRect(x: cellView.width/12,
                                         y: cellView.height/6,
                                         width: cellView.width/4,
                                         height: cellView.height*4/6)
        DueNameLabel.sizeToFit()
        DueNameLabel.center.x = DueNameInputField.right + DueNameLabel.width/2
        DueNameLabel.center.y = cellView.height/2
        DueDateLabel.sizeToFit()
        DueDateLabel.center.x = DueNameLabel.right + DueNameLabel.width
        DueDateLabel.center.y = cellView.height/2
        DatePickerView.frame = CGRect(x: DueDateLabel.right,
                                      y: 0,
                                      width: cellView.width/5,
                                      height: cellView.height)
        dayLabel.sizeToFit()
        dayLabel.center.x = DatePickerView.right + dayLabel.width/2
        dayLabel.center.y = cellView.height/2
        let buttonSize = view.width/8
        backButton.frame = CGRect(x: view.width/4-buttonSize/2 + buttonSize,
                                      y: cellView.bottom+buttonSize/2,
                                      width: buttonSize,
                                      height: buttonSize)
        
        completeButton.frame = CGRect(x: view.width*3/4-buttonSize/2 - buttonSize,
                                  y: cellView.bottom+buttonSize/2,
                                  width: buttonSize,
                                  height: buttonSize)
    }

}

extension CreateCheckDueViewController: UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 31
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "MapoPeacefull", size: 10)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = dates[row]
            pickerLabel?.textColor = UIColor.blue

            return pickerLabel!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
