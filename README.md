# iOS




### ContentView

The basic structure of the ContentView is 

```
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```


### How to add a button that will bring you to another screen 

```NavigationView``` < br>
```NavigationLink```

### What is the difference between ```struct``` and ```class```

```
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
```

### What are value types vs reference types?

```Value type``` : each instance keeps a unique copy of the data in memory  


  1. Structures
  2. Enumerations
  3. Strings
  4. Integers
  5. Dictionaries
  6.Arrays


```Reference type``` : each instance shares a single copy of data


  1. Class
  2. Closure
  3. Function

What this mean in practice is that when we create a class and assign a new value to a property the old instances of the class will be overwritten:

```
import UIKit 

class Donut{
    var icing = "chocolate"
}

var donut_one = Donut()
var donut_two = donut_one

//This print will return chocolate
print(donut_one.icing)

//However, if we initiate the second donut to lemon when we print the value the donut_one will be overwritten 
donut_two.icing = "lemon"

print(" The first donut icing is  \(donut_one.icing)")
print(" The second donut icing is  \(donut_one.icing)")


```
 
 
 ### String interpolation in swift
 
 print(" The first donut icing is  \(donut_one.icing)")
