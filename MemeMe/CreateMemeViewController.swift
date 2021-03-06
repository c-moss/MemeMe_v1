//
//  CreateMemeViewController.swift
//  MemeMe
//
//  Created by Campbell Moss on 10/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let defaultTopText = "TOP"
    let defaultBottomText = "BOTTOM"

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var actionBar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // Maintain a reference to the current active text field so that we can check if it gets obscured by the keyboard
    var activeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.delegate = self
        bottomLabel.delegate = self
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide the status bar when we come back to the view controller
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Set some text attributes
        var textAttributes = [String: AnyObject]()
        textAttributes[NSStrokeColorAttributeName] = UIColor.blackColor()
        textAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textAttributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        textAttributes[NSStrokeWidthAttributeName] = -3.0   //negative value means we see the foreground color
        
        // Retrieve the existing default paragraph style from the top text field and use it in our new textAttributes, because otherwise it gets cleared and we lose center alignment
        let defaultParagraphStyle = topLabel.defaultTextAttributes[NSParagraphStyleAttributeName]
        textAttributes[NSParagraphStyleAttributeName] = defaultParagraphStyle
        
        topLabel.defaultTextAttributes = textAttributes
        bottomLabel.defaultTextAttributes = textAttributes
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let shareActivity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareActivity.completionWithItemsHandler = { activity, success, items, error in
            if (success) {
                self.save(memedImage)
                shareActivity.dismissViewControllerAnimated(true, completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(shareActivity, animated: true, completion: nil)
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        topLabel.text = defaultTopText
        bottomLabel.text = defaultBottomText
        imagePickerView.image = nil
        shareButton.enabled = false
        if (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count > 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        presentImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        presentImagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    /**
     Present an image picker controller
     - parameter sourceType: A UIImagePickerControllerSourceType specifying the source of the image picker
     */
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    /**
     Handle the user selecting an image in the image picker. 
     Set the contents of the image view to the selected image.
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
        }
    }
    
    /**
     Handle the user cancelling the image picker. 
     Just dismiss the image picker.
     */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     Handle text field editing.
     */
    func textFieldDidBeginEditing(textField: UITextField) {
        // Set global reference for current active text field
        activeField = textField
        
        // If the current text is either of the default values, clear. Otherwise let the user edit the existing text.
        if textField.text == defaultTopText || textField.text == defaultBottomText {
            textField.text = ""
        }
    }
    
    /**
     Called when editing is about to end
     */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        // Clear the global reference for current active text field
        activeField = nil
        
        // If the value of the text field is empty, revert to the default value for the text field
        if textField.text == "" {
            if textField == topLabel {
                textField.text = defaultTopText
            } else if textField == bottomLabel {
                textField.text = defaultBottomText
            }
        }
        
        // Always return true - we don't have any situations where we'd want to prevent edit ending
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // End editing when user presses return
        textField.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // End editing (and hide the keyboard) when a touch is detected
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    /**
     Subscribe to keyboard show / hide notifications
     */
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:" , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:" , name: UIKeyboardWillHideNotification, object: nil)

    }
    
    /**
     Unsubscribe from keyboard show / hide notifications
     */
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
     Notification handler that gets called when the keyboard is shown
     - parameter notification: Keyboard shown notification
     */
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        
        var viewRect = view.frame
        let keyboardHeight = keyboardSize.CGRectValue().height
        viewRect.size.height -= keyboardHeight
        
        // If the keyboard obscures the active text field, adjust view position
        if !viewRect.contains(activeField.frame.origin) {
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    /**
     Notification handler that gets called when the keyboard is hidden
     - parameter notification: Keyboard hidden notification
     */
    func keyboardWillHide(notification: NSNotification) {
        // Reset view origin to 0
        view.frame.origin.y = 0
    }
    
    /**
     Save the meme to a Meme object
     - parameter memedImage: UIImage representing the selected image with the meme text applied
     */
    func save(memedImage: UIImage) {
        // Create the Meme object
        let meme = Meme(topText: topLabel.text, bottomText: bottomLabel.text, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        appDelegate.saveMemes()
    }
    
    /**
     Apply meme text to the selected image by taking a screenshot of the view
     - returns: A UIImage from the screenshot
    */
    func generateMemedImage() -> UIImage {
        
        // Hide toolbars
        actionBar.hidden = true
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbars
        actionBar.hidden = false
        toolbar.hidden = false
        
        return memedImage
    }
}

