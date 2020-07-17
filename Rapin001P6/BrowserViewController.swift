//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UISearchBarDelegate {
    
   // var webView: WKWebView!
    var passedPin: String? = "0000"
    var passedURL: URL?
    var homePage: String = "http://www.apple.com"
    let http = "https://www."
    

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var printPinToSearchBar: UILabel!
    @IBOutlet var webViewLink: WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
  /* programatic way of adding view, will use IB
         
        // need to create a confgurator
        let webConfig = WKWebViewConfiguration()
        
        //set up the webView programaticaly
        let safeTop:CGFloat = CGFloat(18.0)
        
        let webRect = CGRect(x: 0, y: safeTop, width: view.frame.width, height: view.frame.height - safeTop)
        webView = WKWebView(frame: webRect, configuration: webConfig)
        
        //set as delegate
        webView.uiDelegate = self
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
        
        
        // Do not forget to add view to root
        view.addSubview(webView)
         
*/
        webViewLink.uiDelegate = self
        webViewLink.navigationDelegate = self
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // upadte pin
        passedPin = PinDatabase.sharedInstance.lastPin
        if (PinDatabase.sharedInstance.pairDatabase[passedPin!] == nil){passedPin = "0000"}
        
        // diplay pin in browser
        printPinToSearchBar.text = passedPin
        searchBar.text = PinDatabase.sharedInstance.pairDatabase[passedPin!]?.absoluteString
        
        //load pin request
        if let request = PinDatabase.sharedInstance.returnURLRequest(pin: passedPin!){
            webViewLink.load(request)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Search Bar Delegate
    // function check weather to allow for the navigation request -> when you press a link in WKWebView
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //get the requesting url
        let navigationActionURL = String(describing: navigationAction.request.url!)
        //print for dev
        print(navigationActionURL)
        
        // do not load and update text field if page is a blank
        if (navigationActionURL != "about:blank"){
        searchBar.text = navigationActionURL
    
        decisionHandler(.allow)
            
        }
        else{
            decisionHandler(.cancel)
        }
    }
    
    //MARK: Search Bar Functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.keyboardType = .URL
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchText = searchBar.text!
        //the url has to have the correct htp or https otherwise will not load
        let page: String
        if ((searchText.range(of: http)) == nil) {
            page = http + searchText
        } else{
            page = searchText
        }
        
        // make a url
        let url = URL(string: page)
        
        // then make a URLRequest
        let request = URLRequest(url: url!)
        
        // last load the page
        webViewLink.load(request)
       // let
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
