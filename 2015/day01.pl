print eval join'+', map{$_ eq'('?1:-1}(split//,<>)
