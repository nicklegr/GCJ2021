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

cases, n, q = ris

(1 .. cases).each do |case_index|
  ans = []

  puts_sync((1..3).to_a.join(" "))
ppd((1..3).to_a.join(" "))
  res = ri
ppd(res)
  raise if res == -1
  case res
  when 1
    ans = [2,1,3]
  when 2
    ans = [1,2,3]
  when 3
    ans = [1,3,2]
  end

  for i in 4..n
ppd(ans.join)
    found = false
    ans.each_cons(2) do |pair|
      query = pair + [i]
ppd(query)
      puts_sync(query.join(" "))
      res = ri
ppd(res)
      raise if res == -1

      if res == i
        pivot = ans.index(pair[0])
        ans = ans[0..pivot] + [i] + ans[pivot+1...ans.size]
        found = true
        break
      end
    end

    if !found
      query = [ans.first, ans.last, i]
ppd(query)
      puts_sync(query.join(" "))
      res = ri
ppd(res)
      if res == ans.first
        ans = [i] + ans
      else
        ans = ans + [i]
      end
    end
  end

ppd(ans)
  puts_sync(ans.join(" "))
  res = ri
  if res == -1
    exit(1)
  end
ppd("-----------")
end
