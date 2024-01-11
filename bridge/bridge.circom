pragma circom 2.0.0;

include "../circom/poseidon.circom";

template PoseidonHasher() {
    signal input header;
    signal output hash;

    component poseidon = Poseidon(1);
    poseidon.inputs[0] <== header;
    hash <== poseidon.out;
}

component main = PoseidonHasher();