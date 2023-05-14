This is a project to do zk rollup using circom. The file rollup.circom contains the zk rollup code. The folder circom contains the circom librabry files.

### compile the circuit
circom rollup.circom --r1cs --wasm --sym --c

### generate the witness with webassembly
node generate_witness.js rollup.wasm ../input.json witness.wtns

### definition
Circuit is a logical representation of the computational problem using polynomials.  

Witness is assignment of signals to the cicruit.  

Signals are the variables.  

Rank-1 Constraint System (R1CS) is the set of constraints describing the circuit.  

Non-interactive zero-knowledge (NIZK) proofs are a particular type of zero-knowledge proofs in which the prover can generate the proof without interaction with the verifier.  

ZK_SNARK (Zero Knowledge-Succinct ARguments of Knowledge) is the most preferable NIZK. It is a set of non-interactive zero-knowledge protocols that have succinct proof size and sublinear verification time.  

  