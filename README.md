# DARFormBuilder

Library made to cut corners when making complex forms using UITableView.

### Installation using cocoapods

Add `pod DARFormBuilder, '~1.1.0'` to your podfile and run `pod install`

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
    }    
```

3. Configure your form fields
```Swift
formController.items = [
    
    // Plain text with big font
    TitleCell(text: "Title"),
    
    // Plain text with small font
    DescriptionCell(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well."),
    
    // Static value with label on the left and value on the right
    StaticValueCell(label: "Price", value: "1000"),
    
    // Label on the left and a number with plus and minus buttons on the right
    NumDialInputCell(label: "Amount") { amount in
        
    }),
    
    // Basic text input cell without label
    TextInputCell(label: "Name", placeholder: "Letters, words", keyboardType: .default) { text in
    
    }),
    
    // Date input cell without label
    DateInputCell(label: "Birthday", placeholder: "xx/xx/xxxx") { date in
    
    }),
    
    // Labeled switch input cell
    SwitchInputCell(label: "Yes/No?") { value in 
    
    })
    
    // Clickable cell with disclosure indicator
    ClickableCell(label: "Click me") {
        
    }
    
    // Custom view cell
    CustomViewCell(customView: UIImageView(image: xxx"))
]
```

### List of available cell types
```Swift

```
