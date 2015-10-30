//
//  ViewController.swift
//  hitnumbers
//
//  Created by Takatoshi Watanabe on 2015/10/22.
//  Copyright (c) 2015年 Takatoshi Watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet var textView: UITextView!
    
    //挑戦した回数
    var count = 0
    //選択数字の配列
    var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    //picker viewで選択したインデックス番号
    var selectedIndex = 0
    
    // 全て文字列の空の配列を宣言
    var answers = [Int](count: 4, repeatedValue: 0)
    var array = [String]()
    
    /// ラベルをアウトプット接続
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegateを設定する.
        pickerView.delegate = self
        
        // DataSourceを設定する.
        pickerView.dataSource = self
        
        textView.editable = false
        textView.text = ""
        
        // 桁数の表示
        NSLog("\(pickerView.numberOfComponents)")
        
        // 答えの生成
        let a = Int(arc4random_uniform(UInt32(numbers.count)))
        answers[0] = numbers.removeAtIndex(a)
        let b = Int(arc4random_uniform(UInt32(numbers.count)))
        answers[1] = numbers.removeAtIndex(b)
        let c = Int(arc4random_uniform(UInt32(numbers.count)))
        answers[2] = numbers.removeAtIndex(c)
        let d = Int(arc4random_uniform(UInt32(numbers.count)))
        answers[3] = numbers.removeAtIndex(d)
        
        NSLog("answer is \(answers)")
    }
    
    
    /*
    pickerに表示する列数を返すデータソースメソッド.
    (実装必須)表示列
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    /*
    pickerに表示する行数を返すデータソースメソッド.
    (実装必須)表示個数
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    /*
    pickerに表示する値を返すデリゲートメソッド.表示内容
    */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    
    @IBAction func enter(button:UIButton){
        //判定
        var hit : Int = 0
        var blow : Int = 0
        
        NSLog("************")
        count++
        NSLog("count : \(count)")
        
        for i in 0 ..< 4 {
            //選択されている値のインデックス番号を取得する
            let selectedNumber = pickerView.selectedRowInComponent(i)
            let answer = answers[i]
            NSLog("\(selectedNumber) -> \(answer)")
            
            // hitとblowの判定
            switch(selectedNumber)
            {
            case answer:
                hit++ // selectedNumber == answer のとき実行される
                break
            case answers[0]:
                blow++ // selectedNumber == answers[0] のとき実行される
            case answers[1]:
                blow++ // selectedNumber == answers[1] のとき実行される
            case answers[2]:
                blow++ // selectedNumber == answers[2] のとき実行される
            case answers[3]:
                blow++ // selectedNumber == answers[3] のとき実行される
            default:
                break;
            }
        }
        
        NSLog("\(hit)hit")
        
        // 答えが合ったらクリアと表示、違う時は現在の結果を表示
        if (hit == 4) {
            label.text = "クリア！"
            label.textColor = UIColor.redColor()
            button.enabled = false
        } else {
            label.text = "\(hit)Hit！\(blow)Blow！"
            textView.text = "\(hit)Hit！\(blow)Blow！\n" + textView.text
        }
    }
}

