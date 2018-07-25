
 config param bucketBits=8; 

 proc radix_sort_msd(array:[] int, place: int, startIndex: int, endIndex: int, auxArray:[] int) {

   param numBuckets = (1 << bucketBits);
   var counts:[0..numBuckets] int;  
   var currentDigit: int; 
   var countIndex: int;
   var auxIndex: int;


   //base case, exit condition
   if( endIndex<=startIndex || (place<0) ) {
     return;
   }

   for i in (startIndex..endIndex) {
     // find the postion to store a particular number in the counts array
     currentDigit = ((array[i]>>place) & 255);
     
     //increment count at that position
     counts[currentDigit] += 1; //increment count at the position of the m.s.d.
   }
    
   //update counts array
   counts = + scan counts;

   for i in (startIndex..endIndex) {
     countIndex = ((array[i]>>place) & 255);
     auxIndex = counts[countIndex];     
     auxArray[auxIndex-1] = array[i];   
     counts[countIndex] -=1;                 
   }
  
   
   //swap slices of array and aux array
   array[startIndex..endIndex] <=> auxArray[0..(endIndex-startIndex)];
 
   //recursive call for subparts of array
   for m in 0..(numBuckets-1) {
     radix_sort_msd(array, place-8, startIndex + counts[m], startIndex + counts[m+1] - 1, auxArray);
   }	

  	
 }

 // To find maximum element in an array
 proc findMaxElement(array:[] int) {
   return max reduce array;
 }

 // To find the place value from which msb sorting starts
 proc findPlace(array:[] int) {
   var place: int;
   var max_el = findMaxElement(array);
   while((max_el >> place) > 0) {
     place = place + bucketBits;
   }
   return place;
 }

 proc main() {
  
   var array:[0..15] int = [123445, 233, 10, 56, 17, 9, 182, 667, 549, 55, 990909, 48, 33, 1100, 32, 13457];
   var auxArray:[0..array.size-1] int;
   
   var place = findPlace(array);
 
   writeln("input array: ",array);

   radix_sort_msd(array,place,0,array.size-1,auxArray);
   
   writeln("sorted array: ",array);

 }
