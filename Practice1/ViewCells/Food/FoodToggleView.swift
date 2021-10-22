

import UIKit

protocol FoodToggleViewDelegate: AnyObject {
    func FoodToggleViewDidTapStorage(_ toggleView: FoodToggleView)
    func FoodToggleViewDidTapRecipe(_ toggleView: FoodToggleView)
}

class FoodToggleView: UIView {
    
    enum State {
        case Storage
        case Recipe
    }
    
    var state: State = .Storage
    
    weak var delegate: FoodToggleViewDelegate?
    
    private let StorageButton: UIButton = {
       let button = UIButton()
        button.setTitle("Storage", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let RecipeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Recipe", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(StorageButton)
        addSubview(RecipeButton)
        addSubview(indicatorView)
        StorageButton.addTarget(self, action: #selector(didTapStorage), for: .touchUpInside)
        RecipeButton.addTarget(self, action: #selector(didTapRecipe), for: .touchUpInside)
    }
    
    @objc private func didTapStorage() {
        state = .Storage
        UIView.animate(withDuration: 0.2){
            self.layoutIndicator()
        }
        delegate?.FoodToggleViewDidTapStorage(self)
    }
    
    @objc private func didTapRecipe() {
        state = .Recipe
        UIView.animate(withDuration: 0.2){
            self.layoutIndicator()
        }
        delegate?.FoodToggleViewDidTapRecipe(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        StorageButton.frame = CGRect(x: 0, y: 0, width: width/2, height: height)
        RecipeButton.frame = CGRect(x: StorageButton.right, y: 0, width: width/2, height: height)
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
        case .Storage:
            indicatorView.frame = CGRect(x: 0, y: StorageButton.bottom, width: width/2, height: 3)
        case .Recipe:
            indicatorView.frame = CGRect(x: width/2, y: RecipeButton.bottom, width: width/2, height: 3)
        }
    }
    
    func update(for state: State){
        self.state = state
        UIView.animate(withDuration: 0.2){
            self.layoutIndicator()
        }
    }

}
