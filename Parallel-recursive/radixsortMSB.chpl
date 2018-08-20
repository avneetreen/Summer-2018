 use BitOps;
 use Sort;
 use Random;
 use RadixMSB3;
 use Time;

 config const printStats = true;
 config const size = 2097152;
 //config const size = 1000; 

 proc main() {
   
   var array:[1..size] int;
    
   fillRandom(array);
   
   for i in array.domain {
     array[i] = abs(array[i]);
   }
   //writeln(array);
   var t: Timer;
	 t.start();

   RadixMSB3.radixSortMSB(array);

   t.stop();
 
   if printStats {
     writeln(t.elapsed());
   }

   t.clear();

   //writeln(array);
   writeln("sorted array: ",isSorted(array));

  }
