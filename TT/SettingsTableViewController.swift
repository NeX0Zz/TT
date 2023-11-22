//
//  SettingsTableViewController.swift
//  TT
//
//  Created by Denis on 7/1/23.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeGameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    @IBAction func changeTimer(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerState = sender.isOn
    }
    
    
    func loadSettings(){
        timeGameLable.text = "\(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSettings.timerState
    }
    
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.ressetSettings()
        loadSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController{
                vc.data = [10,20,30,40,50,60,70,80,90,100,110,120]
            }
        default:
            break
        }
    }
}
