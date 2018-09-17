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


  forall L in Locales {
    on L {
    const indices = BA.localSubdomain();
    indicesArr.push_back(indices.low);
    indicesArr.push_back(indices.high);
    sort(BA[indices.low..indices.high]);
    }
  }
  
  var length = indicesArr.size;
  var i = 1;
  while ((i+3) <= length) {

  var l = indicesArr[i];
  var m = indicesArr[i+1];
  var r = indicesArr[i+3];
 
  simpleMerge.merge(BA,l,m,r);
  
  indicesArr[i+2] = l;
  i+=2;
  }

writeln(isSorted(BA));
}

