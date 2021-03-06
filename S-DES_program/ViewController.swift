//
//  ViewController.swift
//  S-DES_program
//
//  Created by 최동호 on 2021/11/21.
//
/* 2021/12/17 키값 입력 부분에서 오류 제어 수정
 * solution - 문자열이 정수로 변환 가능한지 확인하는 함수*/

/*
    S-DES(Simple-Data Encryption) Simulation
    
    암호화 할 문장과 암호키를 입력한 뒤 암호화 실행 버튼을 누르면 암호화 후 복호화 자동 실행
    오른쪽 아래에 ?를 누르면 간단한 설명이 있으며 Git에서 알아볼 수도 있음
 
 */

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var plainText: UITextField!
    @IBOutlet weak var keyText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startButton(_ sender: Any){
       
            performSegue(withIdentifier: "showSecondView", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showSecondView"{
            if plainText.hasText == false || keyText.hasText == false{
                let alert = UIAlertController(title: "암호화할 문장과 키값을 입력하세요", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                    alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                
            }
            else if solution(keyText.text!) == false{
                let alert = UIAlertController(title: "키 값은 숫자만 입력할 수 있습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }else if Int(keyText.text!)! < 0 || Int(keyText.text!)! > 1023{
                let alert = UIAlertController(title: "키 값이 범위를 벗어났습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }else{
                let secondVC = segue.destination as! SecondViewController
                
                secondVC.receivedPlain = plainText.text!
                secondVC.receivedKey = keyText.text!
                
                }
            }
        }
    
    func solution(_ s: String) -> Bool{
        let filter = s.filter { (number) -> Bool in Int(String(number)) == nil}
               return filter.count > 0 ? false : true
    }

}

