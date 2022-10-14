
## 00. Blocks:
  - The block should be the last parameter passed to a method.
  - Placing an ampersand (&) before the name of the last variable triggers the conversion.
  - ### ex01:
    ```ruby
      def calculation(a, b, &foo)
        foo.call(a,b)
      end

      puts calculation(5, 6) { |a,b| a + b }
    ```
  - ### ex02:
    ```ruby
      def calculation(a, b)
        yield(a, b) # yield calls an implicit (unnamed) block
      end

      addition = lambda {|x, y| x + y}
      puts calculation(5, 5, &addition)
    ```

## 04. proc vs lambda
  - `puts lambda {}` => Proc.instance
  - `puts Proc.new()` => Proc.intance
  - diff:
    - lambda `return`: act like normal return from method
    - Proc `return`: return inside and `also` the method call it
      - ex:
        ```ruby
          def a_method
            Proc.new { return 0 }.call
            return 999
          end

          puts a_method
        ```
      -  => `output`: 0
      -  => `surprise`

## explixit call && implicit call
  - implicit: short version of `Kernel#lambda`
    `short = ->(a,b) { a + b }`

  - explicit: long <=> `Kernel#lambda`
    `long = lambda (a,b) { |a,b| a + b }`

  - explicit: `Proc.new` idential to `Kernel#proc`
    `kernel_proc = proc { |a,b| a + b }`
    `proc_new = Proc.new { |a,b| a + b }`



## 01.03 Classes: Inheritance
#### 01.03 Redefining, overriding, and super
  - Redefining:
    - replacing one method with another
    - original methhod is lost
    - happen on the original class
    - ex:
    ```ruby
      class Fixnum
        def +(x)
            42
        end
      end
    ```

  - Overriding:
    - child class redefine method of parent class
    - the original method from parent class doesn't affect
    ```ruby
      class MyArray < Array
        def map
          'in roll and roll'
        end
      end
    ```

  - Super Powered:
    - child class do something in addition to what the parent method did
    - re-use behaviour that exists in a parent class
    - then modify to suit the needs of the child class
    ```ruby
      class Animal
        def move
          'I can move'
        end
      end

      class Bird < Animal
        def move
          super + ' by flying'
        end
      end

      class Duck < Animal
        def move
          super + ' by walk and swim'
        end
      end
    ```

## 02. More Classes
### 02.00. Instance Variables and Accessors
  -


## class variable

## class hash
  - `==`
  - `eql?`
  - `hash`
  - ```ruby
      class Item
        attr_reader :item_name, :qty

        def initialize(name, qty)
          @item_name = name
          @qty = qty
        end

        def to_s
          "Item: (#{@item_name}, #{@qty})"
        end

        def hash
          self.item_name.hash ^ self.qty.hash
        end

        def eql?(other_item)
          puts "#eql? invoke"
          @item_name == other_item.item_name && @qty == other_item.qty
        end

      end
    ```

    - `items = [Item.new("abcd", 1), Item.new("abcd", 1), Item.new("abcd", 1)]`

    - ```ruby
      class Item

        attr_reader :item_name, :quantity, :supplier_name, :price

        def initialize(item_name, quantity, supplier_name, price)
          @item_name = item_name
          @quantity = quantity
          @supplier_name = supplier_name
          @price = price
        end

        def ==(other_item)
          @item_name == other_item.item_name &&
          @quantity == other_item.quantity &&
          @supplier_name == other_item.supplier_name &&
          @price == other_item.price
        end

        def eql?(other_item)
          self == other_item
        end

        def hash
          @item_name.hash ^ @quantity.hash ^ @supplier_name.hash ^ @price.hash
        end
      end
    ```


#### 02.04. Serializing

## 03. Advanced Arrays
  - 03.00. Ripping the Guts
  - 03.01. Using the API
  - 03.02. Stacks and Queues
  - 03.03. Alternative Uses


#### 03.00. Ripping the Guts
  - The splat __========>    *      <========__
    - `car, *cdr = [41,42,43]`
    - => `car = 41`
    - => `cdr = [42,43]`
    - `*initial, second_last, last = [42, 43, 44]`
    - `initial` only slurp the first element [42] from array

#### 03.01. Using the API
  ##### `count` method
    - Array.count
    - Array.count(42)
    - Array.count("Jacob")
    - Array.count { |e| e % 2 == 0 }

  ##### `count` method
    - Array.index(15)
    - Array.index { |e| e % 2 == 0 }

  ##### `flatten`
    - Array.flatten => return 1 dimention array
    - Array.flatten(1) => flatten at level 1
      - [4, [8], [15], [16, [23, 42]]].flatten(1) => [4, 8, 15, 16, [23, 42]]

  ##### `compact`
    - Array.compact reject all nil element from array

  ##### `zip`
    - [4, 8, 15, 16, 23, 42].zip([42, 23, 16, 15, 8]) => [[4, 42], [8, 23], [15, 16], [16, 15], [23, 8], [42, nil]]

  ##### `slice`
    - use to extract element from array , like `[ ]` method
    - Array.slice(2)      <= input is index
    - Array.slice(2..5)   <= input is Range

  ##### `join`
    - return string
    - applies the separator between two elements
    - Array.join("|")

  ##### `shift`
    - extract and element from array
    - Modify origin array
    - a = [1,2,3]
    - a.shift(2) => [1,2]
    - a => [3]

  ##### `unshift`
    - append into beginning of original array
    - [8, 15, 16, 23, 42].unshift(4)
    - [16, 23, 42].unshift(4, 8, 15)


## 04. Advanced Modules
  - ### 04.01. The `included` Callback and the `extend` Method
    - #### The `included` callback
      - `included` callback => Ruby invokes whenever module is included by another module / class
      - `included` is a class level method <= define with `self.`
      ```ruby
        module Foo
          def self.included(klass)
            puts "Foo has been included in class #{klass}"
          end
        end

        class Bar
          include Foo
        end
      ```
    - #### Module#extend
      - `extend` vs `include`
        - `extend` works everywhere:
          - inside a class/module definition
          - on specific instance
        - `include` can't be use on specific objects
      - use `extend` in class definition to mimick include (`self.initialize`)
      - mimick = reproduce (extend mimick indlue mean: extend can reproduce what include can do)
          ```ruby
            module Foo
              def module_method
                puts "foo module method"
              end
            end
            class Bar
              self.initialize
                self.extend Foo
              end
            end
          ```
    - #### Use Module#extend for adding __class__ level method
      - The magic is in treating everything as an object
        - as you may extend an instance of a class
        - you may extend the class itself
        - `Bar.extend Foo` ; `Bar.module_method`
      - recap:
        - `include` has a callback `included` class method
        - `self.included(base)` where `base` is the target class
        - `extend` can be used to add methods to the classes themselves
    -
  - ### 04.02. Wrapping Up Modules

## 05. Exceptions
  - ### 05.00. Handling and Raising
  - ### 05.01. Tidying Things Up
  - ### 05.02. Throw and Catch

## 06. Declaring Data
  - ### 06.01. Literals
  - ### 06.02. Variables
  - ### 06.03. Constants

## 07. Collections
  - ### 07.00. Enumerators and Enumerables
  - ### 07.01. Iterate, Filtrate and Transform
  - ### 07.02. Building Collections
  - ### 07.03. Object References

## 08. Finding and Fixing Bugs
  - ### 08.00. The Debugging Primaries
  - ### 08.01. Logging
  - ### 08.02. Benchmarking Ruby Code

## 09. Ruby's Object Model
  - ### 09.00. What is an object?
  - ### 09.01. Behaviour
  - ### 09.02. Singleton methods and metaclasses
  - ### 09.03. Cloning and freezing objects

