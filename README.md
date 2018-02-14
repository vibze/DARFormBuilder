# DARFormBuilder

Library made to cut corners when making complex forms using UITableView.

### Installation using cocoapods

Add `pod DARFormBuilder` to your podfile and run `pod install`

### How to use

1. Instantiate a FormTableViewController
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
    TitleCell(text: "Title", fontSize: 30),
    
    // Plain text with small font
    DescriptionCell(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well.", fontSize: 12),
    
    // Static value with label on the left and value on the right
    StaticValueCell(label: "Price", value: "1000"),
    
    // Label on the left and a number with plus and minus buttons on the right
    NumDialInputCell(label: "Amount", value: 5, range: 1..<25) { amount in
        
    }),
    
    // Basic text input cell without label
    TextInputCell(text: "Name", placeholder: "Letters, words", keyboardType: .default, maxLength: 30) { text in
    
    }),
    
    // Date input cell without label
    DateInputCell(label: "Birthday", value: Date()) { date in
    
    }),
    
    // Labeled switch input cell
    SwitchInputCell(label: "Yes/No?", value: true) { value in 
    
    })
    
    // Clickable cell with disclosure indicator
    ClickableCell(label: "Click me") {
        
    }
    
    // Custom view cell
    CustomViewCell(customView: UIImageView(image: xxx"))
]
```

### List of available cell types

#### TitleCell
Cell for displaying form titles. Big font, contrasty color.

#### DescriptionCell
Cell for displaying long texts as descriptions or field clarifications.

#### StaticValueCell
Label and value for displaying static properties.

#### NumDialInputCell
Label with number dial. Values can be limited by range.

#### TextInputCell
Simple textView cell. Can be limited by max length.

#### TextFieldInputCell
Simple textField cell. Can be limited by max length.

#### DateInputCell
Date picker cell.

#### SwitchInputCell
Label with switch view on the right.

#### ClickableCell
Label with disclosure indicator. Clickable.

#### CustomViewCell
In case you want to display a custom view in a cell. Use auto-layout to stretch contentView.


## DARFormController

Framework offers a convenient controller for building forms. It is instantiated using a JSON configuration file, which can provide fields configurations, initial values and interaction logic.

Below is an annotated JSON config example

```Javascript
{
    "fields": [
        {
            "key": "name",
            "type": "textInput",
            "label": "Name",
            "maxLength": 60,
            "required": true
        },
        {
            "key": "hideFields",
            "type": "switchInput",
            "label": "Hide Fields",
            "hideFieldsIfChecked": [0]
        },
        ...
    ],
}
```

### Available field types and their settings

#### textInput

A simple textInput with floating label.

Params:

- `label: String = ""` -- Placeholder/floating label text
- `keyboardType: String(default|email|phone|number) = "default"` -- Keyboard type to display for this field
- `maxLength: Int = 0` -- Maximum text length
- `required: Bool = false` -- Field will not pass validation if text is not present

#### dateInput
Date input with floating label.

Params:
- label: String = "" -- Placeholder/floating label text
- inputMode: String(datetime|date|time) = "datetime" -- Date input mode to display for this field
- displayFormat: String = "dd.MM.yyyy" -- Display date format in (unicode format pattern)[http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns]
- valueFormat: String = “yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX” -- Field value format in (unicode format pattern)[http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns]
- required: Bool = false -- Field will not pass validation if text is not present

#### phoneInput
Phone input with floating label.

Params:
- label: String = "" -- Placeholder/floating label text
- displayFormat: String = "+7 ### ###-##-##"
- pickFromContacts: Bool = false -- Display pick from contacts button on the field
- required: Bool = false -- Field will not pass validation if text is not present

#### switchInput
Switch with label on the left.

Params:
- label: String = "" -- Label text
- hideFieldsIfChecked: [Int] = [] -- Form should hide fields at given indices if the switch is on

