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

NavigationView
NavigationLink

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

/*:
  1. Structures
  2. Enumerations
  3. Strings
  4. Integers
  5. Dictionaries
  6.Arrays
 */

```Reference type``` : each instance shares a single copy of data

/*:
  1. Class
  2. Closure
  3. Function
 */
