#!/bin/bash
# HTML Link Validator Script
# Usage: ./.scripts/htmlproofer.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Running HTML link validation...${NC}"

bundle exec htmlproofer \
  --disable-external \
  --assume-extension \
  --extensions=.html \
  --ignore-urls="/github.com/,/linkedin.com/,/twitter.com/,/instagram.com/,/localhost:4000/" \
  ./_site

echo -e "${GREEN}✓ HTML validation passed!${NC}"
