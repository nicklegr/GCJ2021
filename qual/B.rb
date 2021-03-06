require 'pp'

def ppd(*arg)
  if $DEBUG
    arg.each do |e|
      PP.pp(e, STDERR)
    end
  end
end

def putsd(*arg)
  if $DEBUG
    STDERR.puts(*arg)
  end
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

def puts_sync(str)
  puts str
  STDOUT.flush
end

def array_2d(r, c)
  ret = []
  r.times do
    ret << [0] * c
  end
  ret
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  x, y, s = rss
  x = x.to_i
  y = y.to_i

  loop do
    old = s.dup
    s = s.sub(/([CJ])(\?+)([CJ])/) do |m|
      # if $1 == "C" && $3 == "C"
      #   "C#{"C" * $2.size}C"
      # elsif $1 == "J" && $3 == "J"
      #   "J#{"J" * $2.size}J"
      # else
        "#{$1}#{$1 * $2.size}#{$3}"
      # end
    end
    break if old == s
  end

  cost = 0
  s.chars.each_cons(2) do |e|
    cost += x if e == ["C", "J"]
    cost += y if e == ["J", "C"]
  end

  puts "Case ##{case_index}: #{cost}"

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end

__END__

CJ?CC?
CJCCCC
CJCCCJ
CJJCCC
CJJCCJ

C?C -> CCC(0)
J?J -> JJJ(0)
C?J -> CCJ(X) or CJJ(X)
J?C -> JCC(Y) or JJC(Y)

???????????????????????????????????????
??????????????????????????????(????????????????????????????????????)
C??J -> CCCJ(X)
C??J -> CCJJ(X)
C??J -> CJCJ(2X+Y)
C??J -> CJJJ(X)

J??C -> JCCC(Y)
J??C -> JCJC(X+2Y)
J??C -> JJCC(Y)
J??C -> JJJC(Y)

3??????????????????????????????????????????
????? -> CCCCC
????? -> JJJJC
????? -> CJJJJ
????? -> JJJJJ
