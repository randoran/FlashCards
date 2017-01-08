#!/bin/bash
# flash card questions and answers

source flash.conf;

####################### FUNCTIONS SECTION #####################


###############################################################

funcGetDeck () {
  DECKS=(`ls -l $INSTALL_PATH/FlashCard_decks/|grep ^d|awk '{print $9}'`)
  NUMDECKS=${#DECKS[@]}
  dialog --title "FLASHCARDS" \
         --radiolist "`echo '\n'`Choose a flashcard deck:" 15 30 $NUMDECKS \
	"${DECKS[0]}" "" OFF \
        "${DECKS[1]}" "" OFF \
        "${DECKS[2]}" "" OFF \
        2>$INSTALL_PATH/FlashCard_decks/deck
  DECK=`cat $INSTALL_PATH/FlashCard_decks/deck`

 if [ -z $DECK ];then
 EXIT=1
 fi
}

###############################################################

###############################################################

funcGetQuestion () {  # Get the number of questions in the folder
 a=100
 while [ -e $INSTALL_PATH/FlashCard_decks/$DECK/"$a"_0_q[a-zA-Z0-9]*$ ];do 
 let a+=1
 done
 let a-=1
 
 CAT_NUM=`shuf -i 100-$a -n 1` # finds random category
 CAT_NAME='ls $INSTALL_PATH/FlashCard_decks/$DECK/"$CAT_NUM"_"$b"_a*'

 b=0;
 while [ -e $INSTALL_PATH/FlashCard_decks/$DECK/"$CAT_NUM"_"$b"_a* ];do 
   let b+=1;
 done
 if [ ! $b -eq 0 ]; then
   let b-=1
 fi

 COUNT=`shuf -i 0-$b -n 1`

 QUEST_NUM="$CAT_NUM"_"$COUNT"
 QUESTION="$QUEST_NUM"_q_"$CAT_NAME";
 ANSWER="$CAT_NUM"_"$COUNT"_a
}

###############################################################

###############################################################

funcPresentQuestion () {
 dialog --title "[ `echo $DECK` QUESTION ]" --no-cancel \
        --ok-label "See the answer" \
        --inputbox "`echo '';cat $INSTALL_PATH/FlashCard_decks/$DECK/$1`" \
        15 60 2>$INSTALL_PATH/FlashCard_decks/response

 EXIT=0
 # Get exit status
 # 0 means user hit [yes] button.
 # 1 means user hit [no] button.
 # 255 means user hit [Esc] key.

 dialog --title "[ ANSWER ]" \
        --yes-button "Next Question" \
        --no-button "EXIT" \
        --yesno "`echo 'Your response\n';``cat $INSTALL_PATH/FlashCard_decks/response;``echo '\n\nAnswer\n';``cat $INSTALL_PATH/FlashCard_decks/$DECK/$2;`" \
        15 60
}

##################### END OF FUNCTIONS #######################


##################### START OF SCRIPT ########################

clear

funcGetDeck

#loop to present questions and answers
while [ "$EXIT" != "1" ]; do
 funcGetQuestion
 funcPresentQuestion $QUESTION $ANSWER 
 EXIT=$?
done
clear
