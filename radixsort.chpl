
proc countsort(place:int,array:[] int) {

  var length_arr = array.size;
  var result:[1..length_arr] int;
  var counts:[0..10] int;

  var i: int;
  var div_by: int;
  var current_digit: int;
  div_by = 10**place;

  for i in 1..array.size {
    current_digit = (array[i]/div_by)%10;
    counts[current_digit] += 1;
  }

  i=1;
  for i in 1..(counts.size-1) {
    counts[i] += counts[i-1];
  }

  i = array.size;
  var new_index: int;


  while(i>0) {
    current_digit = (array[i]/div_by)%10;
    new_index = counts[current_digit];
    result[new_index] = array[i];
    counts[current_digit] -=  1;
    i = i - 1;
  }

	
  writeln("After ", place+1, "th pass:  ",result);
  return result;

 }

//To find the number of digits in a number

proc find_num_digits(num:int) {
  var num_digits: int;
  var temp: real;
  temp = 1;
  while (temp <= num) {
    num_digits += 1;
    temp = temp * 10;
  }
  return num_digits;

 }


// To find maximum element in an array

proc find_max_element(array:[] int) {
  
  var max_el: int;
  var i: int;
  max_el = 0;
  
  for i in 1..(array.size) {
    if(max_el<array[i]) {
      max_el = array[i];
    }
  }
  return max_el;
 }

proc radix_sort(array:[] int) {

  var number_of_digits: int;
  var mx: int;
  var sorted_array: [1..array.size] int;
  mx = find_max_element(array);
  number_of_digits = find_num_digits(mx);
  var j: int;

  while(j<number_of_digits) {
    sorted_array = countsort(j,array);
    j=j+1;
  }

  return sorted_array;

 }

proc main() {
 
  var array:[1..10] int = [ 23, 10, 9, 82, 67, 54, 55, 48, 11, 32];
  writeln(array);

  var result = radix_sort(array);
  writeln("final result: ",result);

 }
