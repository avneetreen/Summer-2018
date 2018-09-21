use BlockDist;
use Random;
use Sort;
use simpleMerge;

config const n = 100;
const Space = {1..n};
 
proc main() {
  const BlockSpace = Space dmapped Block(boundingBox=Space);

  var BA: [BlockSpace] int ;
  var indicesArr: [1..0] int;
  fillRandom(BA);
 
	for loc in Locales do on loc {
	 const indices = BA.localSubdomains();
   indicesArr.push_back(indices.low);
  }
  
  indicesArr.push_back(BA.size+1);

  coforall loc in Locales {
  on loc do{
   for s in BA.localSubdomains(){
      sort(BA[s]);
    }
  }
  }

 //merge
 var start_l = 1;
 var end_l = 2;
 var end_r = 0;
 while(end_l < indicesArr.size) {
		
		end_r = end_l+1;

		if(end_r > indicesArr.size) {
			break;
  	}
		BA = merge(BA,indicesArr[start_l], indicesArr[end_l], indicesArr[end_r]);
		end_l = end_r;
  } 

 writeln(isSorted(BA));
 }
