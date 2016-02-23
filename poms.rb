# !/usr/bin/env_ruby
#
# tty-prompt to manage the question magic
#
#
def poms

require 'tty-prompt'
prompt = TTY::Prompt.new
time_array = Time.now.to_a
time_current = Time.now
time_index = [5,4,3,2,1,0,9,6,7,8] # provides the order of time elements for the csv file
response_time = [] # instantiates the response time array that will be filled with the current time and sent to the csv

moods = %w(
  unhappy
  sad
  blue
  hopeless
  discouraged
  miserable
  helpless
  worthless
  lively
  active
  energetic
  cheerful
  full-of-pep
  vigorous
  angry
  peeved
  annoyed
  grouchy
  resentful
  bitter
  furious
  tense
  on-edge
  uneasy
  restless
  nervous
  anxious
  confused
  unable-to-concentrate
  bewildered
  forgetful
  uncertain
  worn-out
  fatigued
  exhausted
  weary
  bushed
)

# Feed the time object into our response_time array

time_index.each do |t|
  response_time.push time_array[t]
end

# We want the elements in moods to be produced in a scrambled order, so scramble is our index array, and 
# answers collects each response and inserts it at the proper index number

scramble = moods.each_index.to_a.shuffle
answers = []

# for each number in scrambled array, get the value from moods and insert the
# response at the corresponding number in answers
# scramble = 9, 9 = mood, answer = 9.

scramble.each do |n| 
    answers[n] = prompt.keypress(moods[n], default: '0') { |q| q.in(0..4) }
  end

# insert response_time array into the front of answers array

answers.unshift(response_time)
# puts answers * ', ' # Reports complete answer string

open('data/moods_SF.csv', 'a') do |f|
  f << "\n" + answers * ', '
end

puts 'Profile of Mood States (short form) Complete '
puts Time.now

end
#### TODO
#
# any other data?
# can add it to other csv files no prob
# this can be extended to a daily report
# just need to think design-wise about weather and how I want it all to be in the same file
# keep it nicely organized
#
#
############################
