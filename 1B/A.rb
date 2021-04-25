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

def solve(a,b,c)
  angles = [a, b, c].sort
  cand = [0,0,0]

  for h in 0..11
    for m in 0..59
      for s in 0..59
# h,m,s = 1,2,3

        # cand[0] = (10**10 * h * 30) + (10**10 * m / (30/60)) + (10**10 * s / (360/(3600*12)))
        # cand[1] = (10**10 * m * (60/360)) + (10**10 * s / (360/3600))
        # cand[2] = (10**10 * s * 360)
        # cand[0] = (10**10 * h * 30) + (10**10 * m / 2) + (10**10 * s / 43200)
        # cand[1] = (10**10 * m * 6) + (10**10 * s / 10)
        # cand[2] = (10**10 * s * 6)
        # cand[0] = ((10**10 * h * 30) + (10**10 * m / 2) + (10**10 * s / 120)) * 12
        # cand[1] = ((10**10 * m * 6) + (10**10 * s / 10)) * 12
        # cand[2] = ((10**10 * s * 6)) * 12

        ts = (h*3600 + m*60 + s) * 10**9
        mod = 10**10 * 12 * 360
        cand[0] = (ts * 1) % mod
        cand[1] = (ts * 12) % mod
        cand[2] = (ts * 720) % mod

# pp cand
# exit
        cand.sort!

        d0 = angles[0] - cand[0]
        d1 = angles[1] - cand[1]
        d2 = angles[2] - cand[2]

        if d0 == d1 && d1 == d2
          return "#{h} #{m} #{s} #{0}"
        end
      end
    end
  end
  raise
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  a, b, c = ris

  puts "Case ##{case_index}: #{solve(a,b,c)}"

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
