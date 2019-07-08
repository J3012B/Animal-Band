import UIKit


class Picker: UIView {
    
    private var leftButton: UIButton!
    private var rightButton: UIButton!
    private var textLbl: UILabel!
    
    private var currentIndex: Int = 0
    public var currentTitle: String = ""
    
    private var titles: [String]!
    private var action: () -> Void?
    
    public init(frame: CGRect, titles: [String], action: @escaping () -> Void) {
        self.titles = titles
        self.action = action
        
        super.init(frame: frame)

        self.addUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.action = { return }
        super.init(coder: aDecoder)
    }
    

    
    
    @objc private func leftButtonPushed() {
        currentIndex -= 1
        
        if currentIndex < 0 {
            currentIndex = self.titles.count - 1
        }
        
        self.textLbl.text = self.titles[currentIndex]
        self.currentTitle = self.textLbl!.text!
        
        action()
    }
    @objc private func rightButtonPushed() {
        currentIndex += 1;
        
        if currentIndex >= self.titles.count {
            currentIndex = 0
        }
        
        self.textLbl.text = self.titles[currentIndex]
        self.currentTitle = self.textLbl!.text!
        
        action()
    }
   
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addUI() {
        self.addButtons()
        self.addTextLabel()
        
    }
    
    private func addButtons() {
        leftButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: frame.height, height: frame.height))
        leftButton.addTarget(self, action:#selector(leftButtonPushed), for: .touchUpInside)
        leftButton.setImage(UIImage(named: "Menu/Picker_Buttons/leftButton.png"), for: .normal)
        
        rightButton = UIButton(frame: CGRect(x: frame.width - frame.height, y: 0.0, width: frame.height, height: frame.height))
        rightButton.addTarget(self, action:#selector(rightButtonPushed), for: .touchUpInside)
        rightButton.setImage(UIImage(named: "Menu/Picker_Buttons/rightButton.png"), for: .normal)
        
        self.addSubview(leftButton)
        self.addSubview(rightButton)
    }
    
    private func addTextLabel() {
        textLbl = UILabel(frame: CGRect(x: leftButton.frame.maxX, y: 0.0, width: frame.width - 2 * leftButton.frame.width, height: frame.height))
        textLbl.text = self.titles[currentIndex]
        textLbl.backgroundColor = UIColor.clear
        textLbl.textColor = UIColor.white
        textLbl.textAlignment = .center
        
        self.addSubview(textLbl)
    }
    
}

