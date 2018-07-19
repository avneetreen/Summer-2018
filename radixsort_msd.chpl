
 proc radix_sort_msd(array:[] int, place: int, start_index: int, end_index: int, aux_array:[] int) {

   var base = 10;
   var counts:[0..10] int;  
   var div_by: int;
   var current_digit: int; 
   var count_index: int;
   var aux_index: int;

   div_by = 10**place;

   //base case, exit condition
   if( end_index<=start_index || place<0  ) {
     return _void;
   }

   for i in (start_index..end_index) {
  
     current_digit = (array[i]/div_by)%10; //find m.s.d.
     counts[current_digit] += 1; //increment count at the position of the m.s.d.
   }
    
   for j in 1..(base-1){
     counts[j] += counts[j-1];
   }

   for i in start_index..end_index {

     count_index = (array[i]/div_by)%10;   //find m.s.d.
     aux_index = counts[count_index];     //find count of m.s.d. in counts array
     aux_array[aux_index-1] = array[i];   //0 based indexing of aux array
     counts[count_index] -=1;                 
   }
  
   //copy into main array from aux array
   for i in start_index..end_index {
     array[i] = aux_array[i-start_index];  
   }

   //recursive call for subparts of array
   for m in 0..(base-1) {
     radix_sort_msd(array, place-1, start_index + counts[m], start_index + counts[m+1] - 1, aux_array);
   }	

   //writeln(array);
   return array;
	
 }

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
 proc find_max_element(array:[] int){
   return max reduce array;
 }

 proc main() {
  
   var array:[0..12] int = [ 23, 10, 9, 82, 67, 54, 55, 48, 11, 32, 100, 37, 54 ];
   var aux_array:[0..array.size-1] int;
   var place: int;
 
   writeln("input array: ",array);
  
   var max_el = find_max_element(array);
   var number_of_digits = find_num_digits(max_el);
   place = number_of_digits - 1;

   radix_sort_msd(array,place,0,array.size-1,aux_array);
   writeln("sorted array: ",array);
 }
