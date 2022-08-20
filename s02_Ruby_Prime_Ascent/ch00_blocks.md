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

