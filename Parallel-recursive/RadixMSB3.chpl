 
 module RadixMSB3 {
   use BitOps;
   use Sort;
   use Random;
   use Time;
   config param bucketBits=8; 

   proc radixSortMSB(array:[?dom] int) {

     var auxArray:[1..array.size] int;
     var place = findPlace(array);
     __radixSortMSB(array,place,dom.low,dom.high,auxArray);

   }
  
   private proc __radixSortMSB(array:[] int, place: int, startIndex: int, endIndex: int, auxArray:[] int) {

     // comparison sorting for <=100 elements
     if(array.size<=100) {
       insertionSort(array[startIndex..endIndex]);
       return;
     }
     
     param numBuckets = (1 << bucketBits);
     var counts:[0..numBuckets] atomic int;
     var curOffsets: [0..numBuckets] atomic int; 
     //base case, exit condition
     if (endIndex<=startIndex || place<0) {
       return;
     }
   
     forall i in startIndex..endIndex {
       // find the postion to store a particular number in the counts array
       var currentDigit = findPosition(place, array[i], numBuckets);
     
       //increment count at that position
			 //writeln(i);
       counts[currentDigit].add(1, memory_order_relaxed); //increment count at the position of the m.s.d.
     }
    
     //update curOffsets
     //curOffsets[0].write(0);
     for i in 1..numBuckets {
       curOffsets[i].write(curOffsets[i-1].peek() + counts[i-1].peek());
     }


     //fill in the auxarray at correct positions 
     for i in startIndex..endIndex {
       var countIndex = findPosition(place, array[i], numBuckets);
       var auxIndex = curOffsets[countIndex].read();     
       auxArray[auxIndex+1]=array[i];   
       curOffsets[countIndex].add(1, memory_order_relaxed);                
     }
   
     //swap slices of array and aux array   
     array[startIndex..endIndex]=auxArray[1..(endIndex-startIndex+1)];
 

     //recursive call for subparts of array
     __radixSortMSB(array, place-bucketBits, startIndex, startIndex + curOffsets[0].read() -1, auxArray);
     forall m in 0..numBuckets-1 {    
       __radixSortMSB(array, place-bucketBits, startIndex + curOffsets[m].peek() , startIndex + curOffsets[m+1].peek() - 1, auxArray);    
     }	
  	
   }

   // To find a position where an element's count is to be updated in the counts array.
   private proc findPosition(place:int, element:int, numBuckets:int) {
     var position = ((element>>place) & (numBuckets-1));
     return position;
   }

   // To find maximum element in an array
   private proc findMaxElement(array:[] int) {
     return max reduce array;
   }

   // To find the place value from which msb sorting starts
   private proc findPlace(array:[] int) {

     const maxEl = findMaxElement(array);    
     var lz = clz(maxEl);
     var numBits = 64 - lz ;
     var place = ((numBits)>>3)<<3;

     return place;
   } 
  
  }
