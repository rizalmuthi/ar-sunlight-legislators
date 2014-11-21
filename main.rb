require_relative 'app/models/legislator'
require_relative 'app/models/senator'
require_relative 'app/models/delegate'
require_relative 'app/models/representative'
require_relative 'app/models/commissioner'
require_relative 'app/models/tweet'
require_relative 'lib/sunlight_legislators_twitter'

def print_legislator_by_state(state)
  puts "State: #{state}"
  puts "Senators: "
  Legislator.where(title: "Sen", state: state).each do |sen|
    puts "#{sen.firstname} #{sen.lastname} (#{sen.party})"
  end

  puts "Representatives: "
  Legislator.where(title: "Rep", state: state).each do |rep|
    puts "#{rep.firstname} #{rep.lastname} (#{rep.party})"
  end
end

def count_legislator_by_gender(gender)
  puts "Gender: #{gender}"

  total_sen_count = Legislator.where(title: "Sen", gender: gender).count
  active_sen_count = Legislator.where(title: "Sen", gender: gender, in_office: "1").count
  puts "#{gender.capitalize} Senators: #{total_sen_count} (#{active_sen_count*100/total_sen_count}%)"


  total_rep_count = Legislator.where(title: "Rep", gender: gender).count
  active_rep_count = Legislator.where(title: "Rep", gender: gender, in_office: "1").count
  puts "#{gender.capitalize} Representatives: #{total_rep_count} (#{active_rep_count*100/total_rep_count}%)"
end

def count_legislator
  sen_count = Legislator.where(title: "Sen").count
  puts "Senators: #{sen_count}"

  rep_count = Legislator.where(title: "Rep").count
  puts "Representatives: #{rep_count}"
end

def print_legislator_by_state_and_active
 Legislator.select(:state).distinct.order(:state).map(&:state).each do |state|
    puts "#{state}: #{Legislator.where(title: "Sen", in_office: "1", state: state).count} Senators, #{Legislator.where(title: "Rep", in_office: "1", state: state).count} Representative(s)"
  end
end

# puts "Total legislators: #{Legislator.count}"
# count_legislator_by_gender("M")
# print_legislator_by_state("CA")
# count_legislator
# print_legislator_by_state_and_active

# puts Senator.count
# puts Delegate.count
# puts Representative.count
# puts Commissioner.count

SunlightLegislatorsTwitter.get_last_ten_tweets(1)
