funcGetQuestion () {
 a=100
 while [ -e /usr/local/bin/FlashCard_decks/$DECK/"$a"_0_q* ];do
 let a+=1
 done
 let a-=1

 CATEGORY=`shuf -i 100-$a -n 1`

 b=0;
 while [ -e /usr/local/bin/FlashCard_decks/$DECK/"$CATEGORY"_"$b"_a* ];do
   let b+=1;
 done
 if [ ! $b -eq 0 ]; then
   let b-=1
 fi

 COUNT=`shuf -i 0-$b -n 1`

 QUESTION="$CATEGORY"_"$COUNT"_q
 ANSWER="$CATEGORY"_"$COUNT"_a
}

funcGetQuestion

echo $QUESTION
