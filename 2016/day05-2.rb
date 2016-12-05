require 'digest/md5'

prefix = 'ffykfhsq'
pass = '_' * 8
i = 0

until !pass['_'] do
  hash = Digest::MD5.hexdigest(prefix + i.to_s)

  if hash.start_with? '0' * 5
    pos = hash[5].to_i(16)

    if pos < pass.size && pass[pos] == '_'
      pass[pos] = hash[6]
      puts pass
    end
  end

  i += 1
end
