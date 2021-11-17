DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ROOT=$DIR/..
SMART_CONTRACTS=$ROOT/../../metaplex/smart-contracts

KEYPAIRS=$DIR/keypairs
CONFIG_PATH=$DIR/config.yml

deployables=(
  metaplex_auction
  metaplex_token_metadata
  metaplex_token_vault
  metaplex
)

for dep in "${deployables[@]}"; do
  echo
  echo "Deploying $dep"  
  SOFILE="$ROOT/rust/target/deploy/$dep.so"
  PROGRAMID="$KEYPAIRS/$dep-keypair.json"
  solana -C $CONFIG_PATH program deploy --program-id $PROGRAMID $SOFILE
done


echo "Deploying metaplex nft-packs"  
SOFILE="$SMART_CONTRACTS/target/deploy/metaplex_nft_packs.so"
PROGRAMID="$KEYPAIRS/metaplex_nft_packs-keypair.json"
solana -C $CONFIG_PATH program deploy --program-id $PROGRAMID $SOFILE
