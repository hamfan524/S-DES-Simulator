//
//  SecondViewController.swift
//  S-DES_program
//
//  Created by 최동호 on 2021/11/21.
//


/* 한글은 2Byte인데 어떻게 8 비트씩 나누어서 표현?
 -> 유니코드로 변환 했을 때 255값을 넘어가면 앞에 8비트와 뒤에 8비트로 나누어서 암호화 후 마지막에 합치기로 구상
* EP와 IP XOR 구현 완료
* 2021/11/23 S박스 구현 완료 */

/* SBox 계산 하는 함수 구현 완료
* 암호화 완료
* 복호화 완료 - 아직 문자 1개 밖에 암호화가 진행되지 않음
* 2021/11/30 영어 문장까지 암호화 복호화 구현완료 */

/* 2021/12/01 도움말 구현완료 - 12/02 Git에 Url인코딩완료 */

//한글 암호화, 복호화 미구현
//시간이 지남으로 순차적으로 나타나는 것 아직 미구현 -> async/await
//값이 잘못 입력 되었을 때 오류 처리 미구현

/* 2021/12/04 한글 문장까지 암호화, 복호화 구현 완료 */
/* 2021/12/05 오류처리 try catch문 실패 -> 아쉽지만 if문으로 해결*/

/* 2021/12/06 async/await은 실패 -> 미리 값을 구해놓고 순차적으로 뿌려주는 형식으로 변경 - 완성

 * makeP10 - 10bit의 키를 P10의 순열로 치환하는 함수
* leftShift - 왼쪽으로 Shift해주는 함수
* makeK - 8bit의 k값 생성해주는 함수

* makeIp - 평문(8bit) IP의 순서로 치환 (한글일 시 16bit
* makefk - 키값을 넣어 fk로 변환해주는 함수
* xor - xor연산 해주는 함수
* sBox -  SBOX 함수
* makeSwitch - switch 해주는 함수
* makeToStr - 유니코드를 문자열로 변환 해주는 함수
* make16 - 문자열을 16자리로 변환 해주는 함수
* run - 암호화와 복호화 시작하는 함수
 */

import UIKit
import Foundation

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var firstPlain: UITextField!
    @IBOutlet weak var firstKey: UITextField!
    
    @IBOutlet weak var p10: UITextField!
    @IBOutlet weak var firstShift: UITextField!
    @IBOutlet weak var k1: UITextField!
    @IBOutlet weak var secondShift: UITextField!
    @IBOutlet weak var k2: UITextField!
    
    //암호화 텍스트 필드
    @IBOutlet weak var IP: UITextField!
    @IBOutlet weak var fk: UITextField!
    @IBOutlet weak var switchText: UITextField!
    @IBOutlet weak var fk2: UITextField!
    @IBOutlet weak var IP_: UITextField!
    @IBOutlet weak var encryption: UITextField!
    
    //복호화 텍스트 필드
    @IBOutlet weak var encryption2: UITextField!
    @IBOutlet weak var IP2: UITextField!
    @IBOutlet weak var fk_: UITextField!
    @IBOutlet weak var switchText2: UITextField!
    @IBOutlet weak var fk_2: UITextField!
    @IBOutlet weak var IP_2: UITextField!
    @IBOutlet weak var decryption: UITextField!
    
    var receivedPlain : String = "최동호"
    var receivedKey : String = "123"
    
    var arr: [String] = []
    var arr_: [String] = []
    
    let s0 = [[1, 0, 3, 2], [3, 2, 1, 0], [0, 2, 1, 3], [3, 1, 3, 2]]
    let s1 = [[0, 1, 2, 3], [2, 0, 1, 3], [3, 0, 1, 0], [2, 1, 0, 3]]
    
    var k_1 : String = ""
    var k_2 : String = ""
    
    var j = 1
    var t = 0.3
    
    let startTime = Date().timeIntervalSince1970

    override func viewDidLoad()  {
        super.viewDidLoad()
    
        self.firstPlain?.text = receivedPlain
        self.firstKey?.text = receivedKey
        
        let p10str = makeP10()
        self.p10?.text = p10str
        
        let firstShift_ = leftShift(str: p10str)
        self.firstShift.text = firstShift_
        
        let k1_ = makeK(str: firstShift_)
        self.k1.text = k1_
        
        let sShift = leftShift(str: firstShift_)
        let secondShift_ = leftShift(str: sShift)
        self.secondShift.text = secondShift_
        
        let k2_ = makeK(str: secondShift_)
        self.k2.text = k2_

        k_1 = k1_
        k_2 = k2_
    

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        run(str: receivedPlain)
        
    }
    
    func makeP10() -> (String){ // 10bit의 키를 P10의 순열로 치환하는 함수
        
        let p_10 = Int(receivedKey)!
        let binary: String = String(p_10, radix: 2)
        let b = Int(binary)!
        let b_10: String = String(format: "%010d", b)
        
        arr = Array()
        arr_ = Array()
        
        for i in b_10{
            arr.append(String(i))
        }
        
        arr_.append(arr[2])
        arr_.append(arr[4])
        arr_.append(arr[1])
        arr_.append(arr[6])
        arr_.append(arr[3])
        arr_.append(arr[9])
        arr_.append(arr[0])
        arr_.append(arr[8])
        arr_.append(arr[7])
        arr_.append(arr[5])

        let result = arr_.joined()
        
        return result
    }
    
    func leftShift(str : String) -> (String){   //왼쪽으로 Shift해주는 함수

        arr = Array()
        arr_ = Array()
       
        for i in str{
            arr.append(String(i))
        }
        
        arr_.append(arr[1])
        arr_.append(arr[2])
        arr_.append(arr[3])
        arr_.append(arr[4])
        arr_.append(arr[0])
        arr_.append(arr[6])
        arr_.append(arr[7])
        arr_.append(arr[8])
        arr_.append(arr[9])
        arr_.append(arr[5])
        
        let result = arr_.joined()
        return result
    }
    
    func makeK(str : String) -> (String){   //8bit의 k값 생성해주는 함수
        
        arr = Array()
        arr_ = Array()
        
        for i in str{
            arr.append(String(i))
        }
        
        arr_.append(arr[5])
        arr_.append(arr[2])
        arr_.append(arr[6])
        arr_.append(arr[3])
        arr_.append(arr[7])
        arr_.append(arr[4])
        arr_.append(arr[9])
        arr_.append(arr[8])
        
        let result = arr_.joined()
        return result
    }
    
    //평문 변환 시작
    func run(str : String){
        arr = Array()
        arr_ = Array()
        
        var number :Int = 0
        var binary_ : String = ""
        
        
        //암호화 변수
        var Ip : String = ""
        var aIp : [String] = []
        var fIp : [String] = []
        var sIp : [String] = []
        var fk_1 : String = ""
        var s : String = ""
        var fk_2 : String = ""
        var Ip_ : String = ""
        var eText : [String] = []
        var save : String = ""
        var fin : [String] = []
        
        
        //복호화 변수
        var Ip2 : String = ""
        var dfk_1 : String = ""
        var s2 : String = ""
        var dfk_2 : String = ""
        var Ip_2 : String = ""
        var dText : [String] = []
        
        for i in str{
            arr.append(String(i))
        }
        

        //암호화
        for i in arr{
            aIp = Array()
            fIp = Array()
            sIp = Array()
            fin = Array()
            
            number = Int(UnicodeScalar(i)!.value)

            binary_ = String(number, radix: 2)
            
            Ip = makeIp(str : binary_)
            
            if Ip.count < 9{    // 숫자 또는 영어일때
                
                fk_1 = makefk(str: Ip, k: k_1)
            
                s = makeSwitch(str: fk_1)
            
                fk_2 = makefk(str: s, k: k_2)
            
                Ip_ = makeIp2(str: fk_2)
            
                eText.append(makeToStr(str: Ip_))
            }
            else {              // 한글일때
                for j in Ip{
                    aIp.append(String(j))
                }
                for k in 0...7{
                    fIp.append(aIp[k])
                }
                for k in 8...15{
                    sIp.append(aIp[k])
                }
                
                Ip = fIp.joined()
            
                fk_1 = makefk(str: Ip, k: k_1)
               
                s = makeSwitch(str: fk_1)
        
                fk_2 = makefk(str: s, k: k_2)
            
                save = makeIp2(str: fk_2)
        
                Ip = sIp.joined()
            
                fk_1 = makefk(str: Ip, k: k_1)
        
                s = makeSwitch(str: fk_1)
            
                fk_2 = makefk(str: s, k: k_2)

                Ip_ = makeIp2(str: fk_2)
           
                for j in save{
                    fin.append(String(j))
                }
                for j in Ip_{
                    fin.append(String(j))
                }
                eText.append(makeToStr(str: fin.joined()))
                
            }
            
        }

        //복호화
        for i in eText{
            
            aIp = Array()
            fIp = Array()
            sIp = Array()
            fin = Array()
            number = Int(UnicodeScalar(i)!.value)
            
            binary_ = String(number, radix: 2)
            
            Ip2 = makeIp(str: binary_)
            
            if Ip2.count < 9{       // 숫자 또는 영어일때
                
            
                dfk_1 = makefk(str: Ip2, k: k_2)
           
                s2 = makeSwitch(str: dfk_1)
            
                dfk_2 = makefk(str: s2, k: k_1)
            
                Ip_2 = makeIp2(str: dfk_2)
                
                dText.append(makeToStr(str: Ip_2))
                
            }
            else{               // 한글일때
                for j in Ip2{
                    aIp.append(String(j))
                }
                for k in 0...7{
                    fIp.append(aIp[k])
                }
                for k in 8...15{
                    sIp.append(aIp[k])
                }
                Ip2 = fIp.joined()
            
                dfk_1 = makefk(str: Ip2, k: k_2)
            
                s2 = makeSwitch(str: dfk_1)
            
                dfk_2 = makefk(str: s2, k: k_1)
            
                save = makeIp2(str: dfk_2)
                
                Ip2 = sIp.joined()
            
                dfk_1 = makefk(str: Ip2, k: k_2)
            
                s2 = makeSwitch(str: dfk_1)
            
                dfk_2 = makefk(str: s2, k: k_1)
            
                Ip_2 = makeIp2(str: dfk_2)
                
                
                for j in save{
                    fin.append(String(j))
                }
                for j in Ip_2{
                    fin.append(String(j))
                }
                
                dText.append(makeToStr(str: fin.joined()))
            }
         
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {   // 미리 구해 둔 값을 시간순으로 뿌려줌
                self.IP.text = Ip
            }
            
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.fk.text = fk_1

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.switchText.text = s

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.fk2.text = fk_2

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.IP_.text = Ip_

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.encryption.text = eText.joined()

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.encryption2.text = eText.joined()

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.IP2.text = Ip2

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.fk_.text = dfk_1
            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.switchText2.text = s2

            }
            t += 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.fk_2.text = dfk_2

            }
            t += 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                self.IP_2.text = Ip_2

            }
            t += 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
                
                self.decryption.text = dText.joined()

            }
            
        }
        

    }
    
    func makeIp(str : String) -> (String){          // 평문(8bit) IP의 순서로 치환 (한글일 시 16bit)
            
        arr = Array()
            
        var resultArr: [String] = []
        let binary = Int(str)!
        var strBinary : String = ""
        var strBinary2 : String = ""
            
            //영어일때
        if binary <= 11111111{
                
            strBinary = String(format: "%08d", binary)
                
            for i in strBinary{
                arr.append(String(i))
            }
                
            resultArr.append(arr[1])
            resultArr.append(arr[5])
            resultArr.append(arr[2])
            resultArr.append(arr[0])
            resultArr.append(arr[3])
            resultArr.append(arr[7])
            resultArr.append(arr[4])
            resultArr.append(arr[6])
                
        }else{ //한글일때 - 아직 구현 못함
            strBinary2 = make16(str: String(binary))
            for i in strBinary2{
                arr.append(String(i))
            }
            resultArr.append(arr[1])
            resultArr.append(arr[5])
            resultArr.append(arr[2])
            resultArr.append(arr[0])
            resultArr.append(arr[3])
            resultArr.append(arr[7])
            resultArr.append(arr[4])
            resultArr.append(arr[6])
                
            resultArr.append(arr[9])
            resultArr.append(arr[13])
            resultArr.append(arr[10])
            resultArr.append(arr[8])
            resultArr.append(arr[11])
            resultArr.append(arr[15])
            resultArr.append(arr[12])
            resultArr.append(arr[14])
             
        }
            
        let result = resultArr.joined()
            
        return result
    }
        
        func makeIp2(str : String) -> (String){
            
            arr = Array()
            
            var resultArr: [String] = []
            let binary = Int(str)!
          

            let strBinary: String = String(format: "%08d", binary)
            
        
            for i in strBinary{
                arr.append(String(i))
                    
            }
            
            resultArr.append(arr[3])
            resultArr.append(arr[0])
            resultArr.append(arr[2])
            resultArr.append(arr[4])
            resultArr.append(arr[6])
            resultArr.append(arr[1])
            resultArr.append(arr[7])
            resultArr.append(arr[5])
            

            return resultArr.joined()
        }
    
    func makefk(str:String, k:String) -> String{        // 키값을 넣어 fk로 변환해주는 함수
        var arrL: [String] = []
        var arrR: [String] = []
        
        var eplist: [String] = []
        
        var epllist : [String] = []
        var eprlist : [String] = []
        
        
        var lsbox : [String] = []
        var rsbox : [String] = []
        
        var p4list :[String] = []
        var result: [String] = []
        
        var e: String = " "
        
        j = 1
        
        for i in str{
            if j <= 4{
                arrL.append(String(i))
                
            }else{
                arrR.append(String(i))
            }
            j += 1
        }
        
        eplist.append(arrR[3])
        eplist.append(arrR[0])
        eplist.append(arrR[1])
        eplist.append(arrR[2])
        eplist.append(arrR[1])
        eplist.append(arrR[2])
        eplist.append(arrR[3])
        eplist.append(arrR[0])
        

        e = xor(str: eplist.joined(), key: k)
        
        j = 1
        
        for i in e{
            if j <= 4{
                epllist.append(String(i))
                
            }else{
                eprlist.append(String(i))
                
            }
            
            j += 1
        
        }
        
        let lsbox_ = sBox(str: epllist, s: s0)
        let rsbox_ = sBox(str: eprlist, s: s1)
        
        for i in lsbox_{
            lsbox.append(String(i))
        }
        for i in rsbox_{
            rsbox.append(String(i))
        }
        
        p4list.append(lsbox[1])
        p4list.append(rsbox[1])
        p4list.append(rsbox[0])
        p4list.append(lsbox[0])
        
        let L = xor(str: p4list.joined(), key: arrL.joined())
        
        for i in L{
            result.append(String(i))
        }
        for i in arrR{
            result.append(String(i))
        }
        
        return result.joined()
    }
    
    func xor(str: String , key : String) -> String {    // xor연산 해주는 함수
        
        var encrypted : [String] = []
        var keylist : [String] = []
        var resultlist : [String] = []
        
        for i in str{
            encrypted.append(String(i))
        }
        for i in key{
            keylist.append(String(i))
        }
        
        for i in 0...(encrypted.count - 1){
            if encrypted[i] == keylist[i]{
                resultlist.append("0")
            }else{
                resultlist.append("1")
            }
        }
        
        let result = resultlist.joined()
        
        return result
    }
    
    func sBox(str: [String], s: [[Int]]) -> String {        // SBOX 함수
        
        var ff : [String] = []
        var st : [String] = []
       
        ff.append(str[0])
        ff.append(str[3])
        st.append(str[1])
        st.append(str[2])
        
        let ff_ = ff.joined()
        let st_ = st.joined()
        
        let decimal_1 : Int = Int(ff_, radix: 2)!
        let decimal_2 : Int = Int(st_, radix: 2)!
        
        let number = s[decimal_1][decimal_2]
        let binary: String = String(number, radix: 2)
        
        let b = Int(binary)!
        
        let binary_ : String = String(format: "%02d", b)
        
        var resultlist : [String] = []
        
        for i in binary_{
            resultlist.append(String(i))
        }
        
        return resultlist.joined()
        
    }
    
    func makeSwitch(str: String) -> String{     //switch 해주는 함수
        arr = Array()
        arr_ = Array()
        
        for i in str{
            arr.append(String(i))
        }
        arr_.append(arr[4])
        arr_.append(arr[5])
        arr_.append(arr[6])
        arr_.append(arr[7])
        arr_.append(arr[0])
        arr_.append(arr[1])
        arr_.append(arr[2])
        arr_.append(arr[3])
        
        return arr_.joined()
    }
    
    func makeToStr(str: String) -> String{          // 유니코드를 문자열로 변환 해주는 함수
        
        let decimal : Int = Int(str, radix: 2)!
        
        let result : String =  String(UnicodeScalar(decimal)!)
        
        return result
    }
    
    func make16(str : String) -> String{            // let b_10: String = String(format: "%010d", b)
                                                    // 위의 자리수 만드는 문법이 10자리까지밖에 되지 않아 조잡하지만 16자리를 만들어주는 함수를 제작,,,
        var array : [String] = []
        if str.count == 9{
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 10{
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 11{
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 12{
            array.append("0")
            array.append("0")
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 13{
            array.append("0")
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 14{
            array.append("0")
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 15{
            array.append("0")
            for i in str{
                array.append(String(i))
            }
        }else if str.count == 16{
            for i in str{
                array.append(String(i))
            }
        }
        
     
        return array.joined()
    }
    
    
    @IBAction func backButton(_ sender: Any) {              
        self.dismiss(animated: true, completion: nil)
    }
    
}
