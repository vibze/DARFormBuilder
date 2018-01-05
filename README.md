# DARFormBuilder

Library made to cut corners when making complex forms using UITableView.

### Installation using cocoapods

Add `pod DARFormBuilder, '~1.0.0'` to your podfile and run `pod install`

### How to use

1. Instantiate a FormController
```Swift
    let formController = FormController()
```

2. Add it to your controller's view:
```Swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(formController.view)
        formController.view.frame = view.bounds
        formController.delegate = self
        formController.dataSource = self
    }    
```

3. Configure your form fields
```Swift
formController.items = [
        .title(text: "Title"),
        .description(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well."),
        .staticValue(label: "Price", value: "1000"),
        .numDialInput(label: "Amount", key: "amount"),
        .textInput(label: "Name", placeholder: "Letters, words", keyboardType: .default, key: "name"),
        .dateInput(label: "Birthday", placeholder: "xx/xx/xxxx", key: "birthday"),
        .switchInput(label: "Yes/No?", key: "yesno")
]
```

4. Implement `FormControllerDelegate` and `FormControllerDataSource` to control form values.


### List of available cell types
```Swift
// Basic title. Big font, contrast font color.
case title(text: String)

// Description cell. Small font.
case description(text: String)

// Static value cell for displaying some static information.
case staticValue(label: String, value: String)

// Number dial. Label on left, dial on the right.
case numDialInput(label: String, key: String)

// Simple text input without label but with a placeholder.
case textInput(label: String, placeholder: String, keyboardType: UIKeyboardType, key: String)

// Same as above but uses a datepicker as inputview and 
// sends messages to a different delegate method
case dateInput(label: String, placeholder: String, key: String)

// Label and a switch. For boolean values.
case switchInput(label: String, key: String)
```