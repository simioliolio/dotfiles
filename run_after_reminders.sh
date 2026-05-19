#!/usr/bin/env bash

tcc_db="/Library/Application Support/com.apple.TCC/TCC.db"
missing=()

if [ -r "$tcc_db" ]; then
  if ! sqlite3 "$tcc_db" \
    "SELECT 1 FROM access WHERE client = 'com.mitchellh.ghostty' AND service = 'kTCCServiceSystemPolicyAllFiles' AND auth_value = 2;" 2>/dev/null | grep -q 1; then
    missing+=("Full Disk Access")
  fi
else
  echo "Warning: Could not read TCC database at $tcc_db, unable to check permissions"
  missing+=("Full Disk Access")
fi

if [ ${#missing[@]} -gt 0 ]; then
  echo ""
  echo "================================================================"
  echo " MANUAL STEPS REMINDER"
  echo "================================================================"
  echo ""
  echo " Grant the following permissions to Ghostty in"
  echo " System Settings > Privacy & Security:"
  echo ""
  for item in "${missing[@]}"; do
    echo "   - $item"
  done
  echo ""
  echo "================================================================"
fi
