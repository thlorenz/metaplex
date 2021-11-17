DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ROOT=$DIR/..

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
