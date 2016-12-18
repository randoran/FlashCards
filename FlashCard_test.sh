#!/bin/bash

funcGetDeck () {
  DECKS=(`ls -l ./FlashCard_decks/|grep ^d|awk '{print $9}'`)
  NUMDECKS=${#DECKS[@]}
  COUNT=0
  while [ $COUNT -lt $NUMDECKS ];do
    DECKLIST+="$DECKS[$COUNT] '' off "
    set COUNT+=1
  done

  dialog --title "FLASHCARDS" \
         --radiolist "`echo '\n'`Choose a flashcard deck:" 15 30 $NUMDECKS \
        $DECKLIST 2>/usr/local/bin/FlashCard_decks/deck
  DECK=`cat /usr/local/bin/FlashCard_decks/deck`
}
 
funcGetDeck
EXIT=0
if [ -z $DECK ];then
 EXIT=1
fi

clear

echo "Deck chosen is $DECK"
echo "EXIT status is $EXIT"
