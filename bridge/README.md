This is a project to do zk bridge using circom.

#### Compile the circuit
circom bridge.circom --wasm --r1cs

#### generate the witness with wasm
node generate_witness.js bridge.wasm ../input.json witness.wtns

#### perform trusted setup 
snarkjs powersoftau new bn128 18 pot12_0000.ptau -v  
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v  
*** This steps take 30mins to 1 hour to run.  
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v  

### generate the proving key
snarkjs groth16 setup bridge.r1cs pot12_final.ptau bridge_0000.zkey  

### generate verification key
snarkjs zkey export verificationkey bridge_0000.zkey verification_key.json

#### proof generation / verification
node proof_genver.js
