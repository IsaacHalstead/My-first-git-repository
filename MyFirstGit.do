*** My first Git test

** Simple simulation illustrating how spurious associations can arise by chance

* Set the seed
set seed 42

* Macro to count 'significant' associations
local sig = 0

* Repeat the simulation 1000 times
forvalues i = 1(1)1000 {
  clear
  quietly set obs 100
  
  gen x = rnormal()
  gen y = rnormal()
  
  * If p<0.05, add 1 to 'sig'
  quietly pwcorr x y, sig
  matrix res = r(sig)
  local p = res[1,2]
  if `p' < 0.05 {
    local sig = `sig' + 1
  }
}

* Display the number of times p < 0.05
display `sig'
