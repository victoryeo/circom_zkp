pragma circom 2.0.0;

include "../circom/poseidon.circom";
include "../circom/mimcsponge.circom";

template MessageHash(n) {
    signal input ins[n];
    signal output out;

    //MiMC is a block cipher and hash function family 
    //designed specifically for SNARK 
    component msg_hasher = MiMCSponge(n, 220, 1);
    for (var i=0; i<n; i++) {
        msg_hasher.ins[i] <== ins[i];
    }
    msg_hasher.k <== 0;

    out <== msg_hasher.outs[0];
}

template PoseidonHasher() {
    signal input header;
    signal output hash;
    signal intermediate;

    component poseidon = Poseidon(1);
    poseidon.inputs[0] <== header;
    intermediate <== poseidon.out;

    component msgHasher = MessageHash(1);
    msgHasher.ins[0] <== intermediate;
    hash <== msgHasher.out;
}

component main = PoseidonHasher();