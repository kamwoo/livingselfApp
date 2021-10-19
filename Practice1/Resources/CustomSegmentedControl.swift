//
//  CustomSegmentedControl.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/15.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func ChangeToIndex(index: Int)
}

class CustomSegmentedControl: UIView {
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private var selectedIndex = 3
    
    private var buttonTitles: [String]!
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    
    private func configStackView(){
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func configSelectorView(){
        let selectorWidth = frame.width/CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton(){
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "MapoPeacefull", size: 14)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[self.selectedIndex].setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc private func buttonAction(sender: UIButton){
        for (buttonIdx, btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count)*CGFloat(buttonIdx)
                UIView.animate(withDuration: 0.2){
                    self.selectorView.frame.origin.x = selectorPosition
                }
                delegate?.ChangeToIndex(index: buttonIdx)
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    private func setIndex(index: Int){
        buttons.forEach({$0.setTitleColor(textColor, for: .normal)})
        let button = buttons[index]
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count)*CGFloat(index)
        self.selectorView.frame.origin.x = selectorPosition
        delegate?.ChangeToIndex(index: index)
    }
    
    private func updateView(){
        createButton()
        configSelectorView()
        configStackView()
        setIndex(index: self.selectedIndex)
    }
    
    convenience init(frame: CGRect, buttonTitles: [String], startIndex: Int) {
        self.init(frame:frame)
        self.buttonTitles = buttonTitles
        self.selectedIndex = startIndex
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }

}
