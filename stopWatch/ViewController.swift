//
//  ViewController.swift
//  stopWatch
//
//  Created by shota ito on 23/09/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var laps: [String] = []
    
    var stopwatchString: String = ""
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startstopBtn: UIButton!
    @IBOutlet weak var lapsresetBtn: UIButton!
    
    
    
    @IBAction func startStop(_ sender: Any) {
        if startStopWatch == true{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            
            // process once the stop watch is started
            //"startStopWatch" must be false
            startStopWatch = false
            
            // images must change
            startstopBtn.setImage(UIImage(named: "stop.png"), for: UIControlState.normal)
            lapsresetBtn.setImage(UIImage(named: "lap.png"), for: UIControlState.normal)
            
            //add laps
            addLap = true
            
        }else{
            timer.invalidate()
            startStopWatch = true
            startstopBtn.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
            lapsresetBtn.setImage(UIImage(named: "reset.png"), for: UIControlState.normal)
            
            addLap = false
        }
    
    }
    
    
    
    @objc func updateStopwatch(){
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        // this string makes "00:00"
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        // finally the time string is made and it is represented below
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        
        stopwatchLabel.text! = stopwatchString
        
    }
    
    
    
    @IBAction func lapsReset(_ sender: Any) {
        if addLap == true{
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()
            
        }else{
            addLap = false
            lapsresetBtn.setImage(UIImage(named: "lap.png"), for: UIControlState.normal)
            
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            stopwatchString = "00:00.00"
            stopwatchLabel.text! = stopwatchString
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopwatchLabel.text! = "00:00.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

