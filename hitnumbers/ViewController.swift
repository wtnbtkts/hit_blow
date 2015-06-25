//
//  ViewController.swift
//  hitnumbers
//
//  Created by Takatoshi Watanabe on 2015/06/22.
//  Copyright (c) 2015年 渡辺 貴俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet var textView: UITextView!
    
    //当たった回数
    var hit:Int = 0
    //挑戦した回数
    var count:Int = 0
    //picker viewで選択したインデックス番号
    var a: Int = 0
    
    // 全て文字列の空の配列を宣言
    var numbers: [String] = []
    var answers = [Int](count: 100, repeatedValue: 0)///////////////////Int型の配列をとりあえず１００個作る、中身は全部０
    var array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Delegateを設定する.
        pickerView.delegate = self
        
        // DataSourceを設定する.
        pickerView.dataSource = self
        
        textView.editable = false
        textView.text = ""
        
        //        var answers:[String] = []///////////////////////////上で宣言してるのでこれは必要ないですね
        var n = answers.count
        println(n)
        //answers = [[NSMutableArray alloc] init]
        
        numbers = ["0","1","2","3","4","5","6","7","8","9"]
        
        for var i = 0 ; i < pickerView.numberOfComponents ; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            var random = arc4random_uniform(10);
            answers[i] = Int(random)
        }
        
        for string in answers{
            println("\(string)");
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return numbers[row] as String
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        a = row
        println("列: \(row)")
        println("値: \(numbers[row])")
    }
    
    
    @IBAction func enter(button:UIButton){
        //var tappedButton:UIButton = sender as UIButton
        //tappedButton.setTitle("tapped", forState:UIControlState.Normal)
        
        count++;
        if (count == 5) {
            var sum = 0;
            
            for var i = 0 ; i < pickerView.numberOfComponents ; i++ {
                sum = sum + Int(answers[i])//.toInt()!)
            }
            
            var lastString:String! = textView.text;
            var string:String! = NSString(format:"答えの数の合計は%dだよ！\n", sum) as String
            //文字列結合
            textView.text = string + lastString
            
            //        NSString *lastString = textView.text;
            //        NSString *string = [NSString stringWithFormat:
            //                            @"１つ目の答えは%@だよ！\n", answers[0]];
            //        textView.text = [string stringByAppendingString:
            //                         lastString];
        } else if (count == 10) {
            var num = answers[0]//.toInt()!;
            
            for var i = 0; i < pickerView.numberOfComponents ; i++ {
                if (num > answers[i]){//.toInt()!) {
                    num = answers[i]//.toInt()!;
                }
            }
            
            var lastString:String! = textView.text;
            var string:String! = NSString(format:"一番小さい数字は%dだよ！\n", num) as String
            //文字列結合
            textView.text = string + lastString
            
            //        NSString *lastString = textView.text;
            //        NSString *string = [NSString stringWithFormat:
            //                            @"３つ目の答えは%@だよ！\n", answers[2]];
            //        textView.text = [string stringByAppendingString:
            //                         lastString];
        }
        
        hit = 0;
        
        for var i = 0 ; i < pickerView.numberOfComponents; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            //選択されている値のインデックス番号を取得する
            var answer:Int! = a
            var answer2 = answers[i]
            
            //numbers[[pickerView,selectedRowInComponent,i]]
            
            if (answer == answer2) {
                hit = hit + 1;
            }
        }
        
        
        if (hit == 4) {
            label.text = "クリア！";
            //textView.text = [NSString stringWithFormat:@"クリアまでの回数：%d", count];
            button.enabled = false;
        } else {
            label.text = NSString(format:"%d個正解！", hit) as String
            var lastString:String! = textView.text;
            var string:String! = NSString(format:"%d個正解！\n", hit) as String
            textView.text =  string + lastString
        }
        
        
    }
}


/*
        for var i = 0 ; i < pickerView.numberOfComponents; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            //選択されている値のインデックス番号を取得する
            var answer:Int! = a
            var answer2 = answers[i]
            
            //numbers[[pickerView,selectedRowInComponent,i]]
            
            if (answer == answer2) {
                hit = hit + 1;
            }
        }
        
        if (hit == 4) {
            label.text = "クリア！";
            //textView.text = [NSString stringWithFormat:@"クリアまでの回数：%d", count];
            button.enabled = false;
        } else {
            label.text = NSString(format:"%d個正解！", hit) as String
            //                var lastString:String! = textView.text;
            var string:String! = NSString(format:"%d個正解！\n", hit) as String
            textView.text = textView.text + string //+ lastString
        }
        
        
    }
}
*/


        /*
        for var i = 0 ; i < pickerView.numberOfComponents; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            //選択されている値のインデックス番号を取得する
            var answer:Int! = a
            var answer2 = answers[i]
            
            //numbers[[pickerView,selectedRowInComponent,i]]
            
            if (answer == answer2) {
                hit = hit + 1;
            }
            
            if (hit == 4) {
                label.text = "クリア！";
                //textView.text = [NSString stringWithFormat:@"クリアまでの回数：%d", count];
                button.enabled = false;
            } else {
                
                label.text = NSString(format:"%d個正解！\n", hit) as String
                var lastString:String! = textView.text;
                var string:String! = NSString(format:"%d個正解！\n", hit) as String
                textView.text = string //+ lastString
            }
            
        }
    }*/





/*
//
//  ViewController.swift
//  hitnumbers
//
//  Created by Takatoshi Watanabe on 2015/06/22.
//  Copyright (c) 2015年 渡辺 貴俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet var textView: UITextView!
    
    //当たった回数
    var hit:Int = 0
    //挑戦した回数
    var count:Int = 0
    //picker viewで選択したインデックス番号
    var a: Int = 0
    
    // 全て文字列の空の配列を宣言
    var numbers: [String] = []
    var answers = [Int](count: 100, repeatedValue: 0)///////////////////Int型の配列をとりあえず１００個作る、中身は全部０
    var array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        
        // Delegateを設定する.
        pickerView.delegate = self
        
        // DataSourceを設定する.
        pickerView.dataSource = self
        
        textView.editable = false
        textView.text = ""
        
        var answers:[String] = []
        var n = answers.count
        println(n)
        //answers = [[NSMutableArray alloc] init]
        
        numbers = ["0","1","2","3","4","5","6","7","8","9"]
        
        for var i = 0 ; i < pickerView.numberOfComponents ; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            var random = arc4random_uniform(10);
            //answers[i] = NSString(format:"%d", random) as String
        }
        
        for string in answers{
            println("\(string)");
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return numbers[row] as String
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        a = row
        println("列: \(row)")
        println("値: \(numbers[row])")
    }
    
    
    @IBAction func enter(button:UIButton){
        //var tappedButton:UIButton = sender as UIButton
        //tappedButton.setTitle("tapped", forState:UIControlState.Normal)
        
        count++;
        if (count == 5) {
            var sum = 0;
            
            for var i = 0 ; i < pickerView.numberOfComponents ; i++ {
                sum = sum + Int(answers[i])//.toInt()!)
            }
            
            var lastString:String! = textView.text;
            var string:String! = NSString(format:"答えの数の合計は%dだよ！\n", sum) as String
            //文字列結合
            textView.text = string + lastString
            
            //        NSString *lastString = textView.text;
            //        NSString *string = [NSString stringWithFormat:
            //                            @"１つ目の答えは%@だよ！\n", answers[0]];
            //        textView.text = [string stringByAppendingString:
            //                         lastString];
        } else if (count == 10) {
            var num = answers[0]//.toInt()!;
            
            for var i = 0; i < pickerView.numberOfComponents ; i++ {
                if (num > answers[i])//.toInt()!)
                {
                    num = answers[i]//.toInt()!;
                }
            }
            
            var lastString:String! = textView.text;
            var string:String! = NSString(format:"一番小さい数字は%dだよ！\n", num) as String
            //文字列結合
            textView.text = string + lastString
            
            //        NSString *lastString = textView.text;
            //        NSString *string = [NSString stringWithFormat:
            //                            @"３つ目の答えは%@だよ！\n", answers[2]];
            //        textView.text = [string stringByAppendingString:
            //                         lastString];
        }
        
        hit = 0;
        
        for var i = 0 ; i < pickerView.numberOfComponents; i++ {
            // do something
            //NSLog("for statement i:\(i)")
            
            //選択されている値のインデックス番号を取得する
            var answer:Int! = a
            var answer2 = answers[i] 
            
            //numbers[[pickerView,selectedRowInComponent,i]]
            
            if (answer == answer2) {
                hit = hit + 1;
            }
            
            if (hit == 4) {
                label.text = "クリア！";
                //textView.text = [NSString stringWithFormat:@"クリアまでの回数：%d", count];
                button.enabled = false;
            } else {
                label.text = NSString(format:"%d個正解！", hit) as String
                var lastString:String! = textView.text;
                var string:String! = NSString(format:"%d個正解！\n", hit) as String
                textView.text = string + lastString
            }
            
        }
    }
}
*/
