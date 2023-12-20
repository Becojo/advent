workflows, parts = ARGF.read.split("\n\n")

workflows = workflows.lines.map(&:strip).map do |workflow|
  id, rules = workflow.tr('{}', '  ').split

  rules = rules.split(',').map do |rule|
    if rule[':']
      cond, job = rule.split(':')
      [cond[0].to_sym, cond[1], cond[2..-1].to_i, job]
    else
      ["default", "==", nil, rule]
    end
  end

  [id, rules]
end.to_h

parts = parts.lines.map(&:strip).map do |part|
  eval(part.tr('=', ':'))
end

accepted = parts.select do |part|
  current_workflow = "in"

  loop do
    if %w(A R).include? current_workflow
      break
    end

    workflow = workflows[current_workflow]

    workflow.each do |(key, op, value, next_workflow)|
      if part[key].send(op, value)
        current_workflow = next_workflow
        break
      end
    end
  end

  current_workflow == "A"
end

part1 = accepted.flat_map(&:values).sum

puts part1

range = (1..4000).to_a
parts = [{ x: range, m: range, a: range, s: range, workflow: 'in', path: ['in'] }]
accepted = []

until parts.empty?
  part = parts.shift
  current_workflow = part[:workflow]
  path = part[:path]

  if current_workflow[/[AR]/]
    accepted << part if current_workflow == 'A'
    next
  end

  workflow = workflows[current_workflow]

  workflow.each do |(key, op, value, next_workflow)|
    if key == 'default'
      parts << part.merge(workflow: next_workflow, path: path + [next_workflow])
    else
      splits = part[key].group_by { _1.send(op, value) }
      part = part.merge(key => splits[false] || [])

      parts << part.merge(key => splits[true] || [], workflow: next_workflow, path: path + [next_workflow])
    end
  end

end

def trim(arr)
  arr.slice_when { |prev, curr| curr != prev.next }.to_a.map do |slice|
    slice.first..slice.last
  end
end

part2 = accepted.map do |part|
  part.values_at(:x, :m, :a, :s).map { trim(_1)[0].size }.reduce(:*)
end.sum

puts part2
