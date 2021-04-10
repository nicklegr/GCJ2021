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
  n, q = ris
  arr = rws(n)
  arr.map!{|e| s = e.split; [s[0], s[1].to_i]}
# ppd arr

  ans = nil
  score = nil
  arr.each do |e|
    if e[1] == q
      ans = e[0]
      score = q
      break
    elsif e[1] == 0
      ans = e[0].tr("TF", "FT")
      score = q
      break
    end
  end

  if !ans && n == 2
    diff = 0
    idx = -1
    for i in 0...q
      diff += 1 if arr[0][i] != arr[1][i]
      idx = i
    end

    if diff == 1
      ans = arr.max_by{|e| e[1]}[0]
      ans[idx] = ans[idx].tr("TF", "FT")
    end
    score = q
  end

  if !ans
    ans = arr.max_by{|e| e[1]}[0]
    score = arr.max_by{|e| e[1]}[1]
  end

  puts "Case ##{case_index}: #{ans} #{score}/1"

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
