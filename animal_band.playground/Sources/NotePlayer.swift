import AVFoundation

public class NotePlayer {
    public var timeToPlay: Int!
    public var player: AVAudioPlayer!
    
    public init(player: AVAudioPlayer, timeToPlay: Int) {
        self.timeToPlay = timeToPlay
        self.player = player
    }
}

