f = File.readlines('m')



count = 183
number = 3
final=[]

final << f[3]

183.times do
  number += 29
  count -= 1
  puts count
  final << f[number]
end

count = -1
184.times do
  count += 1
  puts final[count]
end


aina = []

count = -1
184.times do
  count += 1
  a = final[count].split(" ")
  aina[count] = a
end

outFile = File.new("ms54.m3u", "w")
outFile.puts("#EXTM3U")
count = -1
184.times do
  count += 1
  a = aina[count]
  if a[3] == "kind=\"episode\""
    s = a[6]
    f_front = s[19..2000]
    f_back  = f_front.delete('"')
    outFile.puts("#EXTINF:#{count},episode #{a[20]}")
    outFile.puts("#{f_back}")
    puts f_back
    puts a[20]
  end
end
outFile.close

outFile = File.new("ms54.m3u", "w")
outFile.puts("#EXTM3U")
count = -1
184.times do
  count += 1
  a = aina[count]
  if a[3] == "kind=\"episode\""
    outFile.puts("#EXTINF:#{count},episode #{a[20]}")
    outFile.puts("#{a[6]}")
    puts a[6]
    puts a[20]
  else
    outFile.puts("#EXTINF:#{count},movie #{a[19]}")
    outFile.puts("#{a[24]}")
    puts a[24]
    puts a[19]
  end
end
outFile.close
