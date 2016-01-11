module And
  class Double
    attr_accessor :input_a, :input_b
    def initialize
      @input_a = 0
      @input_b = 0
    end
    def output
      puts (@input_a + @input_b) == 2 #true only if both inputs contain 1
    end
  end
  class Triple
    attr_accessor :input_a, :input_b, :input_c
    def initialize
      @input_a = 0
      @input_b = 0
      @input_c = 0
    end
    def output
      puts (@input_a + @input_b + @input_c) == 3 #true only if all three inputs contain 1
    end
  end
  class Multi
    def initialize(num)
      @variables = []
      @total = 0
      @sum = 0
      @num = num
    end
    def process
      @sum = 0
      @total = @variables.length
      @variables.each.with_index{|var|
        @sum += instance_variable_get(var)
      }
    end
    def output
      if @num == @total
        puts @total == @sum #true only if all inputs contain 1
      else
        puts 'false'        #false if we have less inputs than specified for initialize
      end
    end
    def method_missing(name,*args, &block)
      variable = '@' + name.to_s.split('_')[1].gsub(/\=/,'')
      instance_variable_set(variable,args[0])
      @variables << variable
      process unless name == "total"  #for some reason total appears as a missing method, skip it
    end
  end
end

module Or
  class Double
    attr_accessor :input_a, :input_b
    def initialize
      @input_a = 0
      @input_b = 0
    end
    def output
      puts (@input_a + @input_b) > 0  #true if at least one input contains 1
    end
  end
  class Triple
    attr_accessor :input_a, :input_b, :input_c
    def initialize
      @input_a = 0
      @input_b = 0
      @input_c = 0
    end
    def output
      puts (@input_a + @input_b + @input_c) > 0 #true if at least one input contains 1
    end
  end
  class Multi
    def initialize(num)
      @variables = []
      @total = 0
      @sum = 0
      @num = num
    end
    def process(vars)
      @sum = 0
      @total = @variables.length
      @variables.each.with_index{|var|
        @sum += instance_variable_get(var)
      }
    end
    def output
      if @num == @total
        puts @total > 0   #true if at least one input contains 1
      else
        puts 'false'      #false if we have less inputs than specified for initialize
      end
    end
    def method_missing(name,*args, &block)
      variable = '@' + name.to_s.split('_')[1].gsub(/\=/,'')
      instance_variable_set(variable,args[0])
      @variables << variable
      process unless name == "total"  #for some reason total appears as a missing method, skip it
    end
  end
end

#---------- AND
gate = And::Double.new
gate.input_a = 1
gate.input_b = 1
gate.output # => 1
gate.input_b = 0
gate.output # => 0

gate = And::Triple.new
gate.input_a = 1
gate.input_b = 1
gate.output # => 0
gate.input_c = 1
gate.output # => 1
gate.input_a = 0
gate.output # => 0

gate = And::Multi.new(4)
gate.input_a = 1
gate.input_b = 1
gate.input_c = 1
gate.output # => 0
gate.input_d = 1
gate.output # => 1
gate.input_b = 0
gate.output # => 0

#---------- Or

gate = Or::Double.new
gate.input_a = 1
gate.input_b = 0
gate.output # => 1
gate.input_a = 0
gate.output # => 0

gate = Or::Triple.new
gate.input_a = 0
gate.input_b = 0
gate.output # => 0
gate.input_c = 1
gate.output # => 1
gate.input_c = 0
gate.output # => 0

gate = Or::Multi.new(4)
gate.input_a = 0
gate.input_b = 0
gate.input_c = 0
gate.output # => 0
gate.input_d = 1
gate.output # => 1
gate.input_d = 0
gate.output # => 0
