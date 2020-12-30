//
//  ViewController.swift
//  AllFormatDocumentOpenandDragDropTableView
//
//  Created by Janarthan Subburaj on 30/12/20.
//

import UIKit
import WebKit
import MobileCoreServices


class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    var tableViewData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func OpenDocument(_ sender: Any) {
//        let url = Bundle.main.url(forResource: "SwiftBeginner", withExtension: "pdf")
//        if let url = url{
//            let webView = WKWebView(frame: view.frame)
//            let Url_Request = URLRequest(url:url)
//            webView.load(Url_Request)
//            view.addSubview(webView)
//        }
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing \(sandboxFileURL.path)")
                    let url = Bundle.main.url(forResource: "SwiftBeginner", withExtension: "pdf")
                    if let url = url{
                        let webView = WKWebView(frame: view.frame)
                        let Url_Request = URLRequest(url:sandboxFileURL)
                        webView.load(Url_Request)
                        print("Url_Request : \(Url_Request)")
                        print("selectedFileURL : \(selectedFileURL)")
                        print("sandboxFileURL : \(sandboxFileURL)")
                        view.addSubview(webView)
                    }

        }
        else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func EditBtn(_ sender: Any) {
        
    }
}



