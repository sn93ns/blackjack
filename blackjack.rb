##blackjack solution procedural style

#method to calculate hand total, accepts a cards array [["H","3"], ["H","A"]] as argument
def calculate_total(cards)
	total = 0
	arr = cards.map {|e| e[1]}
	arr.each do |val|
		if val == 'A'
			total += 11
		elsif val.to_i == 0 # J,Q,K
			total += 10
		else 
			total += val.to_i
		end
	end

	#correct for aces
	arr.select {|e| e=='A'}.count.times do
		total -= 10 if total > 21
	end

	total
end

puts "Welcome to blackjack!"
puts ""

suits = ['H', 'D', 'S', 'C']
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

deck = suits.product(cards)
deck.shuffle!

# deal cards
mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)
# show cards
puts "dealer has #{dealercards[0]} and #{dealercards[1]} for a toatal of #{dealertotal}"
puts ""
puts "You have #{mycards[0]} and #{mycards[1]} for a toatal of #{mytotal}"
puts ""

if mytotal == 21
	puts "Congratulatoins you hit blackjack you win!!!"
	exit
end
#player turn
while mytotal < 21
	puts "What would you like to do 1) hit 2) stay"
    hit_or_stay = gets.chomp

    #validate input
    if !['1', '2'].include?(hit_or_stay)
    	puts "Error you must select 1 or 2"
    	next
    end

    #break out of loop if player chooses to stay 
	if hit_or_stay == "2"
		puts "you choose to stay"
		break
	end

	#hit
	new_card = deck.pop
	puts "Dealing card to player: #{new_card}"
	mycards << new_card
	mytotal = calculate_total(mycards)
	puts "Your total is now #{mytotal}"

	if mytotal == 21
		puts "Congratulatoins you hit blackjack you win!!!"
		exit
	elsif mytotal > 21
		puts "Sorry, It looks like you busted :-( "
		exit
	end

end

#dealer turn
if dealertotal == 21
	puts "Sorry dealer hit blackjack you lose"
	exit
end

while dealertotal < 17 #hit
	new_card = deck.pop
	puts "Dealing a new card for dealer: #{mew_card}"
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "Dealer total is now: #{dealertotal}"

	if dealertotal == 21
		puts "Sorry dealer hit blackjack you lose"
		exit
	elsif dealertotal > 21
		puts "Congratulation dealer busted you Win!!!"
		exit
	end
end

#compare hands
puts "Dealer cards "
dealercards.each do |card|
	puts "=> #{card}"
end
puts ""

puts "your cards "
mycards.each do |card|
	puts "=> #{card}"
end
puts ""

if dealertotal > mytotal
	puts "Sorry, dealer wins"
elsif dealertotal < mytotal
	puts "Congratulation you win"
else
	puts "It's a tie"
end

exit