//
//  RecoedViewController.swift
//  TT
//
//  Created by Denis on 7/6/23.
//

import UIKit

class RecoedViewController: UIViewController {
    
    @IBOutlet weak var recordLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0{
            recordLable.text = "Ваш рекорд - \(record)"
        }else{
            recordLable.text = "Рекорд не установлен"
        }
    }
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true)
    }
}
