DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ROOT=$DIR/..
SMART_CONTRACTS=$ROOT/../../metaplex/smart-contracts

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
  solana program deploy $SOFILE
done


echo "Deploying nft-packs"  
SOFILE="$SMART_CONTRACTS/target/deploy/metaplex_nft_packs.so"
solana program deploy $SOFILE
