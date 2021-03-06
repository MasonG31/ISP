// importing Libraries
import Curses
let screen = Screen.shared
// creating an array for each suit of card
var spades = [] as [Int]
var clubs = [] as [Int]
var diamonds = [] as [Int]
var hearts = [] as [Int]
print()
print("Rules of War:")
print("Player 1, and the computer will both be dealt 26 cards from a standard deck.")
print("Starting with the top card, each player will show their card, and the person with the higher value will win and take both cards to the bottom of the deck.")
print("Whoever reaches 39 cards first, will win the game")
print("In the occasion where both cards tie, you will go to war, and lay down 3 more cards each, the highest average will win all 8 cards.")
print("Let's play War!!!")
print()
        

// this code adds the cards 1-13 in each of the arrays
for z in 1...13{
    spades.append(z)
    clubs.append(z)
    diamonds.append(z)
    hearts.append(z)
}

//each array will have the exact same data values, but will be in a different array representing each suit
//all of the cards in each suit of cards are the same integers, they just happen to have a different symbol

// hand1 and hand2 are the human and computer hand of cards
var hand1 = [] as [Int]
var hand2 = [] as [Int]
//this part of the code makes the full deck of cards an array, made up of the 4 suits
let deck = [spades, clubs, diamonds, hearts] as [Any]
//this makes a 3D array, in which at the lowest level is all of the numbers, and at the higher level the 4 suits


// this function deals out a card from the deck array to either the hand1, or hand2 arrays, making sure not to make a duplicate of the same cards
func dealCard(person: Int){
    var lock = false
    //lock acts as a switch, when the program has done its job, lock will switch to true and end it
    while lock == false {
        var xFactor = 1
        var currentSuit = Int.random(in: 1...4)
        //this gives a random number to be tried to be the suit
        if currentSuit == 1{
            xFactor = 1
            //we add these xFactors as a way to make every deck in the card have a specific number
            //the xFactors vary by large gaps so that each xFactor times the card value can only equal one card.
        }
        if currentSuit == 2{
            xFactor = 100
        }
        if currentSuit == 3{
            xFactor = 2000
        }
        if currentSuit == 4{
            xFactor = 100000
        }


        let currentCard = Int.random(in: 1...13)
        //generates a radom card
        let cardData = xFactor * currentCard
        //there are 52 unique cardData Int's
        if hand1.contains(cardData) ||  hand2.contains(cardData){
            
            lock = false
            // this checks to see if either of the decks already have that exact cardData code, making sure that no duplicate cards are delt
            //if there is a duplicate, the lock value would switch to true, and end the program, by assigning the values to a deck.
        }
        else{
            if person == 0{
                // person == 0 is just checking to which deck the card is assigned, hand1 or hand2
                hand1.append(cardData)
            }
            else{
                hand2.append(cardData)
            }
            lock = true
            //this stops the loop, because one card was dealt to one hand
        }
        
    }
}
// this function deals all of the cards out to the two hands, it just runs the dealCard function, 26 times for each hand, this makes sure every card is delt only once. 
func dealHands(){
    for _ in 1...26{
        dealCard(person : 0)
    }
    for _ in 1...26{
        dealCard(person : 1)
    }
    print()
}
              
// this function checks the amount of cards that a given hand has
func deckLength(deck : Int)-> Int{
    var county = 0 
    if deck == 0{
        for object in hand1{
            county += 1
        }
    }
    if deck == 1{
        for object in hand2{
            county += 1
        }
    }
    return county
}
//this function breaks down the complex number code of each card, into it's number value and suit, using changes that were in the deal card function
func stripCard(deck : Int, z : Int) -> Int{
    var trueValue = 0
    //like the dealCard, this only works one Card at at time
    if deck == 0{
        if hand1[z] >= 10000{
            trueValue = hand1[z] / 100000
            //this takes away the xfactor that we added, and gives us just the number of that card
        }
        if hand1[z] >= 2000 && hand1[z] < 100000{
            trueValue = hand1[z] / 2000
        }
        if hand1[z] >= 100 && hand1[z] < 2000{
            trueValue = hand1[z] / 100
        }
        if hand1[z] >= 1 && hand1[z] < 14{
            trueValue = hand1[z] / 1
        }
    }
    if deck == 1{
        //very similar code as from above, just for if the card was in hand2
        if hand2[z] >= 10000{
            trueValue = hand2[z] / 100000
        }
        if hand2[z] >= 2000 && hand2[z] < 100000{
            trueValue = hand2[z] / 2000
        }
        if hand2[z] >= 100 && hand2[z] < 2000{
            trueValue = hand2[z] / 100
        }
        if hand2[z] >= 1 && hand2[z] < 14{
            trueValue = hand2[z] / 1
        }
    }

    return trueValue
    //this is the actual number value of the card
}
       
// this function finds the string suit of each card, so that we can return a string back 
func findSuit(deck : Int, z : Int) -> String{
    //this works similary to the stipCard() function, the difference is we aren't looking for the int value, only the string suits
    var suit = ""
    if deck == 0{
        if hand1[z]  >=  100000{
            suit = "Spades"
        }
        if hand1[z] >= 2000 && hand1[z] < 100000{
            suit = "Clubs"
        }

        if hand1[z] >= 100 && hand1[z] < 2000{
            suit = "Diamonds"
        }
        if hand1[z] >= 0 && hand1[z] <  100{
            suit = "Hearts"
        }
    }


    // similar code as above, just for hand2 instead of hand1
    if deck == 1{
        if hand2[z]  >=  100000{
            suit = "Spades"
        }
        if hand2[z] >= 2000 && hand2[z] < 100000{
            suit = "Clubs"
        }

        if hand2[z] >= 100 && hand2[z] < 2000{
            suit = "Diamonds"
        }
        if hand2[z] >= 0 && hand2[z] <  100{
            suit = "Hearts"
        }
    }

    return suit

}

//This function is like the stripCard() function, but instead it works with the special cases of face cards and the ace.
func royal(deck : Int, z : Int)  -> String{
    let rawCard  = stripCard(deck : deck, z : z)
    // under certain ocasions the value will not be a Int, but a string for the face cards
    if rawCard >= 13{
        return "King"
    }
    if rawCard >= 12{
        return "Queen"
    }
    if rawCard >= 11{
         return "Jack"
    }

    if rawCard == 1{
        return "Ace"
    }

  
    
    else{
        return ""
    }
}
var dame = false
func compareCards(z : Int) -> String{
    //this just checks to see if any of the hands are small enough for the other player to win the game
    if hand1.count <= 13  {
        print("Player 2 Wins")
        print()
        print("The vicotor is crowned")
        dame = true
        return ""
        
    }
    if hand2.count <= 13 {
        print("Player 1 Wins!")
        print()
        print("The victor is cronwed")
        dame = true
    }
    
    if dame == true{
        return ""
    }
    //these are the varibles that we need each time we compare cards
    let rawSuit1 = findSuit(deck : 0, z : z)
    let rawSuit2 = findSuit(deck : 1, z : z)
    let questionRoyal1 = royal(deck : 0, z : z)
    let questionRoyal2 = royal(deck : 1, z : z)
    var rawCard1 = stripCard(deck : 0, z : z)
    var rawCard2 = stripCard(deck : 1,  z: z)
    var win1 = 2
    if rawCard1  > rawCard2{
         win1 = 1
        
    }
    if rawCard2 > rawCard1{
         win1 = 0
        
    }
    if rawCard2 ==  rawCard1{
        win1 = 10
        // this part of the code is used if there is a tie, meaning we need to go to war
    }
    
    print()
    print()
    //makes the code neater
    var value1 = ""
    var value2 = ""

    if questionRoyal1 != "" { 
        value1 = questionRoyal1
    }
    //this checks to see if it is a face card or not
    else{
        value1 =  String(rawCard1)
       
    }
    
    if questionRoyal2 != ""{
        value2 = questionRoyal2   
    }
    else{
        value2 = String(rawCard2)
       
    }
 

    //these two sections are very similar, used to see if there is a simple winner each round
    if win1 == 10{
        if hand1.count >= 6 && hand2.count >= 6{
        print("LET'S GO TO WAR")
        goToWar()
        }
        else{
            let jake = hand1[0]
            hand1.remove(at : 0)
            hand1.append(jake)


            let jakey = hand2[0]
            hand2.remove(at : 0)
            hand2.append(jakey)
        }
    }
    
    if win1 == 1{
        hand1.append(hand2[z])
        hand2.remove(at : z)
        let jake = (hand1[0])
        hand1.remove(at : (0))
        hand1.append(jake)

        print()
        print ("Player One Wins " +  "\n" + String(value1) + " of " + rawSuit1 + " over a " + String(value2) + " of " + rawSuit2)
        
    } 

    if win1 == 0 {
      
        hand2.append(hand1[z])
        hand1.remove( at : (z))
        let jake = (hand2[0])
        hand2.remove(at : (0))
        hand2.append(jake)
        print ("Player Two Wins " + String(value2) + " of " + rawSuit2 + " over a " + String(value1) + " of " + rawSuit2)
    }
    win1 = 2
    print("Player One Card Count: " + String(deckLength(deck : 0)))
    print("Player Two Card Count: " + String(deckLength(deck : 1)))
    return ""
}

// this code runs when 2 cards tie with the win1 varible. When this happens 3 more cards are laid down each    
func goToWar()-> String{
    let currentCard = stripCard(deck : 0, z : 0)
    print(String(currentCard) + " matched by both players")
    var sum1 = 0
    var sum2 = 0
    for y in  0...3{
        sum1 += hand1[y]
        sum2 += hand2[y]
    }
    if sum1 >= sum2{
        hand1.append(hand2[0])
        hand1.append(hand2[1])
        hand1.append(hand2[2])
        hand2.remove(at : 0)
        hand2.remove(at : 1)
        hand2.remove(at : 2)
        let jake1 = (hand1[0])
        let jake2 = (hand1[1])
        let jake3 = (hand1[2])
        hand1.remove(at : (0))
        hand1.remove(at : (1))
        hand2.remove(at : (2))
        hand1.append(jake1)
        hand1.append(jake2)
        hand1.append(jake3)
    

        return "Player One Wins"
    }
    
    else{
        hand2.append(hand1[0])
        hand2.append(hand1[1])
        hand2.append(hand1[2])
        hand1.remove(at : 0)
        hand1.remove(at : 1)
        hand1.remove(at : 2)
        let jake1 = (hand2[0])
        let jake2 = (hand2[1])
        let jake3 = (hand2[2])
        hand2.remove(at : (0))
        hand2.remove(at : (1))
        hand1.remove(at : (2))
        hand2.append(jake1)
        hand2.append(jake2)
        hand2.append(jake3)
    

        return "Player Two Wins"
        
    }
}

// this call of dealHands() must happen before any of the game is played, because this makes sure hand1 and hand2 have cards in them to start with.
dealHands()
//500 is a set amount of time where all of the games we testd finished, if the game is going to take longer than 500 tries, it shouldn't be continuted.
print("LET'S PLAY WAR")
print()
print("=????????????????????????????? - - - - - - - - - ")
print("????????????????????????????????  - - - - - - - - - ")

for z  in 0...500{
    print()
    
    if dame == false{
        print("Press Enter  to have a Battle!")
        
        let name = readLine()
        //this is the input we get from the user
        if name == ""{
            
            compareCards(z : 0)
            
        }
        else{
            break
            //this breaks the loop, meaning they don't want to continue playing
        }
    }
    if dame == true{
        break
        //this breaks the loop meaning they don't want to continue playing
    }
    
}


