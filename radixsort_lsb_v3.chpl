
 config param bucketBits=8;

 proc countSort(place:int,array:[] int) {

   param numBuckets = (1 << bucketBits);
   var result:[1..array.size] int;
   var counts:[0..numBuckets-1] int;
   var currentDigit: int;
  
   for i in array.domain {
     // find the postion to store a particular number in the counts array
     currentDigit = ((array[i] >> place) & (numBuckets-1)); 
    
     //increment count at that position
     counts[currentDigit] += 1;
  }

  counts = + scan counts;

  var newIndex: int;

  // fill in the result array with the correct position of the numbers using the counts array.
  for j in array.domain by -1 {
    
    currentDigit = (array[j] >> place) & (numBuckets-1); 
    newIndex = counts[currentDigit];
    result[newIndex] = array[j];
    counts[currentDigit] -=  1;
  }

	
  return result;

 }

 // To find maximum element in an array

 proc findMaxElement(array:[] int) {
   return max reduce array;
 }

 proc radixSort(array:[] int) {

   var mx: int;
   mx = findMaxElement(array);
   var j: int;
 
   while((mx >> j) > 0) {
     array = countSort(j,array);
     // since there are 256 buckets, the array elements would be divided by powers of 256, acc. to the place of the current digit being sorted, to find a suitable position in the counts array.
     j=j+bucketBits; 
   }
   writeln(j);
   return array;

 }

 proc main() {
  
   var array:[1..13] int = [ 233, 10, 9, 182, 667, 549, 55, 48, 675, 1100, 32, 13457, 12];
   writeln(array);

   var sortedArray = radixSort(array);
   writeln("sorted array: ",sortedArray);
 }
