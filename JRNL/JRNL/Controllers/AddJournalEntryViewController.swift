//
//  AddJournalEntryViewController.swift
//  JRNL
//
//  Created by 조영민 on 3/26/25.
//

import UIKit

class AddJournalEntryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var newJournalEntry: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare\(String(describing: segue.identifier))")
        if let segueIndetifier = segue.identifier {
            if segueIndetifier == "save" {
                let title = titleTextField.text ?? ""
                let body = bodyTextView.text ?? ""
                let photo = photoImageView.image
                let rating = 3
                newJournalEntry = JournalEntry(rating: rating, title: title, body: body, photo: photo)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddJournalEntryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("1 textFieldDidBeginEditing")
    }
}

// MARK: - UITextViewDelegate
extension AddJournalEntryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("2 textViewDidBeginEditing")
    }
}
