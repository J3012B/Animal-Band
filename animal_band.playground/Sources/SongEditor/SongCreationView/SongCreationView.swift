import UIKit

public class SongCreationView: UIViewLayer {
    
    private var textField: UITextField!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public func show() {
        self.isHidden = false
        self.textField.text = ""
    }
    
    
    
    private func addElements() {
        let padding: CGFloat = self.frame.height * 0.1
        
        // Main View
        let mainView = UIView(frame: CGRect(x: 2 * padding, y: padding, width: frame.width - 4 * padding, height: frame.height - 2 * padding))
        mainView.backgroundColor = UIColor.white
        
        self.addSubview(mainView)
        
        // Text Field
        textField = UITextField(frame: CGRect(x: padding, y: padding, width: mainView.frame.width - 2 * padding, height: 30.0))
        textField.placeholder = "Enter song title (f.i. 'Let It Be', ...)"
        textField.inputView = UIView()
        
        mainView.addSubview(textField)
    }
    
}
