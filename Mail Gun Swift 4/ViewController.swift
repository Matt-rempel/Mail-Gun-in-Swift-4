//
//  ViewController.swift
//  Mail Gun Swift 4
//
//  Created by Matthew Rempel on 2018-02-24.
//  Copyright © 2018 Matthew Rempel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Call the send email function
        send_email()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func send_email() {
        var keys: NSDictionary?
        
        // Store your api key in the plist called Keys.plist
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
    
        if let dict = keys {
            let mailgunAPIPath:String! = dict["mailgunAPIPath"] as? String
            let emailRecipient:String! = "their_email@email.com"
            let fromAddress:String! = "from@email.com"
            let subject:String! = "New%20Message%21"
            let name:String! = "their_name"
            let text = "Hello: " + name + "\nThis is the body of the email"
            
            // Encode the message
            let encoded_text:String! = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
            // Create a session and fill it with the request
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: NSURL(string: mailgunAPIPath! + "from=NAME%20%3C\(fromAddress)%3E&to=\(emailRecipient!)&subject=\(subject)&text=" + encoded_text)! as URL)
    
            // POST and report back with any errors and response codes
            request.httpMethod = "POST"
    
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                if let error = error {
                    print(error)
                }
    
                if let response = response {
                    print("url = \(response.url!)")
                    print("response = \(response)")
                    let httpResponse = response as! HTTPURLResponse
                    print("response code = \(httpResponse.statusCode)")
                }
            })
            task.resume()
        }
    }
}

