import UIKit

public class AnimalBandView: UIView {
    
    private var audienceApplauses: Bool = true
    
    public init(size: CGSize, audienceApplauses: Bool, willSaveTo: String) {
        let mySize = size.width * 1.5 <= size.height ? CGSize(width: size.width, height: size.width * 1.5) : CGSize(width: size.height * (2/3), height: size.height)
        super.init(frame: CGRect(x:0, y: 0, width: mySize.width, height: mySize.height))
        
        self.audienceApplauses = audienceApplauses
        
        titleToSaveTo = willSaveTo
        
        addSubViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    private func addSubViews() {
        /* Add Song Editor here */
        let songEditorFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.33)
        let songEditorView = SongEditorView(frame: songEditorFrame)
        
        self.addSubview(songEditorView)
        
        /* Add SK Scene View */
        let sceneViewFrame = CGRect(x: 0, y: frame.height - frame.width, width: frame.width, height: frame.width)
        let sceneView = SceneView(frame: sceneViewFrame, audienceApplauses: audienceApplauses)
        
        self.addSubview(sceneView)
        
        songEditorView.bandScene = sceneView.bandScene
        sceneView.bandScene.songEditorView = songEditorView
    }
}

