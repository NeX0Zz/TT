//
//  GameViewController.swift
//  TT
//  Created by Denis on 6/13/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var newGameButtons: UIButton!
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var statusLable: UILabel!
    
    lazy var game = Game(countItems: buttons.count) {[weak self]  (status, time) in
        
        guard let self = self else{return}
        
        self.timerLable.text = time.secondsToString()
        
        self.updateInfoGame(with: status)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        
        
    }
    
    
    
    @IBAction func pressButtom(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUi()
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    private func setupScreen(){
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    private func updateUi(){
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError{
                UIView .animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                }completion: { [weak self](_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status  {
        case .win:
            statusLable.text = "Вы выиграли"
            newGameButtons.isHidden = false
            if game.isNewRecord{
                showAlert()
            }else{showAlertActionSheet()}
        case .start:
            statusLable.text = "Игра началась"
            newGameButtons.isHidden = true
        case .lose:
            statusLable.text = "Вы проиграли"
            newGameButtons.isHidden = false
            showAlertActionSheet()
        }
    }
    private func showAlert(){
        
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    private func showAlertActionSheet(){
        let alert = UIAlertController(title: "Что вы хотите сделать?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Начать новyю игру", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Показать рекорд", style: .default) { [weak self] (_) in
            
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
