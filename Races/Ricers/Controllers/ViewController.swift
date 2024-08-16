//
//  ViewController.swift
//  Ricers
//
//  Created by Артем Антонов on 15.08.2024.
//

import UIKit

enum Things {
    case mainCar
    case trees
    case opponentCar
    case hole
}
enum Side {
    case left
    case right
}
class ViewController: UIViewController {

    @IBOutlet weak var wayView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    
    
    
    var mainCar = UIImageView()
    var leftTrees = [UIImageView]()
    var rightTrees = [UIImageView]()
    var opponentCar = UIImageView()
    var hole = UIImageView()
    var whiteLines = [UIView]()
    
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var controllerView = UIView()
    
    let countTrees = 5
    let moveTrees: CGFloat = 50
    let moveOpponentCar: CGFloat = 100
    
    var timerTrees = Timer()
    var timerOpponentCar = Timer()
    var timerHole = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createThings(thing: .trees)
        self.createThings(thing: .hole)
        self.createThings(thing: .opponentCar)
        self.createControllerView()
        self.createButtons()
        self.createThings(thing: .mainCar)
    }
    
    
    @IBAction func leftMove() {
        self.moveMainCar(side: .left)
    }
    @IBAction func rightMove() {
        self.moveMainCar(side: .right)
    }
    
    private func createThings(thing: Things) {
        switch thing {
        case .mainCar:
            

            self.mainCar.frame = CGRect(x: 0, y: self.wayView.frame.height - self.controllerView.frame.height - self.wayView.frame.height/5, width: self.wayView.frame.width/2, height: self.wayView.frame.height/6)
            self.mainCar.contentMode = .scaleAspectFill
            self.wayView.addSubview(self.mainCar)
        case .trees:
            for i in 1...self.countTrees {
                let height = Int(self.rightView.frame.height)
                let y = height - ((i)*height/self.countTrees)
                let rightTree = UIImageView(frame: CGRect(x: 0, y: y, width: Int(self.rightView.frame.width), height: (height/(2*countTrees))))
                let leftTree = UIImageView(frame: CGRect(x: 0, y: y, width: Int(self.rightView.frame.width), height: (height/(2*countTrees))))
                rightTree.image = UIImage(named: "tree")
                leftTree.image = UIImage(named: "tree")
                self.leftTrees.append(leftTree)
                self.rightTrees.append(rightTree)
                self.leftView.addSubview(leftTree)
                self.rightView.addSubview(rightTree)
                
                let view = UIView(frame: CGRect(x: Int(self.wayView.frame.width/2)-5, y: y, width: 10, height: height/(2*countTrees)))
                view.backgroundColor = .white
                self.whiteLines.append(view)
                self.wayView.addSubview(view)
                
            }
            self.timerTrees = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
                self.move(thing: .trees)
            })
            
        case .opponentCar:
            self.opponentCar.image = UIImage(named: "oponentCar")
            self.opponentCar.frame = CGRect(x: 0, y: -self.wayView.frame.height/(6)-300, width: self.wayView.frame.width/2, height: self.wayView.frame.height/(6))
            self.opponentCar.contentMode = .scaleAspectFit
            self.wayView.addSubview(self.opponentCar)
            self.timerOpponentCar = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
                self.move(thing: .opponentCar)
            })
            
        case .hole:
            self.hole.image = UIImage(named: "hole")
            self.hole.frame = CGRect(x: 0, y: -self.wayView.frame.height/(7)-500, width: self.wayView.frame.width/2, height: self.wayView.frame.height/(7))
            self.hole.contentMode = .scaleAspectFit
            self.wayView.addSubview(self.hole)
            self.timerHole = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
                self.move(thing: .hole)
            })
        }
    }
    
    private func move(thing: Things) {
        switch thing {
        case .mainCar:
            return
        case .trees:
                UIView.animate(withDuration: 0.3) {
                    for i in 0..<self.countTrees {
                        self.leftTrees[i].frame.origin.y+=self.moveTrees
                        self.rightTrees[i].frame.origin.y+=self.moveTrees
                        self.whiteLines[i].frame.origin.y+=self.moveTrees
                    }
                } completion: { _ in
                    for i in 0..<self.countTrees {
                        if (self.leftTrees[i].frame.origin.y  >= self.leftView.frame.height) {
                            self.leftTrees[i].frame.origin.y = 0
                            self.rightTrees[i].frame.origin.y = 0
                        }
                        if (self.whiteLines[i].frame.origin.y >= self.leftView.frame.height) {
                            self.whiteLines[i].frame.origin.y = 0
                        }
                        
                    }
                }
        case .opponentCar:
            
            UIView.animate(withDuration: 0.3) {
                self.opponentCar.frame.origin.y += self.moveOpponentCar
                
            } completion: { _ in
                if (self.opponentCar.frame.origin.y >= self.wayView.frame.height) {
                    self.opponentCar.frame.origin.y = -self.opponentCar.frame.height - 200
                    let x = self.mainCar.frame.origin.x < self.wayView.frame.width/2 ? 0:self.wayView.frame.width/2
                    self.opponentCar.frame.origin.x = x
                }
                if (self.opponentCar.frame.intersects(self.mainCar.frame)) {
                    self.endGame()
                }
            }

        case .hole:
            
            UIView.animate(withDuration: 0.3) {
                self.hole.frame.origin.y += self.moveTrees
                
            } completion: { _ in
                if (self.hole.frame.origin.y >= self.wayView.frame.height) {
                    self.hole.frame.origin.y = -self.hole.frame.height - 100
                    let x = self.mainCar.frame.origin.x < self.wayView.frame.width/2 ? 0:self.wayView.frame.width/2
                    self.hole.frame.origin.x = x
                }
                if (self.hole.frame.intersects(self.mainCar.frame)) {
                    self.endGame()
                }
                
            }
        }
    }
    
    private func createControllerView() {
        let y = Int(self.view.frame.height) - Int(self.view.frame.height/7)
        self.controllerView.frame = CGRect(x: 0, y: y, width: Int(self.view.frame.width), height: Int(self.view.frame.height/7))
        self.controllerView.backgroundColor = .orange
        self.view.addSubview(self.controllerView)
    }
    
    private func createButtons() {
        self.leftButton.frame = CGRect(x: 0, y: 0, width: self.controllerView.frame.width/2, height: self.controllerView.frame.height)
        self.leftButton.backgroundColor = .yellow
        self.leftButton.setTitle("LEFT", for: .normal)
        self.leftButton.setTitleColor(.black, for: .normal)
        self.leftButton.titleLabel?.font = UIFont(name: "GreatVibes-Regular", size: 20)
        self.leftButton.addTarget(self, action: #selector(leftMove), for: .touchUpInside)
        self.controllerView.addSubview(self.leftButton)
        
        self.rightButton.frame = CGRect(x: self.controllerView.frame.width/2, y: 0, width: self.controllerView.frame.width/2, height: self.controllerView.frame.height)
        self.rightButton.backgroundColor = .yellow
        self.rightButton.setTitle("RIGHT", for: .normal)
        self.rightButton.setTitleColor(.black, for: .normal)
        self.rightButton.titleLabel?.font = UIFont(name: "GreatVibes-Regular", size: 20)
        self.rightButton.addTarget(self, action: #selector(rightMove), for: .touchUpInside)
        self.controllerView.addSubview(self.rightButton)
    }
    
    private func moveMainCar(side: Side) {
        switch side {
        case .left:
            UIView.animate(withDuration: 0.3) {
                self.mainCar.frame.origin.x = 0
                
            }
        case .right:
            UIView.animate(withDuration: 0.3) {
                self.mainCar.frame.origin.x = self.wayView.frame.width/2
            }
        }
    }
    private func endGame() {
        timerHole.invalidate()
        timerTrees.invalidate()
        timerOpponentCar.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

