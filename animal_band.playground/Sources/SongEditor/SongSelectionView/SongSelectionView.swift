import UIKit

/* Menu, from which you can pick song jsons from the song directory */

public class SongSelectionView: UIViewLayer, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    let cellIdentifier = "cell"
    
    var songNames: [String]!
    
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        self.songNames = []
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    public func reset() {
        songNames = []
    }
    
    public func show() {
        self.reset()
        self.isHidden = false
        
        loadSongNames()
        tableView.reloadData()
    }
    
    /*
     ===================================================================
     ============================= Logic ===============================
     */
    
    private func loadSongNames() {
        //let fileManager = FileManager.default
        let songPaths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: "songs/")
        
        for songPath in songPaths {
            let songPathArray = songPath.split(separator: "/") // array with path components
            let uglySongName = songPathArray[songPathArray.count - 1] // only song file name (with extension)
            let prettySongName = prettify(songName: String(uglySongName)) // prettified song name
            
            self.songNames.append(prettySongName)
        }
        
        self.songNames = self.songNames.sorted { $0 < $1 }
    }
    
    
    /*
     ===================================================================
     ====================== Table View Delegate ========================
     */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SongTableViewCell {
            let cellSong = self.songNames[indexPath.row]
            
            if !cell.addedElements {
                cell.addElements()
            }
            
            cell.song = cellSong
            cell.isChosen = (prettify(songName: currentSong) == cellSong)
            
            return cell
        }
        
        print("SongSelectionView.tableView(cellForRowAt:_) >> Couldn't reuse table cell")
        return UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songNames.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSong = uglify(songName: (tableView.cellForRow(at: indexPath) as! SongTableViewCell).song)
        
        tableView.reloadData()
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addElements() {
        let padding: CGFloat = self.frame.height * 0.1
        
        /* add main view */
        let mainView = UIView(frame: CGRect(x: 2 * padding, y: padding, width: frame.width - 4 * padding, height: frame.height - 2 * padding))
        mainView.backgroundColor = UIColor.white
        
        self.addSubview(mainView)
        
        /* add title label */
        let titleLbl = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: mainView.frame.width, height: mainView.frame.height * 0.2))
        titleLbl.backgroundColor = UIColor(hex: "#566573")
        titleLbl.textColor = UIColor.white
        titleLbl.text = "Your Songs"
        titleLbl.textAlignment = .center
        
        /* add song table */
        tableView = UITableView(frame: CGRect(x: 0.0, y: titleLbl.frame.maxY, width: mainView.frame.width, height: mainView.frame.height - titleLbl.frame.maxY))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        mainView.addSubview(titleLbl)
        mainView.addSubview(tableView)
        
    }
}

