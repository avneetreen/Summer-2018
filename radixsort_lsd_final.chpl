
proc countsort(place:int,array:[] int) {

  var length_arr = array.size;
  var result:[1..length_arr] int;
  var counts:[0..256] int;

  var i: int;
  var current_digit: int;
  

  for i in 1..array.size{
    // find the postion to store a particular number in the counts array
    current_digit = ((array[i] >> place) & 255); 
    //increment count at that position
    counts[current_digit] += 1;
  }

  i=1;
  for i in 1..(counts.size-1) {
    counts[i] += counts[i-1];
  }

  i = array.size;
  var new_index: int;

  // fill in the result array with the correct position of the numbers using the counts array.
  while(i>0) {
    
    current_digit = (array[i] >> place) & 255; 
    new_index = counts[current_digit];
    result[new_index] = array[i];
    counts[current_digit] -=  1;
    i = i - 1;
  }

	
  return result;

 }

// To find maximum element in an array

proc find_max_element(array:[] int) {
  return max reduce array;
 }

proc radix_sort(array:[] int) {

  var number_of_digits: int;
  var mx: int;
  mx = find_max_element(array);
  var j: int;
  j=0;
  
  while((mx >> j) > 0) {
    array = countsort(j,array);
    // since there are 256 buckets, the array number would be divided by powers of 256 each time
    j=j+8; 
  }

  return array;

 }

proc main() {
 
  var array:[1..12] int = [ 233, 10, 9, 182, 667, 549, 55, 48, 1100, 32, 13457, 12];
  writeln(array);

  var sorted_array = radix_sort(array);
  writeln("sorted array: ",sorted_array);
 }
