#!/bin/bash
# Script to fetch Sessionize data
# This needs to be run from a machine that can access sessionize.com

SESSIONIZE_URL="https://sessionize.com/api/v2/op1603dq/view/All"
OUTPUT_FILE="temp/sessionize-data.json"

echo "Fetching Sessionize data from: $SESSIONIZE_URL"
curl -s "$SESSIONIZE_URL" -o "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
  echo "Data saved to: $OUTPUT_FILE"
  echo ""
  echo "To import speakers, run:"
  echo "  ruby temp/import_speakers.rb --file $OUTPUT_FILE"
else
  echo "ERROR: Failed to fetch data from Sessionize"
  exit 1
fi
