#!/usr/bin/perl

$PRLDEFS="PERLDEFS";

@subword = qw/ '  ' a b c d e f g h i j k l m n o p q r s t u v w x y z ca cc cd ce db df dg dh ei ej ew fa fc fd fe gb 
   gf gg gh hi hj hw ia ic id ie jb jf jg jh ma mc md me nb nf ng nh oi oj ow pa pc pd pe qb qf qg qh ri rj rw sa sc sd
   se tb tf tg th wl wp wq wr wv xk xm xn xo xu xx xy xz yl yp yq yr yv zs zt /;
   
if ( ! open WORDS, "words") {
  die "I can't read the wordlist ($!)";
  }
  
open GOODWORDS, ">goodwords.txt";

while (<WORDS>) {
  chomp;
  
  while ($_) {
    print STDOUT "$_\n";
    $broke = 0;
    for ($i=0; $i < length($_); $i+=2) {
      $part = substr($_, $i, 2);  #split the word into chunks of 2
      print STDOUT "$part\n";
      foreach $subword (@subword) {
        $matched = 0;
        if ($subword eq $part) {  #test the chunks against the list up top. If it matches one, break out of the list
          print STDOUT "$part matched\n";
          $matched = 1;
          }
        
        if ($matched == 1) { last; }  #go to the next chunk of the word.
        
        if ($subword eq 'zt') {   #if we've reached the end of the list, it didn't match anything, so the whole word is bad.
          $broke++;
          print STDOUT "No good\n";
          last;
          }
        
        if ($part eq "") {   #for some reason, this has to be here.
          last;
          }
        }
        
      if ($broke == 0) {   # if it never broke, the word is good.  Write it down!
        print GOODWORDS "$_, ";
        print STDOUT "$_ works!\n";
        }
        
      last;
      }
    }
  }
  
  close WORDS;
  close GOODWORDS;
  print STDOUT "All done!";
  
