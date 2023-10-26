This is a project to do zk rollup using circom. The file rollup.circom contains the zk rollup code. The folder circom contains the circom library files.

### compile the circuit
circom rollup.circom --r1cs --wasm --sym --c

### generate witness
#### generate the witness with webassembly
cd rollup_js
node generate_witness.js rollup.wasm ../input.json witness.wtns

#### generate the witness with cpp
cd rollup_cpp
make
./rollup ../input.json witness.wtns

### perform trusted setup 
#### using powers of tau (multi party trusted setup)
```
snarkjs powersoftau new bn128 18 pot12_0000.ptau -v
```
Initially, i use `bn128 12`, and I go this error:
[snarkJS: circuit too big for this power of tau ceremony. 39582*2 > 2**12]
```
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
snarkjs groth16 setup rollup.r1cs pot12_final.ptau rollup_0000.zkey
```
The above steps take 30mins to 1 hour to run.

```
snarkjs zkey contribute rollup_0000.zkey rollup_0001.zkey  --name="1st Contributor Name" -v
```
rollup_0000.zkey is old key  
rollup_0001.zkey is new key
```
snarkjs zkey export verificationkey rollup_0001.zkey verification_key.json
```
### generate a proof
```
snarkjs groth16 prove rollup_0001.zkey witness.wtns proof.json public.json
```
proof.json contains the proof  
public.json contains the public inputs and outputs

### verify a proof
snarkjs groth16 verify verification_key.json public.json proof.json

### definition
Circuit is a logical representation of the computational problem using polynomials.  

Witness is assignment of signals to the cicruit.  

Signals are the variables.  

Rank-1 Constraint System (R1CS) is the set of constraints describing the circuit.  

Constraint is to make a program  that constraints given inputs into a certain range.

Components work like functions, and we set the component inputs only once. Once component inputs are all defined, the function gets executed and we can use the component output variable.

Non-interactive zero-knowledge (NIZK) proofs are a particular type of zero-knowledge proofs in which the prover can generate the proof without interaction with the verifier.  

ZK_SNARK (Zero Knowledge-Succinct ARguments of Knowledge) is the most preferable NIZK. It is a set of non-interactive zero-knowledge protocols that have succinct proof size and sublinear verification time.  

### about circom
Circom is a language for arithmetic circuits  that is used to generate zero knowledge proof. Circom compiler is a circom language compiler written in Rust that creates R1CS file. Circom is created by Iden3 open source project.
  