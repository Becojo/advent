require 'digest/md5'

prefix = 'ffykfhsq'
pass = ''
i = 0

until pass.size == 8 do
  hash = Digest::MD5.hexdigest(prefix + i.to_s)

  if hash.start_with? '0' * 5
    pass += hash[5]
    puts pass
  end

  i += 1
end
