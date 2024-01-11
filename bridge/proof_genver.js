const snarkjs = require("snarkjs");
const fs = require("fs");

const proofGenVer = async () => {
  const { proof, publicSignals } = await snarkjs.groth16.fullProve(
    { header: 13403990812567987967336759851318987973794445269548215402779394294754792373527 },
    "bridge_js/bridge.wasm",
    "bridge_0000.zkey");

  console.log(publicSignals);
  console.log(proof);

  console.log("generation done");

  const vKey = JSON.parse(fs.readFileSync("verification_key.json"));
  const res = await snarkjs.groth16.verify(vKey, publicSignals, proof);

  if (res === true) {
    console.log("Verification OK");
  } else {
    console.log("Invalid proof");
  }

  console.log("verification done");
}

proofGenVer();
