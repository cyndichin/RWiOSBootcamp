import UIKit

var str = "Hello, playground"


struct Product {
    var id: Int
    var product_type: String
    var options: Options
}

struct Options {
    var gender: String
    var style: String
    var size: String
}

let options = Options(gender: "male", style: "matte", size: "medium")
let product = Product(id: 2, product_type: "tshirt", options: options)

let options1 = Options(gender: "female", style: "glossy", size: "small")
let product1 = Product(id: 2, product_type: "tshirt", options: options1)

let products = [product, product1]

var search = [String:[Options]]()

// initially to create hashmap
for prod in products {
    if let value = search[prod.product_type] {
        search[prod.product_type] = value + [prod.options]
    } else {
        search[prod.product_type] = [prod.options]
    }
}

let items = search["tshirt"]

for item in items {
    item()
}


let sizes = items!.filter({$0.size == "medium"})
for size in sizes {
    print(size.style)
}
