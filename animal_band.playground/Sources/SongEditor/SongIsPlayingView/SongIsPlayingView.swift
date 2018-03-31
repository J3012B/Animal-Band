import UIKit

public class SongIsPlayingView: UIViewLayer {
    
    private var mainLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public func setText(_ text: String) {
        self.mainLabel.text = text
        updateFrame()
    }
    
    private func updateFrame() {
        self.mainLabel.sizeToFit()
        self.mainLabel.center = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    public func songStartedPlaying() {
        self.isHidden = false
        self.setText(prettify(songName: currentSong))
    }
    
    public func songEndedPlaying() {
        self.isHidden = true
    }
    
    
    
    private func addElements() {
        let padding: CGFloat = self.frame.height * 0.2
        
        /* add main view */
        mainLabel = UILabel(frame: CGRect(x: padding, y: padding, width: frame.width - 4 * padding, height: frame.height - 2 * padding))
        mainLabel.text = "Lorem ipsum is written here"
        mainLabel.textColor = UIColor.white
        mainLabel.textAlignment = .center
        mainLabel.font = mainLabel.font.withSize(frame.height * 0.1)
        
        self.updateFrame()
        self.addSubview(mainLabel)
    }
    
}

