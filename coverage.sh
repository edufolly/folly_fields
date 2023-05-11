#!/bin/sh

rm -rf coverage

flutter test --coverage \
  -r github \
  -j $(grep -c processor /proc/cpuinfo)

genhtml coverage/lcov.info \
  --output-directory coverage/html \
  --title "Folly Fields" \
  --show-details

/opt/google/chrome/chrome coverage/html/index.html &
